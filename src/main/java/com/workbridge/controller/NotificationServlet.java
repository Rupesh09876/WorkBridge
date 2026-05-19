package com.workbridge.controller;

import com.workbridge.model.Notification;
import com.workbridge.model.User;
import com.workbridge.service.NotificationService;
import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.workbridge.util.LocalDateTimeAdapter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.io.PrintWriter;
import java.time.LocalDateTime;
import java.util.List;

/**
 * NotificationServlet — Handles notification viewing and management.
 */
@WebServlet("/notifications")
public class NotificationServlet extends HttpServlet {

    private final NotificationService notificationService = new NotificationService();
    private final Gson gson = new GsonBuilder()
            .registerTypeAdapter(LocalDateTime.class, new LocalDateTimeAdapter())
            .create();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("loggedInUser") == null) {
            response.sendRedirect(request.getContextPath() + "/auth?action=login");
            return;
        }

        User user = (User) session.getAttribute("loggedInUser");
        String action = request.getParameter("action");

        if ("api_list".equals(action)) {
            List<Notification> notifications = notificationService.getNotificationsForUser(user.getId());
            response.setContentType("application/json");
            PrintWriter out = response.getWriter();
            out.print(this.gson.toJson(notifications));
            out.flush();
            return;
        }

        if ("api_markRead".equals(action)) {
            notificationService.markAllAsRead(user.getId());
            response.setContentType("application/json");
            PrintWriter out = response.getWriter();
            out.print("{\"success\": true}");
            out.flush();
            return;
        }

        if ("markRead".equals(action)) {
            notificationService.markAllAsRead(user.getId());
            response.sendRedirect(request.getContextPath() + "/notifications");
            return;
        }

        if ("delete".equals(action)) {
            int notifId = Integer.parseInt(request.getParameter("id"));
            notificationService.deleteNotification(notifId, user.getId());
            response.sendRedirect(request.getContextPath() + "/notifications");
            return;
        }

        if ("deleteAll".equals(action)) {
            notificationService.deleteAllNotifications(user.getId());
            response.sendRedirect(request.getContextPath() + "/notifications");
            return;
        }

        List<Notification> notifications = notificationService.getNotificationsForUser(user.getId());
        request.setAttribute("notifications", notifications);
        request.getRequestDispatcher("/WEB-INF/views/shared/notifications.jsp").forward(request, response);
    }
}
