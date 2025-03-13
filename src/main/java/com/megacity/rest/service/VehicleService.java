package com.megacity.rest.service;

import com.megacity.rest.entity.User;
import com.megacity.rest.entity.Vehicle;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

public class VehicleService {
    private static final String URL = "jdbc:oracle:thin:@//localhost:1522/FREEPDB1"; // SQLite database file path
    private static final String USERNAME = "MEGACITYCAB";
    private static final String PASSWORD = "123";

    public List<Vehicle> getVehicles() {
        List<Vehicle> vehicles = new ArrayList<>();
        try {
            Connection connection = DriverManager.getConnection(URL, USERNAME, PASSWORD);
            Statement statement = connection.createStatement();
            ResultSet rs = statement.executeQuery("SELECT * FROM vehicle");
            while (rs.next()) {
                vehicles.add(new Vehicle(
                        rs.getInt("id"),
                        rs.getString("model"),
                        rs.getString("numberPlate"),
                        rs.getString("status"),
                        rs.getInt("assignedDriverId")
                ));
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return vehicles;
    }

    public Vehicle getVehicle(int id) {
        Vehicle vehicle = null;
        try {
            Connection connection = DriverManager.getConnection(URL, USERNAME, PASSWORD);
            Statement statement = connection.createStatement();
            ResultSet rs = statement.executeQuery("SELECT * FROM vehicle WHERE id = " + id);
            if (rs.next()) {
                vehicle = new Vehicle(
                        rs.getInt("id"),
                        rs.getString("model"),
                        rs.getString("numberPlate"),
                        rs.getString("status"),
                        rs.getInt("assignedDriverId")
                );
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return vehicle;
    }

    public boolean addVehicle(Vehicle vehicle) {
        try {
            Connection connection = DriverManager.getConnection(URL, USERNAME, PASSWORD);
            Statement statement = connection.createStatement();
            int rows = statement.executeUpdate("INSERT INTO vehicle (model, numberPlate, status, assignedDriverId) VALUES ('" +
                    vehicle.getModel() + "', '" + vehicle.getNumberPlate() + "', '" + vehicle.getStatus() + "', " + vehicle.getAssignedDriverId() + ")");
            return rows > 0;
        } catch (SQLException e) {
            System.out.println(e);
        }
        return false;
    }

    public boolean updateVehicle(Vehicle vehicle) {
        try {
            Connection connection = DriverManager.getConnection(URL, USERNAME, PASSWORD);
            Statement statement = connection.createStatement();
            int rows = statement.executeUpdate("UPDATE vehicle SET model = '" + vehicle.getModel() + "', numberPlate = '" + vehicle.getNumberPlate() + "', status = '" + vehicle.getStatus() + "', assignedDriverId = " + vehicle.getAssignedDriverId() + " WHERE id = " + vehicle.getId());
            return rows > 0;
        } catch (SQLException e) {
            System.out.println(e);
        }
        return false;
    }

    public boolean deleteVehicle(int id) {
        try {
            Connection connection = DriverManager.getConnection(URL, USERNAME, PASSWORD);
            Statement statement = connection.createStatement();
            int rows = statement.executeUpdate("DELETE FROM vehicle WHERE id = " + id);
            return rows > 0;
        } catch (SQLException e) {
            System.out.println(e);
        }
        return false;
    }
}