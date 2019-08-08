package zw.gov.mohcc.mrs.ehr_mobile.service;


<<<<<<< HEAD:android/app/src/main/java/com/example/ehr_mobile/service/DataSyncService.java
import com.example.ehr_mobile.model.Login;
<<<<<<< HEAD
import com.example.ehr_mobile.model.MaritalStates;

import com.example.ehr_mobile.model.Nationality;

import com.example.ehr_mobile.model.Occupation;
import com.example.ehr_mobile.model.Token;
import com.example.ehr_mobile.model.User;
=======
=======
import zw.gov.mohcc.mrs.ehr_mobile.model.Login;
>>>>>>> 4258c32598266336fb221bade71390de6190ae73:android/app/src/main/java/zw/gov/mohcc/mrs/ehr_mobile/service/DataSyncService.java

import zw.gov.mohcc.mrs.ehr_mobile.model.TerminologyModel;
import zw.gov.mohcc.mrs.ehr_mobile.model.Token;
import zw.gov.mohcc.mrs.ehr_mobile.model.User;
import com.google.gson.JsonObject;
>>>>>>> 13f365c51c920b76114be58885cbed5ead4d4829

import java.util.List;

import retrofit2.Call;
import retrofit2.http.Body;
import retrofit2.http.GET;
import retrofit2.http.Header;
import retrofit2.http.POST;

public interface DataSyncService {

<<<<<<< HEAD
    @GET("users")
    Call<List<User>>getAllUsers(@Header("Authorization") String token);

    @GET("marital-states")
    Call<MaritalStates> getMaritalStates(@Header("Authorization") String token);
=======
>>>>>>> 13f365c51c920b76114be58885cbed5ead4d4829

    @GET("nationalities")
    Call<Nationality> getNationality(@Header("Authorization") String token);

    @GET("occupations")
    Call<Occupation>getAllOccupations(@Header("Authorization") String token);


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
    Call<TerminologyModel> getOccupation(@Header("Authorization") String token);

    @GET("facilities")
    Call<JsonObject> getFacilities(@Header("Authorization")String authToken);

}
