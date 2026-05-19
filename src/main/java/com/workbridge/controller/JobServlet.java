package com.workbridge.controller;

import com.workbridge.exception.WorkBridgeException;
import com.workbridge.model.User;
import com.workbridge.service.JobService;
import com.workbridge.util.SessionUtil;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

/**
 * JobServlet — Public controller for viewing job listings.
 *
 * <p>Allows unauthenticated access to browse jobs, redirecting to
 * specific seeker pages if logged in.</p>
 *
 * @author WorkBridge Team
 * @version 1.0
 */
@WebServlet("/job")
public class JobServlet extends HttpServlet {

    private final JobService jobService = new JobService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            String action = request.getParameter("action");
            if (action == null) action = "list";

            HttpSession session = request.getSession(false);
            User user = SessionUtil.getUser(session);

            if (user != null && user.getRole() == com.workbridge.model.UserRole.JOB_SEEKER) {
                // Redirect logged-in seekers to the seeker namespace
                if ("detail".equals(action)) {
                    response.sendRedirect(request.getContextPath() + "/jobseeker?action=jobDetail&id=" + request.getParameter("id"));
                    return;
                }
                response.sendRedirect(request.getContextPath() + "/jobseeker?action=search");
                return;
            }

            switch (action) {
                case "detail":
                    int jobId = Integer.parseInt(request.getParameter("id"));
                    request.setAttribute("job", jobService.getJobById(jobId));
                    request.getRequestDispatcher("/WEB-INF/views/jobseeker/jobDetails.jsp").forward(request, response);
                    break;
                case "list":
                default:
                    request.setAttribute("jobs", jobService.getAllOpenJobs());
                    request.getRequestDispatcher("/WEB-INF/views/jobseeker/searchJobs.jsp").forward(request, response);
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
}
