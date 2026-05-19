package com.workbridge.model;

import java.util.Arrays;

/**
 * UserRole — Defines the role of a user in the WorkBridge system.
 *
 * <p>Used for access control and authorization in the MVC layer.</p>
 *
 * @author WorkBridge Team
 * @version 1.0
 */
public enum UserRole {
    ADMIN("Admin"),
    EMPLOYER("Employer"),
    JOB_SEEKER("Job Seeker");

    private final String displayName;

    UserRole(String displayName) {
        this.displayName = displayName;
    }

    /**
     * Retrieves the human-readable display name of the role.
     *
     * @return the display name
     */
    public String getDisplayName() {
        return displayName;
    }

    /**
     * Parses a string into a UserRole enum case-insensitively.
     *
     * @param s the string to parse
     * @return the corresponding UserRole
     * @throws IllegalArgumentException if the string does not match any valid role
     */
    public static UserRole fromString(String s) {
        if (s == null) {
            throw new IllegalArgumentException("Role string cannot be null.");
        }
        for (UserRole role : values()) {
            if (role.name().equalsIgnoreCase(s)) {
                return role;
            }
        }
        throw new IllegalArgumentException("Invalid value: " + s + ". Valid values are: " + Arrays.toString(values()));
    }
}
