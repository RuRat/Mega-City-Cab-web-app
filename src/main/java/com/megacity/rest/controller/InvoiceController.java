package com.megacity.rest.controller;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.megacity.rest.entity.Invoice;
import com.megacity.rest.service.InvoiceService;

import javax.ws.rs.Consumes;
import javax.ws.rs.GET;
import javax.ws.rs.POST;
import javax.ws.rs.Path;
import javax.ws.rs.Produces;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;
import java.util.List;

@Path("invoice")
public class InvoiceController {
    private final InvoiceService invoiceService = new InvoiceService();
    private final Gson gson = new GsonBuilder().create();

    @POST
    @Path("/generate")
    @Consumes(MediaType.APPLICATION_JSON)
    public Response generateInvoice(String json) {
        Invoice invoice = gson.fromJson(json, Invoice.class);
        boolean result = invoiceService.generateInvoice(invoice);

        if (result) {
            return Response.status(201).entity("Invoice generated successfully").build();
        } else {
            return Response.status(500).entity("Error generating invoice").build();
        }

    }

    @GET
    @Produces(MediaType.APPLICATION_JSON)
    public String getInvoices() {
        List<Invoice> invoices = invoiceService.getInvoices();
        return gson.toJson(invoices);
    }
}
