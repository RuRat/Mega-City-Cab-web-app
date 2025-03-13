package com.megacity.rest.service;

import java.nio.file.Files;
import java.nio.file.Paths;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.sql.Statement;

public class DatabaseInitializer {
    private static final String URL = "jdbc:mysql://localhost:3306/test_db"; 
                                                // SQLite database file path
    private static final String USERNAME = "root";
    private static final String PASSWORD = "z123";

    public static void initializeDatabase() {
        try (Connection conn = DriverManager.getConnection(URL, USERNAME, PASSWORD);
             Statement stmt = conn.createStatement()) {

            System.out.println("Connected to SQLite database.");

            // Execute SQL file for table creation
            executeSQLFile(stmt, "src/main/resources/sql/schema.sql");
//src/main/resources/sql/schema.sql
            // Execute SQL file for inserting default data
            executeSQLFile(stmt, "src/main/resources/sql/default_data.sql");

            System.out.println("Database setup completed successfully.");
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    private static void executeSQLFile(Statement stmt, String filePath) {
        try {
            String sql = new String(Files.readAllBytes(Paths.get(filePath)));
            for (String query : sql.split(";")) {
                if (!query.trim().isEmpty()) {
                    stmt.execute(query.trim());                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
