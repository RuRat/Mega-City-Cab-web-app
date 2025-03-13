package com.megacity.rest.service;

import com.megacity.rest.entity.Invoice;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

public class InvoiceService {
    private static final String URL = "jdbc:oracle:thin:@//localhost:1522/FREEPDB1"; // SQLite database file path
    private static final String USERNAME = "MEGACITYCAB";
    private static final String PASSWORD = "123";

    public boolean generateInvoice(Invoice invoice) {
        try {
            Connection connection = DriverManager.getConnection(URL, USERNAME, PASSWORD);
            Statement statement = connection.createStatement();
            int rows = statement.executeUpdate("INSERT INTO invoice (reservationId, amount, tax, discount, totalAmount, paymentStatus, issuedAt, paidAt) VALUES ('" +
                    invoice.getReservationId() + "', '" + invoice.getAmount() + "', '" + invoice.getTax() + "', '" + invoice.getDiscount() + "', '" + invoice.getTotalAmount() + "', '" + invoice.getPaymentStatus() + "', '" + invoice.getIssuedAt() + "', " + (invoice.getPaidAt() != null ? "'" + invoice.getPaidAt() + "'" : "NULL") + ")");
            return rows > 0;
        } catch (SQLException e) {
            System.out.println(e);
        }
        return false;
    }

    public List<Invoice> getInvoices() {
        List<Invoice> invoices = new ArrayList<>();
        try {
            Connection connection = DriverManager.getConnection(URL, USERNAME, PASSWORD);
            Statement statement = connection.createStatement();
            ResultSet rs = statement.executeQuery("SELECT * FROM invoice");
            while (rs.next()) {
                invoices.add(new Invoice(
                        rs.getInt("id"),
                        rs.getInt("reservationId"),
                        rs.getDouble("amount"),
                        rs.getDouble("tax"),
                        rs.getDouble("discount"),
                        rs.getDouble("totalAmount"),
                        rs.getString("paymentStatus"),
                        rs.getTimestamp("issuedAt").toLocalDateTime(),
                        rs.getTimestamp("paidAt") != null ? rs.getTimestamp("paidAt").toLocalDateTime() : null
                ));
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return invoices;
    }
}
