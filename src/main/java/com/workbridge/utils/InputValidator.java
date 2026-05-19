package com.workbridge.util;

import java.time.LocalDate;

/**
 * InputValidator — Provides static validation and sanitization methods.
 *
 * <p>All validation methods return boolean. All error message generation
 * follows the academic requirement for specific, user-friendly messages.</p>
 *
 * @author WorkBridge Team
 * @version 1.0
 */
public class InputValidator {

    private static final String EMAIL_REGEX = "^[A-Za-z0-9+_.-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}$";
    private static final String PHONE_REGEX = "^[0-9]{10}$";
    private static final String NAME_REGEX = "^[A-Za-z\\s'-]{2,100}$";
    private static final String PASSWORD_REGEX = "^(?=.*[A-Z])(?=.*[0-9])(?=.*[@#$!%^&*]).{8,}$";
    private static final String URL_REGEX = "^(https?://).+";
    private static final int YEAR_MIN = 1800;
    private static final int MAX_NAME_LEN = 100;
    private static final int MAX_EMAIL_LEN = 150;
    private static final int MIN_COVER_LEN = 50;

    /**
     * Validates an email address.
     */
    public static boolean isValidEmail(String email) {
        return email != null && email.matches(EMAIL_REGEX) && email.length() <= MAX_EMAIL_LEN;
    }

    /**
     * Validates a phone number.
     */
    public static boolean isValidPhone(String phone) {
        return phone != null && phone.matches(PHONE_REGEX);
    }

    /**
     * Validates a full name.
     */
    public static boolean isValidFullName(String name) {
        return name != null && name.matches(NAME_REGEX) && name.length() <= MAX_NAME_LEN;
    }

    /**
     * Validates password strength.
     */
    public static boolean isValidPassword(String password) {
        return password != null && password.matches(PASSWORD_REGEX);
    }

    /**
     * Validates a URL.
     */
    public static boolean isValidUrl(String url) {
        return url != null && url.matches(URL_REGEX);
    }

    /**
     * Checks if a string is not empty.
     */
    public static boolean isNotEmpty(String value) {
        return value != null && !value.trim().isEmpty();
    }

    /**
     * Validates a year.
     */
    public static boolean isValidYear(int year) {
        return year >= YEAR_MIN && year <= LocalDate.now().getYear();
    }

    /**
     * Validates a deadline is in the future.
     */
    public static boolean isValidDeadline(LocalDate deadline) {
        return deadline != null && deadline.isAfter(LocalDate.now());
    }

    /**
     * Validates cover letter length.
     */
    public static boolean isValidCoverLetter(String text) {
        return text != null && text.trim().length() >= MIN_COVER_LEN;
    }

    // --- Error Message Methods (Academic Compliance RULE 3) ---

    public static String getNameError(String name) {
        if (!isNotEmpty(name)) return "Full name is required.";
        if (name.length() < 2) return "Full name must be at least 2 characters.";
        if (name.length() > MAX_NAME_LEN) return "Full name cannot exceed 100 characters.";
        if (name.matches(".*\\d.*")) return "Full name must contain letters only. Numbers are not allowed.";
        return null;
    }

    public static String getEmailError(String email) {
        if (!isNotEmpty(email)) return "Email address is required.";
        if (!email.matches(EMAIL_REGEX)) return "Please enter a valid email address (e.g. name@example.com).";
        return null;
    }

    public static String getPhoneError(String phone) {
        if (!isNotEmpty(phone)) return "Phone number is required.";
        if (!phone.matches(PHONE_REGEX)) return "Please enter a valid phone number (digits only, 10 digits required).";
        return null;
    }

    public static String getPasswordError(String password) {
        if (!isNotEmpty(password)) return "Password is required.";
        if (password.length() < 8) return "Password must be at least 8 characters.";
        if (!password.matches(".*[A-Z].*")) return "Password must contain at least one uppercase letter.";
        if (!password.matches(".*[0-9].*")) return "Password must contain at least one number.";
        if (!password.matches(".*[@#$!%^&*].*")) return "Password must contain at least one special character (e.g. @, #, $, !).";
        return null;
    }

    public static String getConfirmPasswordError(String p1, String p2) {
        if (!isNotEmpty(p2)) return "Confirm password is required.";
        if (!p2.equals(p1)) return "Passwords do not match. Please try again.";
        return null;
    }

    /**
     * Sanitizes user input to prevent XSS.
     *
     * @param input the raw input string
     * @return the sanitized string
     */
    public static String sanitize(String input) {
        if (input == null) return null;
        String sanitized = input.trim();
        sanitized = sanitized.replace("&", "&amp;")
                             .replace("<", "&lt;")
                             .replace(">", "&gt;")
                             .replace("\"", "&quot;")
                             .replace("'", "&#x27;");
        return sanitized;
    }
}
