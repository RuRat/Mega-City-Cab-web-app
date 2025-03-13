package com.megacity.rest.entity;
import java.time.LocalDateTime;

public class Invoice {
    private int id;
    private int reservationId;
    private double amount;
    private double tax;
    private double discount;
    private double totalAmount;
    private String paymentStatus;
    private LocalDateTime issuedAt;
    private LocalDateTime paidAt;

    public Invoice(int id, int reservationId, double amount, double tax, double discount, double totalAmount, String paymentStatus, LocalDateTime issuedAt, LocalDateTime paidAt) {
        this.id = id;
        this.reservationId = reservationId;
        this.amount = amount;
        this.tax = tax;
        this.discount = discount;
        this.totalAmount = totalAmount;
        this.paymentStatus = paymentStatus;
        this.issuedAt = issuedAt;
        this.paidAt = paidAt;
    }

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public int getReservationId() { return reservationId; }
    public void setReservationId(int reservationId) { this.reservationId = reservationId; }

    public double getAmount() { return amount; }
    public void setAmount(double amount) { this.amount = amount; }

    public double getTax() { return tax; }
    public void setTax(double tax) { this.tax = tax; }

    public double getDiscount() { return discount; }
    public void setDiscount(double discount) { this.discount = discount; }

    public double getTotalAmount() { return totalAmount; }
    public void setTotalAmount(double totalAmount) { this.totalAmount = totalAmount; }

    public String getPaymentStatus() { return paymentStatus; }
    public void setPaymentStatus(String paymentStatus) { this.paymentStatus = paymentStatus; }

    public LocalDateTime getIssuedAt() { return issuedAt; }
    public void setIssuedAt(LocalDateTime issuedAt) { this.issuedAt = issuedAt; }

    public LocalDateTime getPaidAt() { return paidAt; }
    public void setPaidAt(LocalDateTime paidAt) { this.paidAt = paidAt; }
}
