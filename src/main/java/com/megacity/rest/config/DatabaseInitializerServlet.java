package com.megacity.rest.config;

import com.megacity.rest.service.DatabaseInitializer;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;

public class DatabaseInitializerServlet extends HttpServlet {
    @Override
    public void init() throws ServletException {
        System.out.println("🚀 Database Initialization Started...");
        DatabaseInitializer.initializeDatabase();
        System.out.println("✅ Database Initialization Completed.");
    }
}
