package com.megacity.rest.service;

import java.nio.file.Files;
import java.nio.file.Paths;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.sql.Statement;

public class DatabaseInitializer {
    private static final String DATABASE_PATH = "jdbc:oracle:thin:@//localhost:1522/FREEPDB1"; // SQLite database file path
    private static final String USERNAME = "MEGACITYCAB";
    private static final String PASSWORD = "123";

    public static void initializeDatabase() {
        try (Connection conn = DriverManager.getConnection(DATABASE_PATH, USERNAME, PASSWORD);
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
                    stmt.executeUpdate(query.trim());
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
