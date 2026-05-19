package com.workbridge.service;

import com.workbridge.dao.NotificationDAO;
import com.workbridge.model.Notification;

import java.util.List;

/**
 * NotificationService — Business logic for user notifications.
 */
public class NotificationService {
    private final NotificationDAO notificationDAO = new NotificationDAO();

    public void notify(int userId, String message) {
        Notification n = new Notification();
        n.setUserId(userId);
        n.setMessage(message);
        notificationDAO.insert(n);
    }

    public List<Notification> getNotificationsForUser(int userId) {
        return notificationDAO.findByUser(userId);
    }

    public void markAllAsRead(int userId) {
        notificationDAO.markAsRead(userId);
    }

    public int getUnreadCount(int userId) {
        return notificationDAO.countUnread(userId);
    }

    public void deleteNotification(int notificationId, int userId) {
        notificationDAO.delete(notificationId, userId);
    }

    public void deleteAllNotifications(int userId) {
        notificationDAO.deleteAllByUser(userId);
    }
}
