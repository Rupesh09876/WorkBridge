package com.workbridge.exception;

/**
 * ResourceNotFoundException — Thrown when a requested entity cannot be found.
 *
 * <p>Used predominantly when retrieving resources by ID where the resource
 * does not exist in the database.</p>
 *
 * @author WorkBridge Team
 * @version 1.0
 */
public class ResourceNotFoundException extends WorkBridgeException {

    /**
     * Constructs a ResourceNotFoundException with an integer identifier.
     *
     * @param resourceType the type of resource (e.g., "User", "JobListing")
     * @param id           the requested ID that was not found
     */
    public ResourceNotFoundException(String resourceType, int id) {
        super(resourceType + " with ID " + id + " was not found.");
    }

    /**
     * Constructs a ResourceNotFoundException with a string identifier.
     *
     * @param resourceType the type of resource (e.g., "User", "JobCategory")
     * @param identifier   the requested identifier that was not found
     */
    public ResourceNotFoundException(String resourceType, String identifier) {
        super(resourceType + " '" + identifier + "' was not found.");
    }
}
