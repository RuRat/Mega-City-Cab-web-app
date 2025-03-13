package com.megacity.rest.entity;

public class Driver {
    private int id;
    private int userId;
    private String licenseNumber;
    private int vehicleId;

    public Driver(int id, int userId, String licenseNumber, int vehicleId) {
        this.id = id;
        this.userId = userId;
        this.licenseNumber = licenseNumber;
        this.vehicleId = vehicleId;
    }

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public int getUserId() { return userId; }
    public void setUserId(int userId) { this.userId = userId; }

    public String getLicenseNumber() { return licenseNumber; }
    public void setLicenseNumber(String licenseNumber) { this.licenseNumber = licenseNumber; }

    public int getVehicleId() { return vehicleId; }
    public void setVehicleId(int vehicleId) { this.vehicleId = vehicleId; }
}