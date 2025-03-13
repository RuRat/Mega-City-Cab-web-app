package com.megacity.rest.entity;


public class Customer {
    private int id;
    private int userId;
    private String name;
    private String address;
    private String phone;

    public Customer(int id, int userId, String name, String address, String phone) {
        this.id = id;
        this.userId = userId;
        this.name = name;
        this.address = address;
        this.phone = phone;
    }

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public int getUserId() { return userId; }
    public void setUserId(int userId) { this.userId = userId; }

    public String getName() { return name; }
    public void setName(String name) { this.name = name; }

    public String getAddress() { return address; }
    public void setAddress(String address) { this.address = address; }

    public String getPhone() { return phone; }
    public void setPhone(String phone) { this.phone = phone; }
}