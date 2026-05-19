package com.workbridge.model;

import java.util.Arrays;

/**
 * UserStatus — Defines the current account status of a user.
 *
 * <p>Used to determine if a user can log in or perform actions.</p>
 *
 * @author WorkBridge Team
 * @version 1.0
 */
public enum UserStatus {
    PENDING("Pending Approval"),
    ACTIVE("Active"),
    SUSPENDED("Suspended");

    private final String displayName;

    UserStatus(String displayName) {
        this.displayName = displayName;
    }

    /**
     * Retrieves the human-readable display name of the status.
     *
     * @return the display name
     */
    public String getDisplayName() {
        return displayName;
    }

    /**
     * Parses a string into a UserStatus enum case-insensitively.
     *
     * @param s the string to parse
     * @return the corresponding UserStatus
     * @throws IllegalArgumentException if the string does not match any valid status
     */
    public static UserStatus fromString(String s) {
        if (s == null) {
            throw new IllegalArgumentException("Status string cannot be null.");
        }
        for (UserStatus status : values()) {
            if (status.name().equalsIgnoreCase(s)) {
                return status;
            }
        }
        throw new IllegalArgumentException("Invalid value: " + s + ". Valid values are: " + Arrays.toString(values()));
    }
}
