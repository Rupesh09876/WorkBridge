package com.workbridge.service;

import com.workbridge.dao.CategoryDAO;
import com.workbridge.dao.JobDAO;
import com.workbridge.exception.ResourceNotFoundException;
import com.workbridge.exception.ValidationException;
import com.workbridge.service.NotificationService;
import com.workbridge.model.JobCategory;
import com.workbridge.model.JobListing;
import com.workbridge.model.JobType;
import com.workbridge.util.InputValidator;

import java.time.LocalDateTime;
import java.util.List;

/**
 * JobService — Handles business logic related to Job Listings.
 *
 * <p>Manages job creation, updating, deletion, and searching.</p>
 *
 * @author WorkBridge Team
 * @version 1.0
 */
public class JobService {

    private final JobDAO jobDAO = new JobDAO();
    private final CategoryDAO categoryDAO = new CategoryDAO();
    private final NotificationService notificationService = new NotificationService();

    /**
     * Retrieves all currently open job listings.
     *
     * @return list of open jobs
     */
    public List<JobListing> getAllOpenJobs() {
        return jobDAO.findOpen();
    }

    /**
     * Retrieves a job listing by its ID.
     *
     * @param id the job ID
     * @return the JobListing
     * @throws ResourceNotFoundException if the job does not exist
     */
    public JobListing getJobById(int id) {
        JobListing job = jobDAO.findById(id);
        if (job == null) {
            throw new ResourceNotFoundException("JobListing", id);
        }
        return job;
    }

    /**
     * Retrieves all job listings posted by an employer.
     *
     * @param employerId the employer ID
     * @return list of jobs
     */
    public List<JobListing> getJobsByEmployer(int employerId) {
        return jobDAO.findByEmployer(employerId);
    }

    /**
     * Searches for jobs based on multiple optional criteria.
     *
     * @param keyword    search keyword
     * @param location   location string
     * @param type       JobType enum
     * @param categoryId category ID
     * @return list of matching jobs
     */
    public List<JobListing> searchJobs(String keyword, String location, JobType type, int categoryId) {
        return jobDAO.search(keyword, location, type, categoryId);
    }

    /**
     * Creates a new job listing.
     *
     * @param job        the JobListing data
     * @param employerId the employer creating the job
     * @return the generated job ID
     * @throws ValidationException if validation fails
     */
    public int createJob(JobListing job, int employerId) {
        ValidationException ve = new ValidationException("Job validation failed.");

        // Validate: title, description, location not empty
        if (!InputValidator.isNotEmpty(job.getTitle())) {
            ve.addFieldError("title", "Job title is required.");
        } else if (job.getTitle().length() < 3) {
            ve.addFieldError("title", "Job title must be at least 3 characters.");
        }

        if (!InputValidator.isNotEmpty(job.getDescription())) {
            ve.addFieldError("description", "Job description is required.");
        }

        if (!InputValidator.isNotEmpty(job.getLocation())) {
            ve.addFieldError("location", "Job location is required.");
        }

        // Validate: deadline is future date
        if (job.getDeadline() == null) {
            ve.addFieldError("deadline", "Please set an application deadline.");
        } else if (!InputValidator.isValidDeadline(job.getDeadline())) {
            ve.addFieldError("deadline", "Application deadline must be a future date.");
        }

        if (ve.hasErrors()) {
            throw ve;
        }

        // Set employerId, status (if not DRAFT), createdAt
        job.setEmployerId(employerId);
        if (!"DRAFT".equals(job.getStatus())) {
            job.setStatus("OPEN");
        }
        job.setCreatedAt(LocalDateTime.now());

        int jobId = jobDAO.insert(job);
        
        // Notify employer
        notificationService.notify(employerId, "Job posted successfully: " + job.getTitle());
        
        return jobId;
    }

    /**
     * Updates an existing job listing, ensuring ownership.
     *
     * @param job                  the updated JobListing data
     * @param requestingEmployerId the employer requesting the update
     * @throws ValidationException if ownership check fails
     */
    public void updateJob(JobListing job, int requestingEmployerId) {
        JobListing existing = getJobById(job.getId());

        // Ownership check: job.employerId must equal requestingEmployerId
        if (existing.getEmployerId() != requestingEmployerId) {
            throw new ValidationException("You do not have permission to edit this job.");
        }

        jobDAO.update(job);
    }

    /**
     * Deletes a job listing securely.
     *
     * @param jobId                the job ID
     * @param requestingEmployerId the employer requesting deletion
     * @throws ValidationException if ownership check fails
     */
    public void deleteJob(int jobId, int requestingEmployerId) {
        JobListing existing = getJobById(jobId);

        // Ownership check before delete
        if (existing.getEmployerId() != requestingEmployerId) {
            throw new ValidationException("You do not have permission to delete this job.");
        }

        jobDAO.delete(jobId);
    }

    /**
     * Closes an open job listing.
     *
     * @param jobId                the job ID
     * @param requestingEmployerId the employer requesting the change
     * @throws ValidationException if ownership check fails
     */
    public void closeJob(int jobId, int requestingEmployerId) {
        JobListing existing = getJobById(jobId);

        if (existing.getEmployerId() != requestingEmployerId) {
            throw new ValidationException("You do not have permission to close this job.");
        }

        jobDAO.updateStatus(jobId, "CLOSED");
        
        // Notify employer
        notificationService.notify(requestingEmployerId, "Job has been closed: " + existing.getTitle());
    }

    /**
     * Retrieves all job categories.
     *
     * @return list of categories
     */
    public List<JobCategory> getAllCategories() {
        return categoryDAO.findAll();
    }

    /**
     * Retrieves all jobs (for Admin use).
     *
     * @return list of all jobs
     */
    public List<JobListing> getAllJobs() {
        return jobDAO.findAll();
    }

    /**
     * Administrator deletion of a job without ownership checks.
     *
     * @param jobId the job ID
     */
    public void adminDeleteJob(int jobId) {
        // No ownership check
        jobDAO.delete(jobId);
    }

    /**
     * Updates a job listing's status after verifying employer ownership.
     *
     * @param jobId      the job to update
     * @param newStatus  the new status string (OPEN, CLOSED, DRAFT)
     * @param employerId the requesting employer's user ID
     * @throws WorkBridgeException if job not found or ownership fails
     */
    public void updateJobStatus(int jobId, String newStatus, int employerId) {
        JobListing existing = getJobById(jobId);

        if (existing.getEmployerId() != employerId) {
            throw new ValidationException("You do not have permission to update this job's status.");
        }

        jobDAO.updateStatus(jobId, newStatus);
    }
}
