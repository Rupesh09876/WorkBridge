package com.workbridge.dao;

import com.workbridge.exception.DatabaseException;
import com.workbridge.model.JobCategory;
import com.workbridge.util.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

/**
 * CategoryDAO — Data Access Object for the JobCategory entity.
 *
 * <p>Handles database operations for the 'job_categories' table.</p>
 *
 * @author WorkBridge Team
 * @version 1.0
 */
public class CategoryDAO {

    /**
     * Helper method to map a ResultSet row to a JobCategory object.
     *
     * @param rs the ResultSet pointing to a valid row
     * @return the mapped JobCategory object
     * @throws SQLException if a database access error occurs
     */
    private JobCategory mapResultSet(ResultSet rs) throws SQLException {
        JobCategory category = new JobCategory();
        category.setId(rs.getInt("id"));
        category.setName(rs.getString("name"));
        category.setDescription(rs.getString("description"));
        return category;
    }

    /**
     * Retrieves all job categories.
     *
     * @return a list of all categories
     */
    public List<JobCategory> findAll() {
        List<JobCategory> list = new ArrayList<>();
        String sql = "SELECT * FROM job_categories ORDER BY name";
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
     * Finds a category by its ID.
     *
     * @param id the category ID
     * @return the JobCategory, or null if not found
     */
    public JobCategory findById(int id) {
        String sql = "SELECT * FROM job_categories WHERE id = ?";
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
     * Finds a category by its exact name.
     *
     * @param name the category name
     * @return the JobCategory, or null if not found
     */
    public JobCategory findByName(String name) {
        String sql = "SELECT * FROM job_categories WHERE name = ?";
        try (Connection c = DBConnection.getConnection();
             PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setString(1, name);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) return mapResultSet(rs);
            }
        } catch (SQLException e) {
            throw DatabaseException.wrap("findByName", e);
        }
        return null;
    }

    /**
     * Checks if a category exists by name.
     *
     * @param name the category name
     * @return true if exists
     */
    public boolean existsByName(String name) {
        String sql = "SELECT 1 FROM job_categories WHERE name = ?";
        try (Connection c = DBConnection.getConnection();
             PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setString(1, name);
            try (ResultSet rs = ps.executeQuery()) {
                return rs.next();
            }
        } catch (SQLException e) {
            throw DatabaseException.wrap("existsByName", e);
        }
    }

    /**
     * Inserts a new job category.
     *
     * @param category the JobCategory to insert
     * @return the generated ID
     */
    public int insert(JobCategory category) {
        String sql = "INSERT INTO job_categories (name, description) VALUES (?, ?)";
        try (Connection c = DBConnection.getConnection();
             PreparedStatement ps = c.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            ps.setString(1, category.getName());
            ps.setString(2, category.getDescription());
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
     * Updates an existing job category.
     *
     * @param category the JobCategory to update
     * @return true if updated successfully
     */
    public boolean update(JobCategory category) {
        String sql = "UPDATE job_categories SET name = ?, description = ? WHERE id = ?";
        try (Connection c = DBConnection.getConnection();
             PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setString(1, category.getName());
            ps.setString(2, category.getDescription());
            ps.setInt(3, category.getId());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            throw DatabaseException.wrap("update", e);
        }
    }

    /**
     * Deletes a job category.
     *
     * @param id the category ID
     * @return true if deleted successfully
     */
    public boolean delete(int id) {
        String sql = "DELETE FROM job_categories WHERE id = ?";
        try (Connection c = DBConnection.getConnection();
             PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setInt(1, id);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            throw DatabaseException.wrap("delete", e);
        }
    }
}
