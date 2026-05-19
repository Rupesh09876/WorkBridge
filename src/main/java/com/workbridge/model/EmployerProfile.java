package com.workbridge.model;

import java.time.LocalDateTime;

/**
 * EmployerProfile — Contains extended details for an employer.
 *
 * <p>Maps to the 'employer_profiles' table. Represents a company's details,
 * industry, and branding used when posting job listings.</p>
 *
 * @author WorkBridge Team
 * @version 1.0
 */
public class EmployerProfile {

    private int id;
    private int userId;
    private String companyName;
    private String companyDescription;
    private String industry;
    private String websiteUrl;
    private String logoUrl;
    private String location;
    private int foundedYear;
    private LocalDateTime updatedAt;

    public EmployerProfile() {
    }

    public EmployerProfile(int id, int userId, String companyName, String companyDescription, String industry, String websiteUrl, String logoUrl, String location, int foundedYear, LocalDateTime updatedAt) {
        this.id = id;
        this.userId = userId;
        this.companyName = companyName;
        this.companyDescription = companyDescription;
        this.industry = industry;
        this.websiteUrl = websiteUrl;
        this.logoUrl = logoUrl;
        this.location = location;
        this.foundedYear = foundedYear;
        this.updatedAt = updatedAt;
    }

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public int getUserId() { return userId; }
    public void setUserId(int userId) { this.userId = userId; }

    public String getCompanyName() { return companyName; }
    public void setCompanyName(String companyName) { this.companyName = companyName; }

    public String getCompanyDescription() { return companyDescription; }
    public void setCompanyDescription(String companyDescription) { this.companyDescription = companyDescription; }

    public String getIndustry() { return industry; }
    public void setIndustry(String industry) { this.industry = industry; }

    public String getWebsiteUrl() { return websiteUrl; }
    public void setWebsiteUrl(String websiteUrl) { this.websiteUrl = websiteUrl; }

    public String getLogoUrl() { return logoUrl; }
    public void setLogoUrl(String logoUrl) { this.logoUrl = logoUrl; }

    public String getLocation() { return location; }
    public void setLocation(String location) { this.location = location; }

    public int getFoundedYear() { return foundedYear; }
    public void setFoundedYear(int foundedYear) { this.foundedYear = foundedYear; }

    public LocalDateTime getUpdatedAt() { return updatedAt; }
    public void setUpdatedAt(LocalDateTime updatedAt) { this.updatedAt = updatedAt; }

    @Override
    public String toString() {
        return "EmployerProfile{" +
                "id=" + id +
                ", userId=" + userId +
                ", companyName='" + companyName + '\'' +
                ", industry='" + industry + '\'' +
                ", location='" + location + '\'' +
                ", foundedYear=" + foundedYear +
                ", updatedAt=" + updatedAt +
                '}';
    }
}
