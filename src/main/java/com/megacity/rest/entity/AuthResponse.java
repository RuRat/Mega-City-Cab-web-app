package com.megacity.rest.entity;

public class AuthResponse {
    String status;
    User user;

    public AuthResponse(String status, User user) {
        this.status = status;
        this.user = user;
    }
}