package com.megacity.rest.controller;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.megacity.rest.entity.AuthResponse;
import com.megacity.rest.entity.User;
import com.megacity.rest.service.UserService;

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

@Path("/user")
public class UserController {
    private final UserService userService = new UserService();
    private final Gson gson = new GsonBuilder().create();

    @GET
    @Produces(MediaType.APPLICATION_JSON)
    public String getUsers() {
        return gson.toJson(userService.getUsers());
    }

    @POST
    @Path("/register")
    @Consumes(MediaType.APPLICATION_JSON)
    @Produces(MediaType.APPLICATION_JSON)
    public Response registerUser(String json) {
        User user = gson.fromJson(json, User.class);
        boolean result = userService.registerUser(user);

        if (result) {
            return Response.status(Response.Status.CREATED)
                    .entity("User registered successfully")
                    .build();
        } else {
            return Response.status(Response.Status.INTERNAL_SERVER_ERROR)
                    .entity("Failed to register user")
                    .build();
        }
    }


    @POST
    @Path("/login")
    @Consumes(MediaType.APPLICATION_JSON)
    @Produces(MediaType.APPLICATION_JSON)
    public Response loginUser(String json) {
        User credentials = gson.fromJson(json, User.class);
        User authenticatedUser = userService.authenticate(credentials.getUsername(), credentials.getPassword());

        if (authenticatedUser != null) {
            return Response.status(Response.Status.OK)
                    .entity(gson.toJson(new AuthResponse("SUCCESS", authenticatedUser)))
                    .build();
        } else {
            return Response.status(Response.Status.UNAUTHORIZED)
                    .entity(gson.toJson(new AuthResponse("FAILURE", null)))
                    .build();
        }
    }


    @GET
    @Path("/{id}")
    @Produces(MediaType.APPLICATION_JSON)
    public String getUser(@PathParam("id") String id) {
        return gson.toJson(userService.getUser(id));
    }


    @PUT
    @Consumes(MediaType.APPLICATION_JSON)
    public Response updateUser(String json) {
        User user = gson.fromJson(json, User.class);
        boolean result = userService.updateUser(user);

        if (result) {
            return Response.status(200).entity("Successfully updated").build();
        } else {
            return Response.status(501).entity("Error occurred").build();
        }
    }

    @DELETE
    @Path("/{id}")
    public Response deleteUser(@PathParam("id") String id) {
        boolean result = userService.deleteUser(id);
        if (result) {
            return Response.status(200).entity("Successfully deleted").build();
        } else {
            return Response.status(501).entity("Error occurred").build();
        }
    }

    @PUT
    @Path("/updateStatus")
    @Consumes(MediaType.APPLICATION_JSON)
    public Response updateUserStatus(String json) {
        User user = gson.fromJson(json, User.class);
        boolean result = userService.updateUserStatus(user.getId(), user.getStatus());

        if (result) {
            return Response.status(200).entity("User status updated successfully").build();
        } else {
            return Response.status(500).entity("Failed to update user status").build();
        }
    }

    @PUT
    @Path("/updateRole")
    @Consumes(MediaType.APPLICATION_JSON)
    public Response updateUserRole(String json) {
        User user = gson.fromJson(json, User.class);
        boolean result = userService.updateUserRole(user.getId(), user.getRole());

        if (result) {
            return Response.status(200).entity("User role updated successfully").build();
        } else {
            return Response.status(500).entity("Failed to update user role").build();
        }
    }

    @GET
    @Path("/role/drivers")
    @Produces(MediaType.APPLICATION_JSON)
    public String getDrivers() {
        return gson.toJson(userService.getUsersByRole("DRIVER"));
    }

}
