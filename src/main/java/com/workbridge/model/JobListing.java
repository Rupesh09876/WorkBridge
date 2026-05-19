package com.workbridge.model;

import java.time.LocalDate;
import java.time.LocalDateTime;

/**
 * JobListing — Represents a job posting created by an employer.
 *
 * <p>Maps to the 'job_listings' table in the database. Contains the job description,
 * requirements, and details needed for a job seeker to apply.</p>
 *
 * @author WorkBridge Team
 * @version 1.0
 */
public class JobListing {

    private int id;
    private int employerId;
    private int categoryId;
    private String title;
    private String description;
    private String requirements;
    private String location;
    private String salaryRange;
    private JobType jobType;
    private String status;
    private LocalDate deadline;
    private LocalDateTime createdAt;
    private LocalDateTime updatedAt;

    public JobListing() {
    }

    public JobListing(int id, int employerId, int categoryId, String title, String description, String requirements, String location, String salaryRange, JobType jobType, String status, LocalDate deadline, LocalDateTime createdAt, LocalDateTime updatedAt) {
        this.id = id;
        this.employerId = employerId;
        this.categoryId = categoryId;
        this.title = title;
        this.description = description;
        this.requirements = requirements;
        this.location = location;
        this.salaryRange = salaryRange;
        this.jobType = jobType;
        this.status = status;
        this.deadline = deadline;
        this.createdAt = createdAt;
        this.updatedAt = updatedAt;
    }

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public int getEmployerId() { return employerId; }
    public void setEmployerId(int employerId) { this.employerId = employerId; }

    public int getCategoryId() { return categoryId; }
    public void setCategoryId(int categoryId) { this.categoryId = categoryId; }

    public String getTitle() { return title; }
    public void setTitle(String title) { this.title = title; }

    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }

    public String getRequirements() { return requirements; }
    public void setRequirements(String requirements) { this.requirements = requirements; }

    public String getLocation() { return location; }
    public void setLocation(String location) { this.location = location; }

    public String getSalaryRange() { return salaryRange; }
    public void setSalaryRange(String salaryRange) { this.salaryRange = salaryRange; }

    public JobType getJobType() { return jobType; }
    public void setJobType(JobType jobType) { this.jobType = jobType; }

    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }

    public LocalDate getDeadline() { return deadline; }
    public void setDeadline(LocalDate deadline) { this.deadline = deadline; }

    public LocalDateTime getCreatedAt() { return createdAt; }
    public void setCreatedAt(LocalDateTime createdAt) { this.createdAt = createdAt; }

    public LocalDateTime getUpdatedAt() { return updatedAt; }
    public void setUpdatedAt(LocalDateTime updatedAt) { this.updatedAt = updatedAt; }

    @Override
    public String toString() {
        return "JobListing{" +
                "id=" + id +
                ", employerId=" + employerId +
                ", categoryId=" + categoryId +
                ", title='" + title + '\'' +
                ", location='" + location + '\'' +
                ", jobType=" + jobType +
                ", status='" + status + '\'' +
                ", deadline=" + deadline +
                ", createdAt=" + createdAt +
                ", updatedAt=" + updatedAt +
                '}';
    }
}
