package com.example.ehr_mobile.service;


import com.example.ehr_mobile.model.Login;
import com.example.ehr_mobile.model.MaritalStates;
import com.example.ehr_mobile.model.Nationality;
import com.example.ehr_mobile.model.Occupation;
import com.example.ehr_mobile.model.Token;
import com.example.ehr_mobile.model.User;

import java.util.List;

import retrofit2.Call;
import retrofit2.http.Body;
import retrofit2.http.GET;
import retrofit2.http.Header;
import retrofit2.http.POST;

public interface DataSyncService {

    @GET("users")
    Call<List<User>>getAllUsers(@Header("Authorization") String token);

    @GET("marital-states")
    Call<MaritalStates> getMaritalStates(@Header("Authorization") String token);

    @GET("nationalities")
    Call<Nationality> getNationality(@Header("Authorization") String token);

    @GET("occupations")
    Call<Occupation>getAllOccupations(@Header("Authorization") String token);


    @POST("authenticate")
    Call<Token> dataSync(@Body Login login);
}
