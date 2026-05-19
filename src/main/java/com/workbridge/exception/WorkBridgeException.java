package com.workbridge.exception;

/**
 * WorkBridgeException — Base runtime exception for the WorkBridge application.
 *
 * <p>This exception and its subclasses are used across the service layer
 * to enforce business rules and bubble up errors to the web layer without
 * exposing raw system exceptions to the user.</p>
 *
 * @author WorkBridge Team
 * @version 1.0
 */
public class WorkBridgeException extends RuntimeException {

    private final String errorCode;

    /**
     * Constructs a new WorkBridgeException with null message and cause.
     */
    public WorkBridgeException() {
        super();
        this.errorCode = null;
    }

    /**
     * Constructs a new WorkBridgeException with the specified detail message.
     *
     * @param message the detail message
     */
    public WorkBridgeException(String message) {
        super(message);
        this.errorCode = null;
    }

    /**
     * Constructs a new WorkBridgeException with the specified detail message
     * and error code.
     *
     * @param message   the detail message
     * @param errorCode the specific error code
     */
    public WorkBridgeException(String message, String errorCode) {
        super(message);
        this.errorCode = errorCode;
    }

    /**
     * Constructs a new WorkBridgeException with the specified detail message
     * and cause.
     *
     * @param message the detail message
     * @param cause   the underlying cause
     */
    public WorkBridgeException(String message, Throwable cause) {
        super(message, cause);
        this.errorCode = null;
    }

    /**
     * Constructs a new WorkBridgeException with the specified detail message,
     * cause, and error code.
     *
     * @param message   the detail message
     * @param cause     the underlying cause
     * @param errorCode the specific error code
     */
    public WorkBridgeException(String message, Throwable cause, String errorCode) {
        super(message, cause);
        this.errorCode = errorCode;
    }

    /**
     * Retrieves the error code associated with this exception, if any.
     *
     * @return the error code, or null if none is set
     */
    public String getErrorCode() {
        return errorCode;
    }
}
