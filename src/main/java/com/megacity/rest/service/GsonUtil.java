package com.megacity.rest.service;

import com.google.gson.*;
import java.lang.reflect.Type;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

public class GsonUtil {
    private static final DateTimeFormatter FORMATTER = DateTimeFormatter.ofPattern("yyyy-MM-dd'T'HH:mm:ss.SSSX");

    public static final Gson gson = new GsonBuilder()
            .registerTypeAdapter(LocalDateTime.class, new JsonDeserializer<LocalDateTime>() {
                @Override
                public LocalDateTime deserialize(JsonElement json, Type typeOfT, JsonDeserializationContext context) throws JsonParseException {
                    return LocalDateTime.parse(json.getAsJsonPrimitive().getAsString(), FORMATTER);
                }
            })
            .registerTypeAdapter(LocalDateTime.class, new JsonSerializer<LocalDateTime>() {
                @Override
                public JsonElement serialize(LocalDateTime localDateTime, Type typeOfSrc, JsonSerializationContext context) {
                    return new JsonPrimitive(FORMATTER.format(localDateTime));
                }
            })
            .create();
}
