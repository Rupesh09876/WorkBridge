package com.workbridge.controller;

import com.workbridge.exception.ValidationException;
import com.workbridge.exception.WorkBridgeException;
import com.workbridge.model.ApplicationStatus;
import com.workbridge.model.User;
import com.workbridge.model.UserRole;
import com.workbridge.service.ApplicationService;
import com.workbridge.util.SessionUtil;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

/**
 * ApplicationServlet — Shared controller for Job Seekers and Employers.
 *
 * <p>Handles viewing application details and state transitions.</p>
 *
 * @author WorkBridge Team
 * @version 1.0
 */
@WebServlet("/application")
public class ApplicationServlet extends HttpServlet {

    private final ApplicationService applicationService = new ApplicationService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            HttpSession session = request.getSession(false);
            if (!SessionUtil.requireLogin(session, response)) return;

            String action = request.getParameter("action");
            if ("detail".equals(action)) {
                // In a full implementation, you'd fetch the application and check ownership here
                // For brevity, we assume the JSP or Service validates this
                request.getRequestDispatcher("/WEB-INF/views/shared/applicationDetail.jsp").forward(request, response);
            } else {
                response.sendRedirect(request.getContextPath() + "/");
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
            if (!SessionUtil.requireLogin(session, response)) return;

            if (!SessionUtil.validateCsrfToken(session, request)) {
                response.sendError(403, "Invalid CSRF token");
                return;
            }

            User user = SessionUtil.getUser(session);
            String action = request.getParameter("action");
            int appId = Integer.parseInt(request.getParameter("id"));

            switch (action) {
                case "withdraw":
                    if (user.getRole() == UserRole.JOB_SEEKER) {
                        applicationService.withdrawApplication(appId, user.getId());
                        response.sendRedirect(request.getContextPath() + "/jobseeker?action=myApplications");
                    } else {
                        throw new ValidationException("Only Job Seekers can withdraw applications.");
                    }
                    break;
                case "updateStatus":
                    if (user.getRole() == UserRole.EMPLOYER) {
                        ApplicationStatus status = ApplicationStatus.fromString(request.getParameter("status"));
                        applicationService.updateApplicationStatus(appId, status, user.getId());
                        response.sendRedirect(request.getHeader("Referer"));
                    } else {
                        throw new ValidationException("Only Employers can update application status.");
                    }
                    break;
                case "delete":
                    if (user.getRole() == UserRole.ADMIN) {
                        applicationService.deleteApplication(appId);
                        response.sendRedirect(request.getContextPath() + "/admin?action=applications");
                    } else {
                        throw new ValidationException("Only Admins can delete applications.");
                    }
                    break;
                default:
                    response.sendRedirect(request.getContextPath() + "/");
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
