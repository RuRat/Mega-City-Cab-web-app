package com.megacity.rest.controller;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.megacity.rest.entity.User;
import com.megacity.rest.entity.Vehicle;
import com.megacity.rest.service.UserService;

import javax.ws.rs.Consumes;
import javax.ws.rs.DELETE;
import javax.ws.rs.GET;
import javax.ws.rs.PUT;
import javax.ws.rs.Path;
import javax.ws.rs.PathParam;
import javax.ws.rs.Produces;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.megacity.rest.service.VehicleService;

import javax.ws.rs.*;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;
import java.util.List;

@Path("vehicle")
public class VehicleController {
    private final VehicleService vehicleService = new VehicleService();
    private final Gson gson = new GsonBuilder().create();

    @GET
    @Produces(MediaType.APPLICATION_JSON)
    public String getVehicles() {
        List<Vehicle> vehicles = vehicleService.getVehicles();
        return gson.toJson(vehicles);
    }

    @GET
    @Path("/{id}")
    @Produces(MediaType.APPLICATION_JSON)
    public String getVehicle(@PathParam("id") int id) {
        Vehicle vehicle = vehicleService.getVehicle(id);
        return gson.toJson(vehicle);
    }

    @POST
    @Consumes(MediaType.APPLICATION_JSON)
    public Response addVehicle(String json) {
        Vehicle vehicle = gson.fromJson(json, Vehicle.class);
        boolean result = vehicleService.addVehicle(vehicle);

        if (result) {
            return Response.status(201).entity("Vehicle added successfully").build();
        } else {
            return Response.status(500).entity("Error adding vehicle").build();
        }
    }

    @PUT
    @Consumes(MediaType.APPLICATION_JSON)
    public Response updateVehicle(String json) {
        Vehicle vehicle = gson.fromJson(json, Vehicle.class);
        boolean result = vehicleService.updateVehicle(vehicle);

        if (result) {
            return Response.status(200).entity("Vehicle updated successfully").build();
        } else {
            return Response.status(500).entity("Error updating vehicle").build();
        }
    }

    @DELETE
    @Path("/{id}")
    public Response deleteVehicle(@PathParam("id") int id) {
        boolean result = vehicleService.deleteVehicle(id);
        if (result) {
            return Response.status(200).entity("Vehicle deleted successfully").build();
        } else {
            return Response.status(500).entity("Error deleting vehicle").build();
        }
    }

    @PUT
    @Path("/assignDriver")
    @Consumes(MediaType.APPLICATION_JSON)
    @Produces(MediaType.APPLICATION_JSON)
    public Response assignDriver(String json) {
        Vehicle vehicle = gson.fromJson(json, Vehicle.class);
        boolean result = vehicleService.assignDriver(vehicle.getId(), vehicle.getAssignedDriverId());

        if (result) {
            return Response.status(200).entity("{\"message\": \"Driver assigned successfully.\"}").build();
        } else {
            return Response.status(500).entity("{\"message\": \"Failed to assign driver.\"}").build();
        }
    }
}
