package com.workbridge.dao;

import com.workbridge.exception.DatabaseException;
import com.workbridge.model.JobListing;
import com.workbridge.model.JobType;
import com.workbridge.util.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

/**
 * JobDAO — Data Access Object for the JobListing entity.
 *
 * <p>Handles all database operations for the 'job_listings' table.</p>
 *
 * @author WorkBridge Team
 * @version 1.0
 */
public class JobDAO {

    /**
     * Helper method to map a ResultSet row to a JobListing object.
     *
     * @param rs the ResultSet pointing to a valid row
     * @return the mapped JobListing object
     * @throws SQLException if a database access error occurs
     */
    private JobListing mapResultSet(ResultSet rs) throws SQLException {
        JobListing job = new JobListing();
        job.setId(rs.getInt("id"));
        job.setEmployerId(rs.getInt("employer_id"));
        job.setCategoryId(rs.getInt("category_id"));
        job.setTitle(rs.getString("title"));
        job.setDescription(rs.getString("description"));
        job.setRequirements(rs.getString("requirements"));
        job.setLocation(rs.getString("location"));
        job.setSalaryRange(rs.getString("salary_range"));
        job.setJobType(rs.getString("job_type") != null ? JobType.fromString(rs.getString("job_type")) : null);
        job.setStatus(rs.getString("status"));
        Date deadline = rs.getDate("deadline");
        job.setDeadline(deadline != null ? deadline.toLocalDate() : null);
        job.setCreatedAt(rs.getTimestamp("created_at").toLocalDateTime());
        job.setUpdatedAt(rs.getTimestamp("updated_at").toLocalDateTime());
        return job;
    }

    /**
     * Finds a job listing by its unique ID.
     *
     * @param id the job ID
     * @return the JobListing object, or null if not found
     */
    public JobListing findById(int id) {
        String sql = "SELECT * FROM job_listings WHERE id = ?";
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
     * Retrieves all job listings.
     *
     * @return a list of all job listings
     */
    public List<JobListing> findAll() {
        List<JobListing> list = new ArrayList<>();
        String sql = "SELECT * FROM job_listings ORDER BY created_at DESC";
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
     * Retrieves all job listings posted by a specific employer.
     *
     * @param employerId the employer ID
     * @return a list of job listings
     */
    public List<JobListing> findByEmployer(int employerId) {
        List<JobListing> list = new ArrayList<>();
        String sql = "SELECT * FROM job_listings WHERE employer_id = ? ORDER BY created_at DESC";
        try (Connection c = DBConnection.getConnection();
             PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setInt(1, employerId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) list.add(mapResultSet(rs));
            }
        } catch (SQLException e) {
            throw DatabaseException.wrap("findByEmployer", e);
        }
        return list;
    }

    /**
     * Retrieves all job listings belonging to a specific category.
     *
     * @param categoryId the category ID
     * @return a list of job listings
     */
    public List<JobListing> findByCategory(int categoryId) {
        List<JobListing> list = new ArrayList<>();
        String sql = "SELECT * FROM job_listings WHERE category_id = ? ORDER BY created_at DESC";
        try (Connection c = DBConnection.getConnection();
             PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setInt(1, categoryId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) list.add(mapResultSet(rs));
            }
        } catch (SQLException e) {
            throw DatabaseException.wrap("findByCategory", e);
        }
        return list;
    }

    /**
     * Retrieves all OPEN job listings.
     *
     * @return a list of OPEN job listings
     */
    public List<JobListing> findOpen() {
        List<JobListing> list = new ArrayList<>();
        String sql = "SELECT * FROM job_listings WHERE status = 'OPEN' ORDER BY created_at DESC";
        try (Connection c = DBConnection.getConnection();
             PreparedStatement ps = c.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) list.add(mapResultSet(rs));
        } catch (SQLException e) {
            throw DatabaseException.wrap("findOpen", e);
        }
        return list;
    }

    /**
     * Searches for open job listings using keyword and optional filters.
     *
     * @param keyword    the search keyword (searches title, description, location)
     * @param location   the exact or partial location match (optional)
     * @param type       the job type (optional)
     * @param categoryId the category ID (optional, 0 to skip)
     * @return a list of matching job listings
     */
    public List<JobListing> search(String keyword, String location, JobType type, int categoryId) {
        List<JobListing> list = new ArrayList<>();
        StringBuilder sql = new StringBuilder("SELECT * FROM job_listings WHERE status = 'OPEN'");

        String processedKeyword = null;
        if (keyword != null && !keyword.trim().isEmpty()) {
            // Sanitize keyword for BOOLEAN MODE: remove special operators to avoid syntax errors
            // but keep alphanumeric characters and spaces.
            String sanitized = keyword.trim().replaceAll("[+\\-><()~*]", " ").trim();
            if (!sanitized.isEmpty()) {
                // Transform into "word1* word2*" for partial matching
                String[] words = sanitized.split("\\s+");
                StringBuilder queryBuilder = new StringBuilder();
                for (String w : words) {
                    if (w.length() >= 2) {
                        queryBuilder.append(w).append("* ");
                    } else {
                        queryBuilder.append(w).append(" ");
                    }
                }
                processedKeyword = queryBuilder.toString().trim();
                sql.append(" AND MATCH(title, description, location) AGAINST(? IN BOOLEAN MODE)");
            }
        }

        if (location != null && !location.trim().isEmpty()) {
            sql.append(" AND location LIKE ?");
        }
        if (type != null) {
            sql.append(" AND job_type = ?");
        }
        if (categoryId > 0) {
            sql.append(" AND category_id = ?");
        }
        sql.append(" ORDER BY created_at DESC");

        try (Connection c = DBConnection.getConnection();
             PreparedStatement ps = c.prepareStatement(sql.toString())) {
            int paramIndex = 1;
            if (processedKeyword != null) {
                ps.setString(paramIndex++, processedKeyword);
            }
            if (location != null && !location.trim().isEmpty()) {
                ps.setString(paramIndex++, "%" + location.trim() + "%");
            }
            if (type != null) {
                ps.setString(paramIndex++, type.name());
            }
            if (categoryId > 0) {
                ps.setInt(paramIndex++, categoryId);
            }

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) list.add(mapResultSet(rs));
            }
        } catch (SQLException e) {
            throw DatabaseException.wrap("search", e);
        }
        return list;
    }

    /**
     * Inserts a new job listing.
     *
     * @param job the JobListing to insert
     * @return the generated ID
     */
    public int insert(JobListing job) {
        String sql = "INSERT INTO job_listings (employer_id, category_id, title, description, requirements, location, salary_range, job_type, status, deadline) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
        try (Connection c = DBConnection.getConnection();
             PreparedStatement ps = c.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            ps.setInt(1, job.getEmployerId());
            if (job.getCategoryId() > 0) {
                ps.setInt(2, job.getCategoryId());
            } else {
                ps.setNull(2, Types.INTEGER);
            }
            ps.setString(3, job.getTitle());
            ps.setString(4, job.getDescription());
            ps.setString(5, job.getRequirements());
            ps.setString(6, job.getLocation());
            ps.setString(7, job.getSalaryRange());
            ps.setString(8, job.getJobType() != null ? job.getJobType().name() : null);
            ps.setString(9, job.getStatus());
            if (job.getDeadline() != null) {
                ps.setDate(10, Date.valueOf(job.getDeadline()));
            } else {
                ps.setNull(10, Types.DATE);
            }

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
     * Updates an existing job listing.
     *
     * @param job the JobListing to update
     * @return true if updated successfully
     */
    public boolean update(JobListing job) {
        String sql = "UPDATE job_listings SET category_id = ?, title = ?, description = ?, requirements = ?, location = ?, salary_range = ?, job_type = ?, status = ?, deadline = ? WHERE id = ?";
        try (Connection c = DBConnection.getConnection();
             PreparedStatement ps = c.prepareStatement(sql)) {
            if (job.getCategoryId() > 0) {
                ps.setInt(1, job.getCategoryId());
            } else {
                ps.setNull(1, Types.INTEGER);
            }
            ps.setString(2, job.getTitle());
            ps.setString(3, job.getDescription());
            ps.setString(4, job.getRequirements());
            ps.setString(5, job.getLocation());
            ps.setString(6, job.getSalaryRange());
            ps.setString(7, job.getJobType() != null ? job.getJobType().name() : null);
            ps.setString(8, job.getStatus());
            if (job.getDeadline() != null) {
                ps.setDate(9, Date.valueOf(job.getDeadline()));
            } else {
                ps.setNull(9, Types.DATE);
            }
            ps.setInt(10, job.getId());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            throw DatabaseException.wrap("update", e);
        }
    }

    /**
     * Updates the status of a job listing.
     *
     * @param id     the job ID
     * @param status the new status (e.g. CLOSED)
     * @return true if updated successfully
     */
    public boolean updateStatus(int id, String status) {
        String sql = "UPDATE job_listings SET status = ? WHERE id = ?";
        try (Connection c = DBConnection.getConnection();
             PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setString(1, status);
            ps.setInt(2, id);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            throw DatabaseException.wrap("updateStatus", e);
        }
    }

    /**
     * Deletes a job listing.
     *
     * @param id the job ID
     * @return true if deleted successfully
     */
    public boolean delete(int id) {
        String sql = "DELETE FROM job_listings WHERE id = ?";
        try (Connection c = DBConnection.getConnection();
             PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setInt(1, id);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            throw DatabaseException.wrap("delete", e);
        }
    }

    /**
     * Counts the total job listings posted by an employer.
     *
     * @param employerId the employer ID
     * @return the total count
     */
    public int countByEmployer(int employerId) {
        String sql = "SELECT COUNT(*) FROM job_listings WHERE employer_id = ?";
        try (Connection c = DBConnection.getConnection();
             PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setInt(1, employerId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) return rs.getInt(1);
            }
        } catch (SQLException e) {
            throw DatabaseException.wrap("countByEmployer", e);
        }
        return 0;
    }

    /**
     * Counts the total number of OPEN job listings.
     *
     * @return the open count
     */
    public int countOpen() {
        String sql = "SELECT COUNT(*) FROM job_listings WHERE status = 'OPEN'";
        try (Connection c = DBConnection.getConnection();
             PreparedStatement ps = c.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            if (rs.next()) return rs.getInt(1);
        } catch (SQLException e) {
            throw DatabaseException.wrap("countOpen", e);
        }
        return 0;
    }
}
