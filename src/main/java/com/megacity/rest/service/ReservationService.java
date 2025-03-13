package com.megacity.rest.service;

import com.megacity.rest.entity.Reservation;
import com.megacity.rest.entity.Vehicle;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

public class ReservationService {
    private static final String URL = "jdbc:oracle:thin:@//localhost:1522/FREEPDB1"; // SQLite database file path
    private static final String USERNAME = "MEGACITYCAB";
    private static final String PASSWORD = "123";
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
                        rs.getTimestamp("startTime").toLocalDateTime(),
                        rs.getTimestamp("endTime").toLocalDateTime(),
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
            Statement statement = connection.createStatement();
            int rows = statement.executeUpdate("INSERT INTO reservation (customerId, vehicleId, driverId, startTime, endTime, pickupLocation, destinationLocation, status) VALUES ('" +
                    reservation.getCustomerId() + "', '" + reservation.getVehicleId() + "', '" + reservation.getDriverId() + "', '" + reservation.getStartTime() + "', '" + reservation.getEndTime() + "', '" + reservation.getPickupLocation() + "', '" + reservation.getDestinationLocation() + "', '" + reservation.getStatus() + "')");
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
