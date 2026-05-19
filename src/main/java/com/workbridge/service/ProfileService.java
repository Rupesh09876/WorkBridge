package com.workbridge.service;

import com.workbridge.dao.ProfileDAO;
import com.workbridge.model.EmployerProfile;
import com.workbridge.model.JobSeekerProfile;

/**
 * ProfileService — Handles business logic for user profiles.
 *
 * <p>Manages both JobSeeker and Employer profiles.</p>
 *
 * @author WorkBridge Team
 * @version 1.0
 */
public class ProfileService {

    private final ProfileDAO profileDAO = new ProfileDAO();

    /**
     * Retrieves a JobSeekerProfile by user ID.
     *
     * @param userId the user ID
     * @return the profile, or null if it doesn't exist
     */
    public JobSeekerProfile getJobSeekerProfile(int userId) {
        return profileDAO.findJobSeekerByUserId(userId);
    }

    /**
     * Retrieves an EmployerProfile by user ID.
     *
     * @param userId the user ID
     * @return the profile, or null if it doesn't exist
     */
    public EmployerProfile getEmployerProfile(int userId) {
        return profileDAO.findEmployerByUserId(userId);
    }

    /**
     * Creates a new JobSeekerProfile.
     *
     * @param p the JobSeekerProfile to create
     */
    public void createJobSeekerProfile(JobSeekerProfile p) {
        profileDAO.insertJobSeeker(p);
    }

    /**
     * Creates a new EmployerProfile.
     *
     * @param p the EmployerProfile to create
     */
    public void createEmployerProfile(EmployerProfile p) {
        profileDAO.insertEmployer(p);
    }

    /**
     * Updates an existing JobSeekerProfile.
     *
     * @param p the JobSeekerProfile to update
     */
    public void updateJobSeekerProfile(JobSeekerProfile p) {
        profileDAO.updateJobSeeker(p);
    }

    /**
     * Updates an existing EmployerProfile.
     *
     * @param p the EmployerProfile to update
     */
    public void updateEmployerProfile(EmployerProfile p) {
        profileDAO.updateEmployer(p);
    }

    /**
     * Checks if a JobSeekerProfile exists for a user.
     *
     * @param userId the user ID
     * @return true if it exists
     */
    public boolean jobSeekerProfileExists(int userId) {
        return profileDAO.jobSeekerProfileExists(userId);
    }

    /**
     * Checks if an EmployerProfile exists for a user.
     *
     * @param userId the user ID
     * @return true if it exists
     */
    public boolean employerProfileExists(int userId) {
        return profileDAO.employerProfileExists(userId);
    }

    /**
     * Calculates the completion percentage of a job seeker's profile
     * based on how many optional fields have been filled in.
     *
     * @param profile the JobSeekerProfile to evaluate
     * @return integer percentage 0–100
     */
    public int getProfileCompletionPercent(JobSeekerProfile profile) {
        if (profile == null) return 0;

        // 8 scoreable fields, each worth 12.5 points
        // Fields: headline, summary, skills, education, experience,
        //         resumeUrl, location, linkedinUrl
        int score = 0;
        int total = 8;

        if (isNotBlank(profile.getHeadline()))    score++;
        if (isNotBlank(profile.getSummary()))     score++;
        if (isNotBlank(profile.getSkills()))      score++;
        if (isNotBlank(profile.getEducation()))   score++;
        if (isNotBlank(profile.getExperience()))  score++;
        if (isNotBlank(profile.getResumeUrl()))   score++;
        if (isNotBlank(profile.getLocation()))    score++;
        if (isNotBlank(profile.getLinkedinUrl())) score++;

        return (int) Math.round((score / (double) total) * 100);
    }

    private boolean isNotBlank(String s) {
        return s != null && !s.trim().isEmpty();
    }
}
