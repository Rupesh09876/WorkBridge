package com.workbridge.util;

import org.mindrot.jbcrypt.BCrypt;

/**
 * PasswordUtil — Provides BCrypt password hashing and verification.
 *
 * <p>Uses jBCrypt with work factor 12 for secure password storage.
 * Passwords are NEVER stored or logged in plain text.</p>
 *
 * @author WorkBridge Team
 * @version 1.0
 */
public class PasswordUtil {

    private static final int BCRYPT_ROUNDS = 12;

    /**
     * Hashes a plain-text password using BCrypt.
     *
     * @param plainText the plain-text password
     * @return the hashed password string
     */
    public static String hashPassword(String plainText) {
        if (plainText == null || plainText.trim().isEmpty()) {
            throw new IllegalArgumentException("Password cannot be null or empty.");
        }
        return BCrypt.hashpw(plainText, BCrypt.gensalt(BCRYPT_ROUNDS));
    }

    /**
     * Verifies a plain-text password against a stored BCrypt hash.
     *
     * @param plainText the plain-text password to check
     * @param hashed    the stored hash
     * @return true if the password matches, false otherwise
     */
    public static boolean verifyPassword(String plainText, String hashed) {
        if (plainText == null || plainText.isEmpty() || hashed == null || hashed.isEmpty()) {
            return false;
        }
        try {
            return BCrypt.checkpw(plainText, hashed);
        } catch (IllegalArgumentException e) {
            // Can occur if the hash format is invalid
            return false;
        }
    }
}
