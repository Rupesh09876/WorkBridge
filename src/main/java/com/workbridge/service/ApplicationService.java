package com.workbridge.service;

import com.workbridge.dao.ApplicationDAO;
import com.workbridge.dao.JobDAO;
import com.workbridge.dao.UserDAO;
import com.workbridge.exception.ResourceNotFoundException;
import com.workbridge.exception.ValidationException;
import com.workbridge.service.NotificationService;
import com.workbridge.model.Application;
import com.workbridge.model.ApplicationStatus;
import com.workbridge.model.JobListing;
import com.workbridge.model.User;
import com.workbridge.model.UserRole;
import com.workbridge.util.InputValidator;

import java.util.List;

/**
 * ApplicationService — Handles business logic for job applications.
 *
 * <p>Manages applying, withdrawing, and updating application status.</p>
 *
 * @author WorkBridge Team
 * @version 1.0
 */
public class ApplicationService {

    private final ApplicationDAO applicationDAO = new ApplicationDAO();
    private final JobDAO jobDAO = new JobDAO();
    private final UserDAO userDAO = new UserDAO();
    private final NotificationService notificationService = new NotificationService();

    /**
     * Submits an application for a job.
     *
     * @param jobId       the job ID
     * @param applicantId the applicant's user ID
     * @param coverLetter the cover letter text
     * @param resumeUrl   the resume link
     * @return the created Application
     * @throws ValidationException if business rules fail
     */
    public Application apply(int jobId, int applicantId, String coverLetter, String resumeUrl) {
        // Check job exists and is OPEN
        JobListing job = jobDAO.findById(jobId);
        if (job == null) {
            throw new ResourceNotFoundException("JobListing", jobId);
        }
        if (!"OPEN".equals(job.getStatus())) {
            throw new ValidationException("This job is no longer open for applications.");
        }

        // Check user is JOB_SEEKER (fetch from UserDAO)
        User user = userDAO.findById(applicantId);
        if (user == null || user.getRole() != UserRole.JOB_SEEKER) {
            throw new ValidationException("Only job seekers can apply for jobs.");
        }

        // Check not already applied
        if (applicationDAO.existsByJobAndApplicant(jobId, applicantId)) {
            throw new ValidationException("You have already applied for this job.");
        }

        // Validate cover letter min 50 chars
        if (!InputValidator.isValidCoverLetter(coverLetter)) {
            ValidationException ve = new ValidationException("Invalid cover letter.");
            ve.addFieldError("coverLetter", "Cover letter must be at least 50 characters.");
            throw ve;
        }

        // Insert and return
        Application app = new Application();
        app.setJobId(jobId);
        app.setApplicantId(applicantId);
        app.setCoverLetter(coverLetter);
        app.setResumeUrl(resumeUrl);
        app.setStatus(ApplicationStatus.PENDING);

        int id = applicationDAO.insert(app);
        app.setId(id);
        
        // Notify applicant
        notificationService.notify(applicantId, "You have successfully applied for the job: " + job.getTitle());
        
        return app;
    }

    /**
     * Withdraws a pending application.
     *
     * @param applicationId the application ID
     * @param applicantId   the applicant's user ID
     * @throws ValidationException if ownership or status check fails
     */
    public void withdrawApplication(int applicationId, int applicantId) {
        // Check application exists
        Application app = applicationDAO.findById(applicationId);
        if (app == null) {
            throw new ResourceNotFoundException("Application", applicationId);
        }

        // Check ownership (applicant_id matches)
        if (app.getApplicantId() != applicantId) {
            throw new ValidationException("You do not have permission to withdraw this application.");
        }

        // Check status is still PENDING
        if (app.getStatus() != ApplicationStatus.PENDING) {
            throw new ValidationException("Cannot withdraw application because it is already being processed.");
        }

        applicationDAO.delete(applicationId);
    }

    /**
     * Updates an application status by the employer.
     *
     * @param applicationId the application ID
     * @param newStatus     the new status
     * @param employerId    the employer requesting the change
     * @throws ValidationException if ownership check fails
     */
    public void updateApplicationStatus(int applicationId, ApplicationStatus newStatus, int employerId) {
        // Check application exists
        Application app = applicationDAO.findById(applicationId);
        if (app == null) {
            throw new ResourceNotFoundException("Application", applicationId);
        }

        // Verify employer owns the linked job
        JobListing job = jobDAO.findById(app.getJobId());
        if (job == null || job.getEmployerId() != employerId) {
            throw new ValidationException("You do not have permission to update this application.");
        }

        // Update status
        applicationDAO.updateStatus(applicationId, newStatus);
        
        // Notify applicant
        notificationService.notify(app.getApplicantId(), "Your application for " + job.getTitle() + " has been updated to: " + newStatus);
    }

    /**
     * Retrieves all applications for a specific job listing (for Employer).
     *
     * @param jobId      the job ID
     * @param employerId the employer requesting
     * @return list of applications
     * @throws ValidationException if ownership check fails
     */
    public List<Application> getApplicationsForJob(int jobId, int employerId) {
        JobListing job = jobDAO.findById(jobId);
        // Ownership check before returning
        if (job == null || job.getEmployerId() != employerId) {
            throw new ValidationException("You do not have permission to view these applications.");
        }
        return applicationDAO.findByJob(jobId);
    }

    /**
     * Retrieves all applications submitted by a job seeker.
     *
     * @param applicantId the applicant's user ID
     * @return list of applications
     */
    public List<Application> getApplicationsByApplicant(int applicantId) {
        return applicationDAO.findByApplicant(applicantId);
    }

    /**
     * Deletes an application unconditionally (for Admin).
     *
     * @param applicationId the application ID
     */
    public void deleteApplication(int applicationId) {
        // admin only — no check
        applicationDAO.delete(applicationId);
    }

    /**
     * Retrieves all applications in the system (for Admin).
     *
     * @return list of all applications
     */
    public List<Application> getAllApplications() {
        return applicationDAO.findAll();
    }

    /**
     * Counts the total number of applications for a job.
     *
     * @param jobId the job ID
     * @return the application count
     */
    public int countApplicationsForJob(int jobId) {
        return applicationDAO.countByJob(jobId);
    }
}
