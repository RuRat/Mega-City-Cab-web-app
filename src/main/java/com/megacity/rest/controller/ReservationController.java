package com.megacity.rest.controller;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.megacity.rest.entity.Reservation;
import com.megacity.rest.entity.Vehicle;
import com.megacity.rest.service.ReservationService;
import com.megacity.rest.service.VehicleService;

import javax.ws.rs.Consumes;
import javax.ws.rs.DELETE;
import javax.ws.rs.GET;
import javax.ws.rs.POST;
import javax.ws.rs.PUT;
import javax.ws.rs.Path;
import javax.ws.rs.PathParam;
import javax.ws.rs.Produces;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;
import java.util.List;

@Path("reservation")
public class ReservationController {
    private final ReservationService reservationService = new ReservationService();
    private final Gson gson = new GsonBuilder().create();

    @GET
    @Produces(MediaType.APPLICATION_JSON)
    public String getReservations() {
        List<Reservation> reservations = reservationService.getReservations();
        return gson.toJson(reservations);
    }

    @GET
    @Path("/{id}")
    @Produces(MediaType.APPLICATION_JSON)
    public String getReservation(@PathParam("id") int id) {
        Reservation reservation = reservationService.getReservation(id);
        return gson.toJson(reservation);
    }

    @POST
    @Consumes(MediaType.APPLICATION_JSON)
    public Response createReservation(String json) {
        Reservation reservation = gson.fromJson(json, Reservation.class);
        boolean result = reservationService.createReservation(reservation);

        if (result) {
            return Response.status(201).entity("Reservation created successfully").build();
        } else {
            return Response.status(500).entity("Error creating reservation").build();
        }
    }

    @PUT
    @Path("/updateStatus")
    @Consumes(MediaType.APPLICATION_JSON)
    public Response updateReservationStatus(String json) {
        Reservation reservation = gson.fromJson(json, Reservation.class);
        boolean result = reservationService.updateReservationStatus(reservation.getId(), reservation.getStatus());

        if (result) {
            return Response.status(200).entity("Reservation status updated successfully").build();
        } else {
            return Response.status(500).entity("Error updating reservation status").build();
        }
    }
}
