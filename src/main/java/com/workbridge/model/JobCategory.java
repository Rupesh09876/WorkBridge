package com.workbridge.model;

/**
 * JobCategory — Represents an industry or category for job listings.
 *
 * <p>Maps to the 'job_categories' table. Used for filtering and organizing jobs.</p>
 *
 * @author WorkBridge Team
 * @version 1.0
 */
public class JobCategory {

    private int id;
    private String name;
    private String description;

    public JobCategory() {
    }

    public JobCategory(int id, String name, String description) {
        this.id = id;
        this.name = name;
        this.description = description;
    }

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public String getName() { return name; }
    public void setName(String name) { this.name = name; }

    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }

    @Override
    public String toString() {
        return "JobCategory{" +
                "id=" + id +
                ", name='" + name + '\'' +
                ", description='" + description + '\'' +
                '}';
    }
}
