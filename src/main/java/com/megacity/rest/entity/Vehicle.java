package com.megacity.rest.entity;

public class Vehicle {
    private int id;
    private String model;
    private String numberPlate;
    private String status;
    private int assignedDriverId;

    public Vehicle(int id, String model, String numberPlate, String status, int assignedDriverId) {
        this.id = id;
        this.model = model;
        this.numberPlate = numberPlate;
        this.status = status;
        this.assignedDriverId = assignedDriverId;
    }

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public String getModel() { return model; }
    public void setModel(String model) { this.model = model; }

    public String getNumberPlate() { return numberPlate; }
    public void setNumberPlate(String numberPlate) { this.numberPlate = numberPlate; }

    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }

    public int getAssignedDriverId() { return assignedDriverId; }
    public void setAssignedDriverId(int assignedDriverId) { this.assignedDriverId = assignedDriverId; }
}