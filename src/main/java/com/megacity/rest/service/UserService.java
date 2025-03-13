package com.megacity.rest.service;

import com.megacity.rest.entity.User;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;
public class UserService {
    private static final String URL = "jdbc:oracle:thin:@//localhost:1522/FREEPDB1"; // SQLite database file path
    private static final String USERNAME = "MEGACITYCAB";
    private static final String PASSWORD = "123";
    public List<User> getUsers() {
        List<User> users = new ArrayList<>();
        try {
            Connection connection = DriverManager.getConnection(URL, USERNAME, PASSWORD);
            Statement statement = connection.createStatement();
            ResultSet rs = statement.executeQuery("SELECT id, username, role, status, name, address, phone, license_number, vehicle_id FROM auth_user");
            while (rs.next()) {
                users.add(new User(
                        rs.getInt("id"),
                        rs.getString("username"),
                        null, // Avoid exposing passwords
                        rs.getString("role"),
                        rs.getString("status"),
                        rs.getString("name"),
                        rs.getString("address"),
                        rs.getString("phone"),
                        rs.getString("license_number"),
                        rs.getInt("vehicle_id")
                ));
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return users;
    }

    public User getUser(String id) {
        User user = null;
        try {
            Connection connection = DriverManager.getConnection(URL, USERNAME, PASSWORD);
            Statement statement = connection.createStatement();
            ResultSet rs = statement.executeQuery("SELECT id, username, role, status, name, address, phone, license_number, vehicle_id FROM auth_user WHERE id = '" + id + "'");
            if (rs.next()) {
                user = new User(
                        rs.getInt("id"),
                        rs.getString("username"),
                        null, // Avoid exposing password
                        rs.getString("role"),
                        rs.getString("status"),
                        rs.getString("name"),
                        rs.getString("address"),
                        rs.getString("phone"),
                        rs.getString("license_number"),
                        rs.getInt("vehicle_id")
                );
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return user;
    }

    public boolean registerUser(User user) {
        try {
            Connection connection = DriverManager.getConnection(URL, USERNAME, PASSWORD);
            Statement statement = connection.createStatement();
            int rows = statement.executeUpdate("INSERT INTO auth_user (username, password, role, status, name, address, phone, license_number, vehicle_id) VALUES ('" +
                    user.getUsername() + "', '" + user.getPassword() + "', '" + user.getRole() + "', '" + "ACTIVE" + "', '" + user.getName() + "', '" + user.getAddress() + "', '" + user.getPhone() + "', '" + user.getLicenseNumber() + "', " + (user.getVehicleId() != 0 ? user.getVehicleId() : "NULL") + ")");
            return rows > 0;
        } catch (SQLException e) {
            System.out.println(e);
        }
        return false;
    }

    public boolean updateUser(User user) {
        try {
            Connection connection = DriverManager.getConnection(URL, USERNAME, PASSWORD);
            Statement statement = connection.createStatement();
            int rows = statement.executeUpdate("UPDATE auth_user SET role = '" + user.getRole() + "', status = '" + user.getStatus() + "', name = '" + user.getName() + "', address = '" + user.getAddress() + "', phone = '" + user.getPhone() + "', license_number = '" + user.getLicenseNumber() + "', vehicle_id = " + (user.getVehicleId() != 0 ? user.getVehicleId() : "NULL") + " WHERE id = '" + user.getId() + "'");
            return rows > 0;
        } catch (SQLException e) {
            System.out.println(e);
        }
        return false;
    }

    public boolean deleteUser(String id) {
        try {
            Connection connection = DriverManager.getConnection(URL, USERNAME, PASSWORD);
            Statement statement = connection.createStatement();
            int rows = statement.executeUpdate("DELETE FROM auth_user WHERE id = '" + id + "'");
            return rows > 0;
        } catch (SQLException e) {
            System.out.println(e);
        }
        return false;
    }

    public User authenticate(String username, String password) {
        User user = null;
        try {
            Connection connection = DriverManager.getConnection(URL, USERNAME, PASSWORD);
            String query = "SELECT id, username, password, role, status, name, address, phone, license_number, vehicle_id FROM auth_user WHERE username = ? AND password = ?";
            PreparedStatement statement = connection.prepareStatement(query);
            statement.setString(1, username);
            statement.setString(2, password);
            ResultSet rs = statement.executeQuery();

            if (rs.next()) {
                user = new User(
                        rs.getInt("id"),
                        rs.getString("username"),
                        null, // Avoid exposing password
                        rs.getString("role"),
                        rs.getString("status"),
                        rs.getString("name"),
                        rs.getString("address"),
                        rs.getString("phone"),
                        rs.getString("license_number"),
                        rs.getInt("vehicle_id")
                );
            }

            // Close resources
            rs.close();
            statement.close();
            connection.close();
        } catch (SQLException e) {
            System.out.println("Database Error: " + e.getMessage());
        }
        return user;
    }

    public boolean updateUserStatus(int userId, String newStatus) {
        try {
            Connection connection = DriverManager.getConnection(URL, USERNAME, PASSWORD);
            String query = "UPDATE auth_user SET status = ? WHERE id = ?";
            PreparedStatement stmt = connection.prepareStatement(query);
            stmt.setString(1, newStatus);
            stmt.setInt(2, userId);

            int rows = stmt.executeUpdate();
            stmt.close();
            connection.close();

            return rows > 0;
        } catch (SQLException e) {
            System.out.println("Database Error: " + e.getMessage());
        }
        return false;
    }

    public boolean updateUserRole(int userId, String newRole) {
        try {
            Connection connection = DriverManager.getConnection(URL, USERNAME, PASSWORD);
            String query = "UPDATE auth_user SET role = ? WHERE id = ?";
            PreparedStatement stmt = connection.prepareStatement(query);
            stmt.setString(1, newRole);
            stmt.setInt(2, userId);

            int rows = stmt.executeUpdate();
            stmt.close();
            connection.close();

            return rows > 0;
        } catch (SQLException e) {
            System.out.println("Database Error: " + e.getMessage());
        }
        return false;
    }

}