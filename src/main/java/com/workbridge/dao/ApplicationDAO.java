package com.workbridge.dao;

import com.workbridge.exception.DatabaseException;
import com.workbridge.model.Application;
import com.workbridge.model.ApplicationStatus;
import com.workbridge.util.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

/**
 * ApplicationDAO — Data Access Object for the Application entity.
 *
 * <p>Handles database operations for the 'applications' table.</p>
 *
 * @author WorkBridge Team
 * @version 1.0
 */
public class ApplicationDAO {

    /**
     * Retrieves all applications in the system.
     *
     * @return a list of all applications
     */
    public List<Application> findAll() {
        List<Application> list = new ArrayList<>();
        String sql = "SELECT * FROM applications ORDER BY applied_at DESC";
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
     * Helper method to map a ResultSet row to an Application object.
     *
     * @param rs the ResultSet pointing to a valid row
     * @return the mapped Application object
     * @throws SQLException if a database access error occurs
     */
    private Application mapResultSet(ResultSet rs) throws SQLException {
        Application app = new Application();
        app.setId(rs.getInt("id"));
        app.setJobId(rs.getInt("job_id"));
        app.setApplicantId(rs.getInt("applicant_id"));
        app.setCoverLetter(rs.getString("cover_letter"));
        app.setResumeUrl(rs.getString("resume_url"));
        app.setStatus(ApplicationStatus.fromString(rs.getString("status")));
        app.setAppliedAt(rs.getTimestamp("applied_at").toLocalDateTime());
        app.setUpdatedAt(rs.getTimestamp("updated_at").toLocalDateTime());
        return app;
    }

    /**
     * Finds an application by its unique ID.
     *
     * @param id the application ID
     * @return the Application object, or null if not found
     */
    public Application findById(int id) {
        String sql = "SELECT * FROM applications WHERE id = ?";
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
     * Retrieves all applications for a specific job listing.
     *
     * @param jobId the job ID
     * @return a list of applications
     */
    public List<Application> findByJob(int jobId) {
        List<Application> list = new ArrayList<>();
        String sql = "SELECT * FROM applications WHERE job_id = ? ORDER BY applied_at DESC";
        try (Connection c = DBConnection.getConnection();
             PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setInt(1, jobId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) list.add(mapResultSet(rs));
            }
        } catch (SQLException e) {
            throw DatabaseException.wrap("findByJob", e);
        }
        return list;
    }

    /**
     * Retrieves all applications submitted by a specific job seeker.
     *
     * @param applicantId the user ID of the applicant
     * @return a list of applications
     */
    public List<Application> findByApplicant(int applicantId) {
        List<Application> list = new ArrayList<>();
        String sql = "SELECT * FROM applications WHERE applicant_id = ? ORDER BY applied_at DESC";
        try (Connection c = DBConnection.getConnection();
             PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setInt(1, applicantId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) list.add(mapResultSet(rs));
            }
        } catch (SQLException e) {
            throw DatabaseException.wrap("findByApplicant", e);
        }
        return list;
    }

    /**
     * Finds an application for a specific job by a specific applicant.
     *
     * @param jobId       the job ID
     * @param applicantId the applicant ID
     * @return the Application, or null if not found
     */
    public Application findByJobAndApplicant(int jobId, int applicantId) {
        String sql = "SELECT * FROM applications WHERE job_id = ? AND applicant_id = ?";
        try (Connection c = DBConnection.getConnection();
             PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setInt(1, jobId);
            ps.setInt(2, applicantId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) return mapResultSet(rs);
            }
        } catch (SQLException e) {
            throw DatabaseException.wrap("findByJobAndApplicant", e);
        }
        return null;
    }

    /**
     * Checks if an applicant has already applied to a specific job.
     *
     * @param jobId       the job ID
     * @param applicantId the applicant ID
     * @return true if an application exists, false otherwise
     */
    public boolean existsByJobAndApplicant(int jobId, int applicantId) {
        String sql = "SELECT 1 FROM applications WHERE job_id = ? AND applicant_id = ?";
        try (Connection c = DBConnection.getConnection();
             PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setInt(1, jobId);
            ps.setInt(2, applicantId);
            try (ResultSet rs = ps.executeQuery()) {
                return rs.next();
            }
        } catch (SQLException e) {
            throw DatabaseException.wrap("existsByJobAndApplicant", e);
        }
    }

    /**
     * Inserts a new application into the database.
     *
     * @param app the Application to insert
     * @return the generated application ID
     */
    public int insert(Application app) {
        String sql = "INSERT INTO applications (job_id, applicant_id, cover_letter, resume_url, status) VALUES (?, ?, ?, ?, ?)";
        try (Connection c = DBConnection.getConnection();
             PreparedStatement ps = c.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            ps.setInt(1, app.getJobId());
            ps.setInt(2, app.getApplicantId());
            ps.setString(3, app.getCoverLetter());
            ps.setString(4, app.getResumeUrl());
            ps.setString(5, app.getStatus().name());
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
     * Updates the status of an application.
     *
     * @param id     the application ID
     * @param status the new ApplicationStatus
     * @return true if updated successfully
     */
    public boolean updateStatus(int id, ApplicationStatus status) {
        String sql = "UPDATE applications SET status = ? WHERE id = ?";
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
     * Deletes an application from the database.
     *
     * @param id the application ID
     * @return true if deleted successfully
     */
    public boolean delete(int id) {
        String sql = "DELETE FROM applications WHERE id = ?";
        try (Connection c = DBConnection.getConnection();
             PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setInt(1, id);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            throw DatabaseException.wrap("delete", e);
        }
    }

    /**
     * Counts the total number of applications for a job listing.
     *
     * @param jobId the job ID
     * @return the application count
     */
    public int countByJob(int jobId) {
        String sql = "SELECT COUNT(*) FROM applications WHERE job_id = ?";
        try (Connection c = DBConnection.getConnection();
             PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setInt(1, jobId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) return rs.getInt(1);
            }
        } catch (SQLException e) {
            throw DatabaseException.wrap("countByJob", e);
        }
        return 0;
    }

    /**
     * Counts the total number of applications across all jobs.
     *
     * @return the total application count
     */
    public int countAll() {
        String sql = "SELECT COUNT(*) FROM applications";
        try (Connection c = DBConnection.getConnection();
             PreparedStatement ps = c.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            if (rs.next()) return rs.getInt(1);
        } catch (SQLException e) {
            throw DatabaseException.wrap("countAll", e);
        }
        return 0;
    }
}
