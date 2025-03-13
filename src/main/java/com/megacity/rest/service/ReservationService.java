package com.megacity.rest.service;

import com.megacity.rest.entity.Reservation;
import com.megacity.rest.entity.Vehicle;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Timestamp;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;

public class ReservationService {
    private static final String URL = "jdbc:mysql://localhost:3306/test_db"; // SQLite database file path
    private static final String USERNAME = "root";
    private static final String PASSWORD = "z123";
    
    public List<Reservation> getReservations() {
        List<Reservation> reservations = new ArrayList<>();
        try {
            Connection connection = DriverManager.getConnection(URL, USERNAME, PASSWORD);
            Statement statement = connection.createStatement();
            ResultSet rs = statement.executeQuery("SELECT * FROM reservation");
            while (rs.next()) {
                reservations.add(new Reservation(
                        rs.getInt("id"),
                        rs.getInt("customerId"),
                        rs.getInt("vehicleId"),
                        rs.getInt("driverId"),
                        rs.getTimestamp("startTime") != null ? rs.getTimestamp("startTime").toLocalDateTime() : null,
                        rs.getTimestamp("endTime") != null ? rs.getTimestamp("endTime").toLocalDateTime() : null,
                        rs.getString("pickupLocation"),
                        rs.getString("destinationLocation"),
                        rs.getString("status")
                ));
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return reservations;
    }

    public Reservation getReservation(int id) {
        Reservation reservation = null;
        try {
            Connection connection = DriverManager.getConnection(URL, USERNAME, PASSWORD);
            Statement statement = connection.createStatement();
            ResultSet rs = statement.executeQuery("SELECT * FROM reservation WHERE id = " + id);
            if (rs.next()) {
                reservation = new Reservation(
                        rs.getInt("id"),
                        rs.getInt("customerId"),
                        rs.getInt("vehicleId"),
                        rs.getInt("driverId"),
                        rs.getTimestamp("startTime").toLocalDateTime(),
                        rs.getTimestamp("endTime").toLocalDateTime(),
                        rs.getString("pickupLocation"),
                        rs.getString("destinationLocation"),
                        rs.getString("status")
                );
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return reservation;
    }

    public boolean createReservation(Reservation reservation) {
        try {
            Connection connection = DriverManager.getConnection(URL, USERNAME, PASSWORD);

            String driverQuery = "SELECT assignedDriverId FROM vehicle WHERE id = ?";
            PreparedStatement driverStmt = connection.prepareStatement(driverQuery);
            driverStmt.setLong(1, reservation.getVehicleId());
            ResultSet rs = driverStmt.executeQuery();

            Long driverId = null;
            if (rs.next()) {
                driverId = rs.getLong("assignedDriverId");
            }

            if (driverId == null) {
                System.out.println("No driver assigned to the selected vehicle.");
                return false;
            }

            String sql = "INSERT INTO reservation (customerId, vehicleId, driverId, startTime, endTime, pickupLocation, destinationLocation, status) " +
                    "VALUES (?, ?, ?, ?, ?, ?, ?, ?)";

            PreparedStatement statement = connection.prepareStatement(sql);
            statement.setLong(1, reservation.getCustomerId());
            statement.setLong(2, reservation.getVehicleId());
            statement.setLong(3, driverId);
            statement.setTimestamp(4, reservation.getStartTime() == null ? null : Timestamp.valueOf(reservation.getStartTime()));
            statement.setTimestamp(5, reservation.getEndTime() == null ? null : Timestamp.valueOf(reservation.getEndTime()));
            statement.setString(6, reservation.getPickupLocation());
            statement.setString(7, reservation.getDestinationLocation());
            statement.setString(8, reservation.getStatus());
            int rows = statement.executeUpdate();
            return rows > 0;
        } catch (SQLException e) {
            System.out.println(e);
        }
        return false;
    }

    public boolean updateReservationStatus(int id, String status) {
        try {
            Connection connection = DriverManager.getConnection(URL, USERNAME, PASSWORD);
            Statement statement = connection.createStatement();
            int rows = statement.executeUpdate("UPDATE reservation SET status = '" + status + "' WHERE id = " + id);
            return rows > 0;
        } catch (SQLException e) {
            System.out.println(e);
        }
        return false;
    }
}
