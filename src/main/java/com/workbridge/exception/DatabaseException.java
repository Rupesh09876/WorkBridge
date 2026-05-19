package com.workbridge.exception;

import java.sql.SQLException;

/**
 * DatabaseException — Thrown when a database-related operation fails.
 *
 * <p>Used to wrap SQLExceptions in the DAO layer so the service and web layers
 * are completely decoupled from JDBC-specific implementations.</p>
 *
 * @author WorkBridge Team
 * @version 1.0
 */
public class DatabaseException extends WorkBridgeException {

    /**
     * Constructs a new DatabaseException with a detail message and cause.
     *
     * @param message the detail message explaining the context of the error
     * @param cause   the underlying SQLException
     */
    public DatabaseException(String message, Throwable cause) {
        super(message, cause);
    }

    /**
     * Factory method to wrap an SQLException with standard context information.
     *
     * @param operation the name of the method or operation that failed
     * @param e         the SQLException that occurred
     * @return a new DatabaseException wrapping the given cause
     */
    public static DatabaseException wrap(String operation, SQLException e) {
        return new DatabaseException("Database error during " + operation + ": " + e.getMessage(), e);
    }
}
