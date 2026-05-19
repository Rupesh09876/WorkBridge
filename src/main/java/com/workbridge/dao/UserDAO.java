package com.workbridge.dao;

import com.workbridge.exception.DatabaseException;
import com.workbridge.model.User;
import com.workbridge.model.UserRole;
import com.workbridge.model.UserStatus;
import com.workbridge.util.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

/**
 * UserDAO — Data Access Object for the User entity.
 *
 * <p>Handles all database operations for the 'users' table.</p>
 *
 * @author WorkBridge Team
 * @version 1.0
 */
public class UserDAO {

    /**
     * Helper method to map a ResultSet row to a User object.
     *
     * @param rs the ResultSet pointing to a valid row
     * @return the mapped User object
     * @throws SQLException if a database access error occurs
     */
    private User mapResultSet(ResultSet rs) throws SQLException {
        User user = new User();
        user.setId(rs.getInt("id"));
        user.setFullName(rs.getString("full_name"));
        user.setEmail(rs.getString("email"));
        user.setPhone(rs.getString("phone"));
        user.setPasswordHash(rs.getString("password_hash"));
        user.setRole(UserRole.fromString(rs.getString("role")));
        user.setStatus(UserStatus.fromString(rs.getString("status")));
        user.setCreatedAt(rs.getTimestamp("created_at").toLocalDateTime());
        user.setUpdatedAt(rs.getTimestamp("updated_at").toLocalDateTime());
        return user;
    }

    /**
     * Finds a user by their unique ID.
     *
     * @param id the user ID
     * @return the User object, or null if not found
     */
    public User findById(int id) {
        String sql = "SELECT * FROM users WHERE id = ?";
        try (Connection c = DBConnection.getConnection();
             PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) return mapResultSet(rs);
            }
        } catch (SQLException e) {
            throw DatabaseException.wrap("findById", e);
        }
        return null;
    }

    /**
     * Finds a user by their unique email.
     *
     * @param email the email address
     * @return the User object, or null if not found
     */
    public User findByEmail(String email) {
        String sql = "SELECT * FROM users WHERE email = ?";
        try (Connection c = DBConnection.getConnection();
             PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setString(1, email);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) return mapResultSet(rs);
            }
        } catch (SQLException e) {
            throw DatabaseException.wrap("findByEmail", e);
        }
        return null;
    }

    /**
     * Finds a user by their unique phone number.
     *
     * @param phone the phone number
     * @return the User object, or null if not found
     */
    public User findByPhone(String phone) {
        String sql = "SELECT * FROM users WHERE phone = ?";
        try (Connection c = DBConnection.getConnection();
             PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setString(1, phone);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) return mapResultSet(rs);
            }
        } catch (SQLException e) {
            throw DatabaseException.wrap("findByPhone", e);
        }
        return null;
    }

    /**
     * Retrieves all users in the system.
     *
     * @return a list of all users
     */
    public List<User> findAll() {
        List<User> list = new ArrayList<>();
        String sql = "SELECT * FROM users ORDER BY created_at DESC";
        try (Connection c = DBConnection.getConnection();
             PreparedStatement ps = c.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) list.add(mapResultSet(rs));
        } catch (SQLException e) {
            throw DatabaseException.wrap("findAll", e);
        }
        return list;
    }

    /**
     * Retrieves users by their role.
     *
     * @param role the UserRole to filter by
     * @return a list of users matching the role
     */
    public List<User> findByRole(UserRole role) {
        List<User> list = new ArrayList<>();
        String sql = "SELECT * FROM users WHERE role = ? ORDER BY created_at DESC";
        try (Connection c = DBConnection.getConnection();
             PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setString(1, role.name());
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) list.add(mapResultSet(rs));
            }
        } catch (SQLException e) {
            throw DatabaseException.wrap("findByRole", e);
        }
        return list;
    }

    /**
     * Retrieves users by their account status.
     *
     * @param status the UserStatus to filter by
     * @return a list of users matching the status
     */
    public List<User> findByStatus(UserStatus status) {
        List<User> list = new ArrayList<>();
        String sql = "SELECT * FROM users WHERE status = ? ORDER BY created_at DESC";
        try (Connection c = DBConnection.getConnection();
             PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setString(1, status.name());
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) list.add(mapResultSet(rs));
            }
        } catch (SQLException e) {
            throw DatabaseException.wrap("findByStatus", e);
        }
        return list;
    }

    /**
     * Checks if a user exists with the given email.
     *
     * @param email the email to check
     * @return true if exists, false otherwise
     */
    public boolean existsByEmail(String email) {
        String sql = "SELECT 1 FROM users WHERE email = ?";
        try (Connection c = DBConnection.getConnection();
             PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setString(1, email);
            try (ResultSet rs = ps.executeQuery()) {
                return rs.next();
            }
        } catch (SQLException e) {
            throw DatabaseException.wrap("existsByEmail", e);
        }
    }

    /**
     * Checks if a user exists with the given phone number.
     *
     * @param phone the phone number to check
     * @return true if exists, false otherwise
     */
    public boolean existsByPhone(String phone) {
        String sql = "SELECT 1 FROM users WHERE phone = ?";
        try (Connection c = DBConnection.getConnection();
             PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setString(1, phone);
            try (ResultSet rs = ps.executeQuery()) {
                return rs.next();
            }
        } catch (SQLException e) {
            throw DatabaseException.wrap("existsByPhone", e);
        }
    }

    /**
     * Inserts a new user into the database.
     *
     * @param user the User to insert
     * @return the generated ID of the new user
     */
    public int insert(User user) {
        String sql = "INSERT INTO users (full_name, email, phone, password_hash, role, status) VALUES (?, ?, ?, ?, ?, ?)";
        try (Connection c = DBConnection.getConnection();
             PreparedStatement ps = c.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            ps.setString(1, user.getFullName());
            ps.setString(2, user.getEmail());
            ps.setString(3, user.getPhone());
            ps.setString(4, user.getPasswordHash());
            ps.setString(5, user.getRole().name());
            ps.setString(6, user.getStatus().name());
            ps.executeUpdate();
            try (ResultSet rs = ps.getGeneratedKeys()) {
                if (rs.next()) return rs.getInt(1);
            }
        } catch (SQLException e) {
            throw DatabaseException.wrap("insert", e);
        }
        return 0;
    }

    /**
     * Updates an existing user's details.
     *
     * @param user the User to update
     * @return true if updated successfully, false otherwise
     */
    public boolean update(User user) {
        String sql = "UPDATE users SET full_name = ?, phone = ?, role = ?, status = ? WHERE id = ?";
        try (Connection c = DBConnection.getConnection();
             PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setString(1, user.getFullName());
            ps.setString(2, user.getPhone());
            ps.setString(3, user.getRole().name());
            ps.setString(4, user.getStatus().name());
            ps.setInt(5, user.getId());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            throw DatabaseException.wrap("update", e);
        }
    }

    /**
     * Updates just the status of a user.
     *
     * @param id     the user ID
     * @param status the new UserStatus
     * @return true if updated successfully, false otherwise
     */
    public boolean updateStatus(int id, UserStatus status) {
        String sql = "UPDATE users SET status = ? WHERE id = ?";
        try (Connection c = DBConnection.getConnection();
             PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setString(1, status.name());
            ps.setInt(2, id);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            throw DatabaseException.wrap("updateStatus", e);
        }
    }

    /**
     * Updates only the password hash for a user.
     *
     * @param id           the user ID
     * @param passwordHash the new hashed password
     * @return true if updated successfully
     */
    public boolean updatePassword(int id, String passwordHash) {
        String sql = "UPDATE users SET password_hash = ? WHERE id = ?";
        try (Connection c = DBConnection.getConnection();
             PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setString(1, passwordHash);
            ps.setInt(2, id);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            throw DatabaseException.wrap("updatePassword", e);
        }
    }

    /**
     * Deletes a user from the database.
     *
     * @param id the user ID
     * @return true if deleted successfully, false otherwise
     */
    public boolean delete(int id) {
        String sql = "DELETE FROM users WHERE id = ?";
        try (Connection c = DBConnection.getConnection();
             PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setInt(1, id);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            throw DatabaseException.wrap("delete", e);
        }
    }

    /**
     * Counts the total number of users.
     *
     * @return the total user count
     */
    public int countAll() {
        String sql = "SELECT COUNT(*) FROM users";
        try (Connection c = DBConnection.getConnection();
             PreparedStatement ps = c.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            if (rs.next()) return rs.getInt(1);
        } catch (SQLException e) {
            throw DatabaseException.wrap("countAll", e);
        }
        return 0;
    }

    /**
     * Counts the number of users with a specific status.
     *
     * @param status the UserStatus to count
     * @return the count of matching users
     */
    public int countByStatus(UserStatus status) {
        String sql = "SELECT COUNT(*) FROM users WHERE status = ?";
        try (Connection c = DBConnection.getConnection();
             PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setString(1, status.name());
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) return rs.getInt(1);
            }
        } catch (SQLException e) {
            throw DatabaseException.wrap("countByStatus", e);
        }
        return 0;
    }
}
