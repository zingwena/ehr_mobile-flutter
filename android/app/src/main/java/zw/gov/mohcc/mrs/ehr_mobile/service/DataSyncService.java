package zw.gov.mohcc.mrs.ehr_mobile.service;


import zw.gov.mohcc.mrs.ehr_mobile.model.Login;

import zw.gov.mohcc.mrs.ehr_mobile.model.TerminologyModel;
import zw.gov.mohcc.mrs.ehr_mobile.model.Token;
import zw.gov.mohcc.mrs.ehr_mobile.model.User;
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
    Call<TerminologyModel> getMaritalStates(@Header("Authorization") String token);

    @GET("countries")
    Call<JsonObject> getCountries(@Header("Authorization")String authToken);

    @GET("nationalities")
    Call<TerminologyModel> getNationalities(@Header("Authorization")String authToken);

    @GET("occupations")
    Call<TerminologyModel> getOccupation(@Header("Authorization") String token);

    @GET("facilities")
    Call<JsonObject> getFacilities(@Header("Authorization")String authToken);

    @GET("religions")
    Call<TerminologyModel> getReligion(@Header("Authorization") String token);

}
