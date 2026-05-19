package com.workbridge.dao;

import com.workbridge.exception.DatabaseException;
import com.workbridge.model.EmployerProfile;
import com.workbridge.model.JobSeekerProfile;
import com.workbridge.util.DBConnection;

import java.sql.*;

/**
 * ProfileDAO — Data Access Object for User Profiles.
 *
 * <p>Handles database operations for both 'jobseeker_profiles' and 'employer_profiles' tables.</p>
 *
 * @author WorkBridge Team
 * @version 1.0
 */
public class ProfileDAO {

    /**
     * Finds a JobSeekerProfile by the associated user ID.
     *
     * @param userId the user ID
     * @return the JobSeekerProfile, or null if not found
     */
    public JobSeekerProfile findJobSeekerByUserId(int userId) {
        String sql = "SELECT * FROM jobseeker_profiles WHERE user_id = ?";
        try (Connection c = DBConnection.getConnection();
             PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setInt(1, userId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    JobSeekerProfile p = new JobSeekerProfile();
                    p.setId(rs.getInt("id"));
                    p.setUserId(rs.getInt("user_id"));
                    p.setHeadline(rs.getString("headline"));
                    p.setSummary(rs.getString("summary"));
                    p.setSkills(rs.getString("skills"));
                    p.setEducation(rs.getString("education"));
                    p.setExperience(rs.getString("experience"));
                    p.setResumeUrl(rs.getString("resume_url"));
                    p.setLocation(rs.getString("location"));
                    p.setPhone(rs.getString("phone"));
                    p.setLinkedinUrl(rs.getString("linkedin_url"));
                    p.setUpdatedAt(rs.getTimestamp("updated_at").toLocalDateTime());
                    return p;
                }
            }
        } catch (SQLException e) {
            throw DatabaseException.wrap("findJobSeekerByUserId", e);
        }
        return null;
    }

    /**
     * Finds an EmployerProfile by the associated user ID.
     *
     * @param userId the user ID
     * @return the EmployerProfile, or null if not found
     */
    public EmployerProfile findEmployerByUserId(int userId) {
        String sql = "SELECT * FROM employer_profiles WHERE user_id = ?";
        try (Connection c = DBConnection.getConnection();
             PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setInt(1, userId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    EmployerProfile p = new EmployerProfile();
                    p.setId(rs.getInt("id"));
                    p.setUserId(rs.getInt("user_id"));
                    p.setCompanyName(rs.getString("company_name"));
                    p.setCompanyDescription(rs.getString("company_description"));
                    p.setIndustry(rs.getString("industry"));
                    p.setWebsiteUrl(rs.getString("website_url"));
                    p.setLogoUrl(rs.getString("logo_url"));
                    p.setLocation(rs.getString("location"));
                    p.setFoundedYear(rs.getInt("founded_year"));
                    p.setUpdatedAt(rs.getTimestamp("updated_at").toLocalDateTime());
                    return p;
                }
            }
        } catch (SQLException e) {
            throw DatabaseException.wrap("findEmployerByUserId", e);
        }
        return null;
    }

    /**
     * Inserts a new JobSeekerProfile.
     *
     * @param p the JobSeekerProfile to insert
     * @return the generated ID
     */
    public int insertJobSeeker(JobSeekerProfile p) {
        String sql = "INSERT INTO jobseeker_profiles (user_id, headline, summary, skills, education, experience, resume_url, location, phone, linkedin_url) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
        try (Connection c = DBConnection.getConnection();
             PreparedStatement ps = c.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            ps.setInt(1, p.getUserId());
            ps.setString(2, p.getHeadline());
            ps.setString(3, p.getSummary());
            ps.setString(4, p.getSkills());
            ps.setString(5, p.getEducation());
            ps.setString(6, p.getExperience());
            ps.setString(7, p.getResumeUrl());
            ps.setString(8, p.getLocation());
            ps.setString(9, p.getPhone());
            ps.setString(10, p.getLinkedinUrl());
            ps.executeUpdate();
            try (ResultSet rs = ps.getGeneratedKeys()) {
                if (rs.next()) return rs.getInt(1);
            }
        } catch (SQLException e) {
            throw DatabaseException.wrap("insertJobSeeker", e);
        }
        return 0;
    }

    /**
     * Inserts a new EmployerProfile.
     *
     * @param p the EmployerProfile to insert
     * @return the generated ID
     */
    public int insertEmployer(EmployerProfile p) {
        String sql = "INSERT INTO employer_profiles (user_id, company_name, company_description, industry, website_url, logo_url, location, founded_year) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
        try (Connection c = DBConnection.getConnection();
             PreparedStatement ps = c.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            ps.setInt(1, p.getUserId());
            ps.setString(2, p.getCompanyName());
            ps.setString(3, p.getCompanyDescription());
            ps.setString(4, p.getIndustry());
            ps.setString(5, p.getWebsiteUrl());
            ps.setString(6, p.getLogoUrl());
            ps.setString(7, p.getLocation());
            ps.setInt(8, p.getFoundedYear());
            ps.executeUpdate();
            try (ResultSet rs = ps.getGeneratedKeys()) {
                if (rs.next()) return rs.getInt(1);
            }
        } catch (SQLException e) {
            throw DatabaseException.wrap("insertEmployer", e);
        }
        return 0;
    }

    /**
     * Updates an existing JobSeekerProfile.
     *
     * @param p the JobSeekerProfile to update
     * @return true if updated successfully
     */
    public boolean updateJobSeeker(JobSeekerProfile p) {
        String sql = "UPDATE jobseeker_profiles SET headline = ?, summary = ?, skills = ?, education = ?, experience = ?, resume_url = ?, location = ?, phone = ?, linkedin_url = ? WHERE user_id = ?";
        try (Connection c = DBConnection.getConnection();
             PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setString(1, p.getHeadline());
            ps.setString(2, p.getSummary());
            ps.setString(3, p.getSkills());
            ps.setString(4, p.getEducation());
            ps.setString(5, p.getExperience());
            ps.setString(6, p.getResumeUrl());
            ps.setString(7, p.getLocation());
            ps.setString(8, p.getPhone());
            ps.setString(9, p.getLinkedinUrl());
            ps.setInt(10, p.getUserId());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            throw DatabaseException.wrap("updateJobSeeker", e);
        }
    }

    /**
     * Updates an existing EmployerProfile.
     *
     * @param p the EmployerProfile to update
     * @return true if updated successfully
     */
    public boolean updateEmployer(EmployerProfile p) {
        String sql = "UPDATE employer_profiles SET company_name = ?, company_description = ?, industry = ?, website_url = ?, logo_url = ?, location = ?, founded_year = ? WHERE user_id = ?";
        try (Connection c = DBConnection.getConnection();
             PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setString(1, p.getCompanyName());
            ps.setString(2, p.getCompanyDescription());
            ps.setString(3, p.getIndustry());
            ps.setString(4, p.getWebsiteUrl());
            ps.setString(5, p.getLogoUrl());
            ps.setString(6, p.getLocation());
            ps.setInt(7, p.getFoundedYear());
            ps.setInt(8, p.getUserId());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            throw DatabaseException.wrap("updateEmployer", e);
        }
    }

    /**
     * Checks if a job seeker profile exists for the user.
     *
     * @param userId the user ID
     * @return true if exists
     */
    public boolean jobSeekerProfileExists(int userId) {
        String sql = "SELECT 1 FROM jobseeker_profiles WHERE user_id = ?";
        try (Connection c = DBConnection.getConnection();
             PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setInt(1, userId);
            try (ResultSet rs = ps.executeQuery()) {
                return rs.next();
            }
        } catch (SQLException e) {
            throw DatabaseException.wrap("jobSeekerProfileExists", e);
        }
    }

    /**
     * Checks if an employer profile exists for the user.
     *
     * @param userId the user ID
     * @return true if exists
     */
    public boolean employerProfileExists(int userId) {
        String sql = "SELECT 1 FROM employer_profiles WHERE user_id = ?";
        try (Connection c = DBConnection.getConnection();
             PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setInt(1, userId);
            try (ResultSet rs = ps.executeQuery()) {
                return rs.next();
            }
        } catch (SQLException e) {
            throw DatabaseException.wrap("employerProfileExists", e);
        }
    }
}
