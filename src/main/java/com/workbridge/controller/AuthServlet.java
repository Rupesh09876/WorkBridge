package com.workbridge.controller;

import com.workbridge.exception.AuthException;
import com.workbridge.exception.ValidationException;
import com.workbridge.exception.WorkBridgeException;
import com.workbridge.model.User;
import com.workbridge.model.UserRole;
import com.workbridge.service.AuthService;
import com.workbridge.util.InputValidator;
import com.workbridge.util.SessionUtil;
import com.workbridge.service.NotificationService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

/**
 * AuthServlet — Controller for authentication flows.
 *
 * <p>Handles login, registration, and logout actions.</p>
 *
 * @author WorkBridge Team
 * @version 1.0
 */
@WebServlet("/auth")
public class AuthServlet extends HttpServlet {

    private final AuthService authService = new AuthService();
    private final NotificationService notificationService = new NotificationService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            String action = request.getParameter("action");
            if (action == null) action = "login";

            switch (action) {
                case "register":
                    request.getRequestDispatcher("/WEB-INF/views/auth/register.jsp").forward(request, response);
                    break;
                case "login":
                default:
                    // Pass any error param as request attribute
                    String error = request.getParameter("error");
                    if (error != null) {
                        if ("pending".equals(error)) {
                            request.setAttribute("error", "Your account is pending admin approval.");
                        } else if ("suspended".equals(error)) {
                            request.setAttribute("error", "Your account has been suspended.");
                        } else {
                            request.setAttribute("error", error);
                        }
                    }
                    request.getRequestDispatcher("/WEB-INF/views/auth/login.jsp").forward(request, response);
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
            String action = request.getParameter("action");

            if ("logout".equals(action)) {
                // CSRF check is often skipped for simple logout, but good practice to include if using POST
                if (!SessionUtil.validateCsrfToken(request.getSession(false), request)) {
                    response.sendError(403, "Invalid CSRF token");
                    return;
                }
                authService.logout(request.getSession(false));
                response.sendRedirect(request.getContextPath() + "/auth?action=login");
                return;
            }

            if ("login".equals(action)) {
                // Step 1: Read email and password from request
                String email = InputValidator.sanitize(request.getParameter("email"));
                String password = request.getParameter("password"); // Do not sanitize passwords

                try {
                    // Step 2: Call AuthService.login()
                    User user = authService.login(email, password);

                    // Step 3: Set user in session via SessionUtil.setUser()
                    HttpSession session = request.getSession(true);
                    SessionUtil.setUser(session, user);

                    // Step 4: Generate CSRF token for the new session
                    SessionUtil.generateCsrfToken(session);

                    // Notify user of login
                    notificationService.notify(user.getId(), "Successfully logged into the system.");

                    // Step 5: Redirect based on role
                    if (user.getRole() == UserRole.ADMIN) {
                        response.sendRedirect(request.getContextPath() + "/admin?action=dashboard");
                    } else if (user.getRole() == UserRole.EMPLOYER) {
                        response.sendRedirect(request.getContextPath() + "/employer?action=dashboard");
                    } else {
                        response.sendRedirect(request.getContextPath() + "/jobseeker?action=dashboard");
                    }
                } catch (AuthException e) {
                    request.setAttribute("error", e.getMessage());
                    request.getRequestDispatcher("/WEB-INF/views/auth/login.jsp").forward(request, response);
                }
            } else if ("register".equals(action)) {
                // Step 1: Read all form fields
                String fullName = InputValidator.sanitize(request.getParameter("fullName"));
                String email = InputValidator.sanitize(request.getParameter("email"));
                String phone = InputValidator.sanitize(request.getParameter("phone"));
                String password = request.getParameter("password");
                String confirmPassword = request.getParameter("confirmPassword");
                String roleStr = request.getParameter("role");

                try {
                    // Prevent admin registration from form
                    UserRole role = UserRole.fromString(roleStr);
                    if (role == UserRole.ADMIN) {
                        throw new ValidationException("Cannot register as Admin.");
                    }

                    // Step 3: Call AuthService.register()
                    authService.register(fullName, email, phone, password, confirmPassword, role);

                    // Step 4: On success forward to login.jsp
                    request.setAttribute("success", "Registration successful! You can now log in.");
                    request.getRequestDispatcher("/WEB-INF/views/auth/login.jsp").forward(request, response);
                } catch (ValidationException e) {
                    request.setAttribute("fieldErrors", e.getFieldErrors());
                    request.getRequestDispatcher("/WEB-INF/views/auth/register.jsp").forward(request, response);
                } catch (AuthException e) {
                    request.setAttribute("error", e.getMessage());
                    request.getRequestDispatcher("/WEB-INF/views/auth/register.jsp").forward(request, response);
                } catch (IllegalArgumentException e) {
                    request.setAttribute("error", "Invalid role selected.");
                    request.getRequestDispatcher("/WEB-INF/views/auth/register.jsp").forward(request, response);
                }
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
