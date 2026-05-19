package com.workbridge.dao;

import com.workbridge.exception.DatabaseException;
import com.workbridge.model.SavedJob;
import com.workbridge.util.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

/**
 * SavedJobDAO — Data Access Object for the SavedJob entity.
 *
 * <p>Handles database operations for the 'saved_jobs' table.</p>
 *
 * @author WorkBridge Team
 * @version 1.0
 */
public class SavedJobDAO {

    /**
     * Helper method to map a ResultSet row to a SavedJob object.
     *
     * @param rs the ResultSet pointing to a valid row
     * @return the mapped SavedJob object
     * @throws SQLException if a database access error occurs
     */
    private SavedJob mapResultSet(ResultSet rs) throws SQLException {
        SavedJob saved = new SavedJob();
        saved.setId(rs.getInt("id"));
        saved.setUserId(rs.getInt("user_id"));
        saved.setJobId(rs.getInt("job_id"));
        saved.setSavedAt(rs.getTimestamp("saved_at").toLocalDateTime());
        return saved;
    }

    /**
     * Retrieves all saved jobs for a specific user.
     *
     * @param userId the user ID
     * @return a list of saved jobs
     */
    public List<SavedJob> findByUser(int userId) {
        List<SavedJob> list = new ArrayList<>();
        String sql = "SELECT * FROM saved_jobs WHERE user_id = ? ORDER BY saved_at DESC";
        try (Connection c = DBConnection.getConnection();
             PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setInt(1, userId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) list.add(mapResultSet(rs));
            }
        } catch (SQLException e) {
            throw DatabaseException.wrap("findByUser", e);
        }
        return list;
    }

    /**
     * Saves a job for a user.
     *
     * @param userId the user ID
     * @param jobId  the job ID
     * @return true if saved successfully, false if already saved
     */
    public boolean save(int userId, int jobId) {
        String sql = "INSERT IGNORE INTO saved_jobs (user_id, job_id) VALUES (?, ?)";
        try (Connection c = DBConnection.getConnection();
             PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setInt(1, userId);
            ps.setInt(2, jobId);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            throw DatabaseException.wrap("save", e);
        }
    }

    /**
     * Removes a saved job for a user.
     *
     * @param userId the user ID
     * @param jobId  the job ID
     * @return true if unsaved successfully
     */
    public boolean unsave(int userId, int jobId) {
        String sql = "DELETE FROM saved_jobs WHERE user_id = ? AND job_id = ?";
        try (Connection c = DBConnection.getConnection();
             PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setInt(1, userId);
            ps.setInt(2, jobId);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            throw DatabaseException.wrap("unsave", e);
        }
    }

    /**
     * Checks if a user has saved a specific job.
     *
     * @param userId the user ID
     * @param jobId  the job ID
     * @return true if saved
     */
    public boolean isSaved(int userId, int jobId) {
        String sql = "SELECT 1 FROM saved_jobs WHERE user_id = ? AND job_id = ?";
        try (Connection c = DBConnection.getConnection();
             PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setInt(1, userId);
            ps.setInt(2, jobId);
            try (ResultSet rs = ps.executeQuery()) {
                return rs.next();
            }
        } catch (SQLException e) {
            throw DatabaseException.wrap("isSaved", e);
        }
    }
}
