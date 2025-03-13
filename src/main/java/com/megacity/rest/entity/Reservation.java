package com.megacity.rest.entity;


import com.fasterxml.jackson.annotation.JsonFormat;

import java.time.LocalDateTime;

public class Reservation {
    private int id;
    private int customerId;
    private int vehicleId;
    private int driverId;
    @JsonFormat(pattern = "yyyy-MM-dd'T'HH:mm:ss.SSSX")
    private LocalDateTime startTime;
    @JsonFormat(pattern = "yyyy-MM-dd'T'HH:mm:ss.SSSX")
    private LocalDateTime endTime;
    private String pickupLocation;
    private String destinationLocation;
    private String status;

    public Reservation(int id, int customerId, int vehicleId, int driverId, LocalDateTime startTime, LocalDateTime endTime, String pickupLocation, String destinationLocation, String status) {
        this.id = id;
        this.customerId = customerId;
        this.vehicleId = vehicleId;
        this.driverId = driverId;
        this.startTime = startTime;
        this.endTime = endTime;
        this.pickupLocation = pickupLocation;
        this.destinationLocation = destinationLocation;
        this.status = status;
    }

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public int getCustomerId() { return customerId; }
    public void setCustomerId(int customerId) { this.customerId = customerId; }

    public int getVehicleId() { return vehicleId; }
    public void setVehicleId(int vehicleId) { this.vehicleId = vehicleId; }

    public int getDriverId() { return driverId; }
    public void setDriverId(int driverId) { this.driverId = driverId; }

    public LocalDateTime getStartTime() { return startTime; }
    public void setStartTime(LocalDateTime startTime) { this.startTime = startTime; }

    public LocalDateTime getEndTime() { return endTime; }
    public void setEndTime(LocalDateTime endTime) { this.endTime = endTime; }

    public String getPickupLocation() { return pickupLocation; }
    public void setPickupLocation(String pickupLocation) { this.pickupLocation = pickupLocation; }

    public String getDestinationLocation() { return destinationLocation; }
    public void setDestinationLocation(String destinationLocation) { this.destinationLocation = destinationLocation; }

    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }
}
