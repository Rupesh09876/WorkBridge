package com.workbridge.util;

import com.workbridge.exception.DatabaseException;

import java.io.InputStream;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.Properties;

/**
 * DBConnection — Manages JDBC connections to the MySQL database.
 *
 * <p>Loads configuration from db.properties on the classpath and provides
 * a centralized way to get and close connections.</p>
 *
 * @author WorkBridge Team
 * @version 1.0
 */
public class DBConnection {

    private static final String PROPERTIES_FILE = "db.properties";
    private static String url;
    private static String username;
    private static String password;

    static {
        try (InputStream input = DBConnection.class.getClassLoader().getResourceAsStream(PROPERTIES_FILE)) {
            if (input == null) {
                throw new RuntimeException("Sorry, unable to find " + PROPERTIES_FILE);
            }
            Properties prop = new Properties();
            prop.load(input);

            url = prop.getProperty("db.url");
            username = prop.getProperty("db.username");
            password = prop.getProperty("db.password");
            
            // Register JDBC driver explicitly
            String driver = prop.getProperty("db.driver", "com.mysql.cj.jdbc.Driver");
            Class.forName(driver);
        } catch (Exception ex) {
            ex.printStackTrace();
            throw new RuntimeException("Error initializing database configuration.", ex);
        }
    }

    /**
     * Gets a new connection to the database.
     *
     * @return a Connection object
     * @throws DatabaseException if a database access error occurs
     */
    public static Connection getConnection() {
        try {
            return DriverManager.getConnection(url, username, password);
        } catch (SQLException e) {
            throw new DatabaseException("Failed to establish database connection.", e);
        }
    }

    /**
     * Closes the given database connection silently.
     *
     * @param c the Connection to close
     */
    public static void close(Connection c) {
        if (c != null) {
            try {
                c.close();
            } catch (SQLException e) {
                // Log silently
                System.err.println("Warning: failed to close connection.");
            }
        }
    }
}
