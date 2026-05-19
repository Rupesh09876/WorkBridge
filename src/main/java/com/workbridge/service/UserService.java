package com.workbridge.service;

import com.workbridge.dao.ApplicationDAO;
import com.workbridge.dao.JobDAO;
import com.workbridge.dao.UserDAO;
import com.workbridge.exception.ResourceNotFoundException;
import com.workbridge.exception.ValidationException;
import com.workbridge.model.User;
import com.workbridge.model.UserRole;
import com.workbridge.model.UserStatus;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * UserService — Handles business logic related to User management.
 *
 * <p>Used primarily by administrators to view, approve, suspend, or delete users.</p>
 *
 * @author WorkBridge Team
 * @version 1.0
 */
public class UserService {

    private final UserDAO userDAO = new UserDAO();
    private final JobDAO jobDAO = new JobDAO();
    private final ApplicationDAO applicationDAO = new ApplicationDAO();

    /**
     * Retrieves all users.
     *
     * @return list of users
     */
    public List<User> getAllUsers() {
        return userDAO.findAll();
    }

    /**
     * Retrieves a user by ID.
     *
     * @param id the user ID
     * @return the User
     * @throws ResourceNotFoundException if user doesn't exist
     */
    public User getUserById(int id) {
        User user = userDAO.findById(id);
        if (user == null) {
            throw new ResourceNotFoundException("User", id);
        }
        return user;
    }

    /**
     * Approves a pending user account.
     *
     * @param id the user ID
     */
    public void approveUser(int id) {
        User user = getUserById(id);
        if (user.getStatus() != UserStatus.ACTIVE) {
            userDAO.updateStatus(id, UserStatus.ACTIVE);
        }
    }

    /**
     * Suspends an active user account.
     *
     * @param id the user ID
     * @throws ValidationException if trying to suspend an Admin
     */
    public void suspendUser(int id) {
        User user = getUserById(id);
        if (user.getRole() == UserRole.ADMIN) {
            throw new ValidationException("Cannot suspend an administrator account.");
        }
        if (user.getStatus() != UserStatus.SUSPENDED) {
            userDAO.updateStatus(id, UserStatus.SUSPENDED);
        }
    }

    /**
     * Deletes a user account.
     *
     * @param id the user ID
     * @throws ValidationException if trying to delete an Admin
     */
    public void deleteUser(int id) {
        User user = getUserById(id);
        if (user.getRole() == UserRole.ADMIN) {
            throw new ValidationException("Cannot delete an administrator account.");
        }
        userDAO.delete(id);
    }

    /**
     * Retrieves users by a specific role.
     *
     * @param role the UserRole
     * @return list of users
     */
    public List<User> getUsersByRole(UserRole role) {
        return userDAO.findByRole(role);
    }

    /**
     * Retrieves all users currently pending approval.
     *
     * @return list of pending users
     */
    public List<User> getPendingUsers() {
        return userDAO.findByStatus(UserStatus.PENDING);
    }

    /**
     * Generates statistics for the admin dashboard.
     *
     * @return a map containing various system counts
     */
    public Map<String, Integer> getDashboardStats() {
        Map<String, Integer> stats = new HashMap<>();
        stats.put("totalUsers", userDAO.countAll());
        stats.put("activeUsers", userDAO.countByStatus(UserStatus.ACTIVE));
        stats.put("pendingUsers", userDAO.countByStatus(UserStatus.PENDING));
        stats.put("totalJobs", jobDAO.findAll().size()); // Basic approach
        stats.put("openJobs", jobDAO.countOpen());
        stats.put("totalApplications", applicationDAO.countAll());
        return stats;
    }
}
