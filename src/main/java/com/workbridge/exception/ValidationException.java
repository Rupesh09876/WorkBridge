package com.workbridge.exception;

import java.util.LinkedHashMap;
import java.util.Map;

/**
 * ValidationException — Thrown when business or input validation rules fail.
 *
 * <p>This exception stores a map of field-specific error messages that can
 * be extracted and displayed inline within the JSP views.</p>
 *
 * @author WorkBridge Team
 * @version 1.0
 */
public class ValidationException extends WorkBridgeException {

    private final Map<String, String> fieldErrors = new LinkedHashMap<>();

    /**
     * Constructs a ValidationException with a general error message.
     *
     * @param message the general validation failure message
     */
    public ValidationException(String message) {
        super(message);
    }

    /**
     * Adds an error message for a specific field.
     *
     * @param field   the name of the form field (e.g., "email")
     * @param message the user-friendly error message for that field
     */
    public void addFieldError(String field, String message) {
        fieldErrors.put(field, message);
    }

    /**
     * Retrieves all field errors associated with this exception.
     *
     * @return a map of field names to error messages
     */
    public Map<String, String> getFieldErrors() {
        return fieldErrors;
    }

    /**
     * Checks if there are any field errors recorded.
     *
     * @return true if there is at least one field error, false otherwise
     */
    public boolean hasErrors() {
        return !fieldErrors.isEmpty();
    }

    /**
     * Retrieves the first error message from the map, useful for simple summary displays.
     *
     * @return the first error message, or null if no errors exist
     */
    public String getFirstError() {
        if (fieldErrors.isEmpty()) {
            return null;
        }
        return fieldErrors.values().iterator().next();
    }
}
