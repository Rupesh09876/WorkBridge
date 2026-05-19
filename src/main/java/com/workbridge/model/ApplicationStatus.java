package com.workbridge.model;

import java.util.Arrays;

/**
 * ApplicationStatus — Defines the status of a job application.
 *
 * <p>Used to track the progress of an application through the hiring process.</p>
 *
 * @author WorkBridge Team
 * @version 1.0
 */
public enum ApplicationStatus {
    PENDING("Pending"),
    REVIEWED("Reviewed"),
    SHORTLISTED("Shortlisted"),
    ACCEPTED("Accepted"),
    REJECTED("Rejected");

    private final String displayName;

    ApplicationStatus(String displayName) {
        this.displayName = displayName;
    }

    /**
     * Retrieves the human-readable display name of the application status.
     *
     * @return the display name
     */
    public String getDisplayName() {
        return displayName;
    }

    /**
     * Parses a string into an ApplicationStatus enum case-insensitively.
     *
     * @param s the string to parse
     * @return the corresponding ApplicationStatus
     * @throws IllegalArgumentException if the string does not match any valid application status
     */
    public static ApplicationStatus fromString(String s) {
        if (s == null) {
            throw new IllegalArgumentException("ApplicationStatus string cannot be null.");
        }
        for (ApplicationStatus status : values()) {
            if (status.name().equalsIgnoreCase(s)) {
                return status;
            }
        }
        throw new IllegalArgumentException("Invalid value: " + s + ". Valid values are: " + Arrays.toString(values()));
    }
}
