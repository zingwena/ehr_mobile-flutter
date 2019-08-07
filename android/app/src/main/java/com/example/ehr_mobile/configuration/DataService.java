package com.example.ehr_mobile.configuration;

import com.example.ehr_mobile.model.Facilities;
import com.example.ehr_mobile.model.Login;
import com.example.ehr_mobile.model.MaritalStates;
import com.example.ehr_mobile.model.Nationality;
import com.example.ehr_mobile.model.Token;
import com.example.ehr_mobile.model.User;

import java.util.List;

import retrofit2.Call;
import retrofit2.http.Body;
import retrofit2.http.GET;
import retrofit2.http.Header;
import retrofit2.http.POST;


public interface DataService {

    @GET("users")
    Call<List<User>>getAllUsers(@Header("Authorization") String token);

    @GET("marital-states")
    Call<MaritalStates> getMaritalStates(@Header("Authorization") String token);

    @GET("nationalities")
    Call<Nationality> getNationality(@Header("Authorization") String token);
    @GET("facilities")
//    Call<List<Facilities>> getAllFacility(@Header("Authorization") String Token);
    Call<Facilities>getAllFacilities(@Header("Authorization") String Token);

    @POST("authenticate")
    Call<Token> getToken(@Body Login login);
}
