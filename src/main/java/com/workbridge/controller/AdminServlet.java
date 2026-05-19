package com.workbridge.controller;

import com.workbridge.exception.WorkBridgeException;
import com.workbridge.model.User;
import com.workbridge.model.UserRole;
import com.workbridge.model.JobCategory;
import com.workbridge.dao.CategoryDAO;
import com.workbridge.service.ApplicationService;
import com.workbridge.service.JobService;
import com.workbridge.service.UserService;
import com.workbridge.service.NotificationService;
import com.workbridge.util.SessionUtil;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

/**
 * AdminServlet — Controller for administrator operations.
 *
 * <p>Handles dashboard viewing, user management, and global job/application deletion.</p>
 *
 * @author WorkBridge Team
 * @version 1.0
 */
@WebServlet("/admin")
public class AdminServlet extends HttpServlet {

    private final UserService userService = new UserService();
    private final JobService jobService = new JobService();
    private final ApplicationService applicationService = new ApplicationService();
    private final CategoryDAO categoryDAO = new CategoryDAO();
    private final NotificationService notificationService = new NotificationService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            HttpSession session = request.getSession(false);
            if (!SessionUtil.requireRole(session, response, request, UserRole.ADMIN)) return;

            String action = request.getParameter("action");
            if (action == null) action = "dashboard";

            switch (action) {
                case "users":
                    request.setAttribute("users", userService.getAllUsers());
                    request.getRequestDispatcher("/WEB-INF/views/admin/manageUsers.jsp").forward(request, response);
                    break;
                case "jobs":
                    request.setAttribute("jobs", jobService.getAllJobs());
                    request.getRequestDispatcher("/WEB-INF/views/admin/manageJobs.jsp").forward(request, response);
                    break;
                case "applications":
                    request.setAttribute("applications", applicationService.getAllApplications());
                    request.getRequestDispatcher("/WEB-INF/views/admin/viewApplications.jsp").forward(request, response);
                    break;
                case "settings":
                    request.getRequestDispatcher("/WEB-INF/views/admin/settings.jsp").forward(request, response);
                    break;
                case "dashboard":
                default:
                    request.setAttribute("stats", userService.getDashboardStats());
                    request.setAttribute("pendingUsers", userService.getPendingUsers());
                    request.getRequestDispatcher("/WEB-INF/views/admin/dashboard.jsp").forward(request, response);
                    break;
                case "categories":
                    request.setAttribute("categories", categoryDAO.findAll());
                    request.getRequestDispatcher("/WEB-INF/views/admin/manageCategories.jsp").forward(request, response);
                    break;
            }
        } catch (WorkBridgeException e) {
            request.setAttribute("error", e.getMessage());
            request.getRequestDispatcher("/WEB-INF/views/common/error.jsp").forward(request, response);
        } catch (Exception e) {
            request.setAttribute("error", "An unexpected error occurred. Please try again.");
            request.getRequestDispatcher("/WEB-INF/views/common/error.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            HttpSession session = request.getSession(false);
            if (!SessionUtil.requireRole(session, response, request, UserRole.ADMIN)) return;

            if (!SessionUtil.validateCsrfToken(session, request)) {
                response.sendError(403, "Invalid CSRF token");
                return;
            }

            String action = request.getParameter("action");
            if (action == null) {
                response.sendRedirect(request.getContextPath() + "/admin?action=dashboard");
                return;
            }

            switch (action) {
                case "approve":
                    userService.approveUser(Integer.parseInt(request.getParameter("id")));
                    notificationService.notify(((User)session.getAttribute("loggedInUser")).getId(), "Approved user ID: " + request.getParameter("id"));
                    response.sendRedirect(request.getContextPath() + "/admin?action=users");
                    break;
                case "suspend":
                    userService.suspendUser(Integer.parseInt(request.getParameter("id")));
                    response.sendRedirect(request.getContextPath() + "/admin?action=users");
                    break;
                case "deleteUser":
                    userService.deleteUser(Integer.parseInt(request.getParameter("id")));
                    response.sendRedirect(request.getContextPath() + "/admin?action=users");
                    break;
                case "deleteJob":
                    jobService.adminDeleteJob(Integer.parseInt(request.getParameter("id")));
                    notificationService.notify(((User)session.getAttribute("loggedInUser")).getId(), "Deleted job ID: " + request.getParameter("id"));
                    response.sendRedirect(request.getContextPath() + "/admin?action=jobs");
                    break;
                case "deleteApplication":
                    applicationService.deleteApplication(Integer.parseInt(request.getParameter("id")));
                    response.sendRedirect(request.getContextPath() + "/admin?action=applications");
                    break;
                case "addCategory":
                    String name = request.getParameter("name");
                    String desc = request.getParameter("description");
                    if (name == null || name.trim().isEmpty()) {
                        throw new WorkBridgeException("Category name cannot be empty.");
                    }
                    if (categoryDAO.findByName(name.trim()) != null) {
                        request.setAttribute("error", "A category with this name already exists.");
                        request.setAttribute("categories", categoryDAO.findAll());
                        request.getRequestDispatcher("/WEB-INF/views/admin/manageCategories.jsp").forward(request, response);
                        return;
                    }
                    JobCategory newCat = new JobCategory();
                    newCat.setName(name.trim());
                    newCat.setDescription(desc != null ? desc.trim() : "");
                    categoryDAO.insert(newCat);
                    response.sendRedirect(request.getContextPath() + "/admin?action=categories&success=added");
                    break;
                case "editCategory":
                    int catId = Integer.parseInt(request.getParameter("id"));
                    String editName = request.getParameter("name");
                    String editDesc = request.getParameter("description");
                    if (editName == null || editName.trim().isEmpty()) {
                        throw new WorkBridgeException("Category name cannot be empty.");
                    }
                    JobCategory existingCat = categoryDAO.findByName(editName.trim());
                    if (existingCat != null && existingCat.getId() != catId) {
                        request.setAttribute("error", "A category with this name already exists.");
                        request.setAttribute("categories", categoryDAO.findAll());
                        request.getRequestDispatcher("/WEB-INF/views/admin/manageCategories.jsp").forward(request, response);
                        return;
                    }
                    JobCategory catToUpdate = new JobCategory();
                    catToUpdate.setId(catId);
                    catToUpdate.setName(editName.trim());
                    catToUpdate.setDescription(editDesc != null ? editDesc.trim() : "");
                    categoryDAO.update(catToUpdate);
                    response.sendRedirect(request.getContextPath() + "/admin?action=categories&success=updated");
                    break;
                case "deleteCategory":
                    int delCatId = Integer.parseInt(request.getParameter("id"));
                    categoryDAO.delete(delCatId);
                    response.sendRedirect(request.getContextPath() + "/admin?action=categories&success=deleted");
                    break;
                default:
                    response.sendRedirect(request.getContextPath() + "/admin?action=dashboard");
            }
        } catch (WorkBridgeException e) {
            request.setAttribute("error", e.getMessage());
            request.getRequestDispatcher("/WEB-INF/views/common/error.jsp").forward(request, response);
        } catch (Exception e) {
            request.setAttribute("error", "An unexpected error occurred. Please try again.");
            request.getRequestDispatcher("/WEB-INF/views/common/error.jsp").forward(request, response);
        }
    }
}
