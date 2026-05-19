package com.workbridge.model;

import java.time.LocalDateTime;

/**
 * SavedJob — Represents a job listing saved by a job seeker for later review.
 *
 * <p>Maps to the 'saved_jobs' table in the database.</p>
 *
 * @author WorkBridge Team
 * @version 1.0
 */
public class SavedJob {

    private int id;
    private int userId;
    private int jobId;
    private LocalDateTime savedAt;

    public SavedJob() {
    }

    public SavedJob(int id, int userId, int jobId, LocalDateTime savedAt) {
        this.id = id;
        this.userId = userId;
        this.jobId = jobId;
        this.savedAt = savedAt;
    }

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public int getUserId() { return userId; }
    public void setUserId(int userId) { this.userId = userId; }

    public int getJobId() { return jobId; }
    public void setJobId(int jobId) { this.jobId = jobId; }

    public LocalDateTime getSavedAt() { return savedAt; }
    public void setSavedAt(LocalDateTime savedAt) { this.savedAt = savedAt; }

    @Override
    public String toString() {
        return "SavedJob{" +
                "id=" + id +
                ", userId=" + userId +
                ", jobId=" + jobId +
                ", savedAt=" + savedAt +
                '}';
    }
}
