package com.workbridge.model;

import java.time.LocalDateTime;

/**
 * JobSeekerProfile — Contains extended details for a job seeker.
 *
 * <p>Maps to the 'jobseeker_profiles' table. It holds professional
 * details such as skills, education, experience, and resume link.</p>
 *
 * @author WorkBridge Team
 * @version 1.0
 */
public class JobSeekerProfile {

    private int id;
    private int userId;
    private String headline;
    private String summary;
    private String skills;
    private String education;
    private String experience;
    private String resumeUrl;
    private String location;
    private String phone;
    private String linkedinUrl;
    private LocalDateTime updatedAt;

    public JobSeekerProfile() {
    }

    public JobSeekerProfile(int id, int userId, String headline, String summary, String skills, String education, String experience, String resumeUrl, String location, String phone, String linkedinUrl, LocalDateTime updatedAt) {
        this.id = id;
        this.userId = userId;
        this.headline = headline;
        this.summary = summary;
        this.skills = skills;
        this.education = education;
        this.experience = experience;
        this.resumeUrl = resumeUrl;
        this.location = location;
        this.phone = phone;
        this.linkedinUrl = linkedinUrl;
        this.updatedAt = updatedAt;
    }

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public int getUserId() { return userId; }
    public void setUserId(int userId) { this.userId = userId; }

    public String getHeadline() { return headline; }
    public void setHeadline(String headline) { this.headline = headline; }

    public String getSummary() { return summary; }
    public void setSummary(String summary) { this.summary = summary; }

    public String getSkills() { return skills; }
    public void setSkills(String skills) { this.skills = skills; }

    public String getEducation() { return education; }
    public void setEducation(String education) { this.education = education; }

    public String getExperience() { return experience; }
    public void setExperience(String experience) { this.experience = experience; }

    public String getResumeUrl() { return resumeUrl; }
    public void setResumeUrl(String resumeUrl) { this.resumeUrl = resumeUrl; }

    public String getLocation() { return location; }
    public void setLocation(String location) { this.location = location; }

    public String getPhone() { return phone; }
    public void setPhone(String phone) { this.phone = phone; }

    public String getLinkedinUrl() { return linkedinUrl; }
    public void setLinkedinUrl(String linkedinUrl) { this.linkedinUrl = linkedinUrl; }

    public LocalDateTime getUpdatedAt() { return updatedAt; }
    public void setUpdatedAt(LocalDateTime updatedAt) { this.updatedAt = updatedAt; }

    @Override
    public String toString() {
        return "JobSeekerProfile{" +
                "id=" + id +
                ", userId=" + userId +
                ", headline='" + headline + '\'' +
                ", location='" + location + '\'' +
                ", updatedAt=" + updatedAt +
                '}';
    }
}
