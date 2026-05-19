package com.workbridge.model;

import java.util.Arrays;

/**
 * JobType — Defines the employment type for a job listing.
 *
 * <p>Used to categorize jobs based on their commitment and work model.</p>
 *
 * @author WorkBridge Team
 * @version 1.0
 */
public enum JobType {
    FULL_TIME("Full Time"),
    PART_TIME("Part Time"),
    CONTRACT("Contract"),
    INTERNSHIP("Internship"),
    REMOTE("Remote");

    private final String displayName;

    JobType(String displayName) {
        this.displayName = displayName;
    }

    /**
     * Retrieves the human-readable display name of the job type.
     *
     * @return the display name
     */
    public String getDisplayName() {
        return displayName;
    }

    /**
     * Parses a string into a JobType enum case-insensitively.
     *
     * @param s the string to parse
     * @return the corresponding JobType
     * @throws IllegalArgumentException if the string does not match any valid job type
     */
    public static JobType fromString(String s) {
        if (s == null) {
            throw new IllegalArgumentException("JobType string cannot be null.");
        }
        for (JobType type : values()) {
            if (type.name().equalsIgnoreCase(s)) {
                return type;
            }
        }
        throw new IllegalArgumentException("Invalid value: " + s + ". Valid values are: " + Arrays.toString(values()));
    }
}
