package com.example.ehr_mobile.service;


import com.example.ehr_mobile.model.Login;

import com.example.ehr_mobile.model.MaritalState;
import com.example.ehr_mobile.model.Occupation;
import com.example.ehr_mobile.model.Token;
import com.example.ehr_mobile.model.User;
import com.google.gson.JsonObject;

import java.util.List;

import retrofit2.Call;
import retrofit2.http.Body;
import retrofit2.http.GET;
import retrofit2.http.Header;
import retrofit2.http.POST;

public interface DataSyncService {


    @POST("authenticate")
    Call<Token> dataSync(@Body Login login);


    @GET("users")
    Call<List<User>>getAllUsers(@Header("Authorization") String token);

    @GET("marital-states")
    Call<JsonObject> getMaritalStates(@Header("Authorization") String token);

    @GET("countries")
    Call<JsonObject> getCountries(@Header("Authorization")String authToken);

    @GET("countries")
    Call<JsonObject> getNationalities(@Header("Authorization")String authToken);

    @GET("occupations")
    Call<Occupation> getOccupation(@Header("Authorization") String token);

}
