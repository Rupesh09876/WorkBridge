package com.workbridge.exception;

/**
 * AuthException — Thrown when authentication or authorization fails.
 *
 * <p>Provides specific error cases using static factory methods to ensure
 * consistency in error messaging across the application.</p>
 *
 * @author WorkBridge Team
 * @version 1.0
 */
public class AuthException extends WorkBridgeException {

    public static final String INVALID_CREDENTIALS = "INVALID_CREDENTIALS";
    public static final String ACCOUNT_PENDING = "ACCOUNT_PENDING";
    public static final String ACCOUNT_SUSPENDED = "ACCOUNT_SUSPENDED";
    public static final String EMAIL_TAKEN = "EMAIL_TAKEN";
    public static final String PHONE_TAKEN = "PHONE_TAKEN";
    public static final String UNAUTHORIZED = "UNAUTHORIZED";

    /**
     * Private constructor to enforce the use of static factory methods.
     *
     * @param message   the user-facing error message
     * @param errorCode the specific error code constant
     */
    private AuthException(String message, String errorCode) {
        super(message, errorCode);
    }

    /**
     * Returns an exception for invalid email or password.
     *
     * @return an AuthException configured for invalid credentials
     */
    public static AuthException invalidCredentials() {
        return new AuthException("Invalid email or password.", INVALID_CREDENTIALS);
    }

    /**
     * Returns an exception for an account awaiting admin approval.
     *
     * @return an AuthException configured for a pending account
     */
    public static AuthException accountPending() {
        return new AuthException("Your account is pending admin approval. You will be able to log in once approved.", ACCOUNT_PENDING);
    }

    /**
     * Returns an exception for an account that has been suspended.
     *
     * @return an AuthException configured for a suspended account
     */
    public static AuthException accountSuspended() {
        return new AuthException("Your account has been suspended. Please contact the administrator.", ACCOUNT_SUSPENDED);
    }

    /**
     * Returns an exception for registration with an already-used email.
     *
     * @return an AuthException configured for an taken email
     */
    public static AuthException emailTaken() {
        return new AuthException("An account with this email already exists. Please log in or use a different email.", EMAIL_TAKEN);
    }

    /**
     * Returns an exception for registration with an already-used phone number.
     *
     * @return an AuthException configured for an taken phone number
     */
    public static AuthException phoneTaken() {
        return new AuthException("An account with this phone number already exists.", PHONE_TAKEN);
    }

    /**
     * Returns an exception for insufficient permissions to access a resource.
     *
     * @return an AuthException configured for unauthorized access
     */
    public static AuthException unauthorized() {
        return new AuthException("You do not have permission to access this resource.", UNAUTHORIZED);
    }
}
