package zw.gov.mohcc.mrs.ehr_mobile.configuration;


import zw.gov.mohcc.mrs.ehr_mobile.model.Login;
import zw.gov.mohcc.mrs.ehr_mobile.model.Token;
import zw.gov.mohcc.mrs.ehr_mobile.model.User;
import com.google.gson.JsonObject;

import java.util.List;

import retrofit2.Call;
import retrofit2.http.Body;
import retrofit2.http.GET;
import retrofit2.http.Header;
import retrofit2.http.POST;


public interface DataService {

    @POST("authenticate")
    Call<Token> getToken(@Body Login login);

    @GET("users")
    Call<List<User>>getAllUsers(@Header("Authorization") String token);

    @GET("marital-states")
    Call<JsonObject> getMaritalStates(@Header("Authorization") String token);

    @GET("countries")
    Call<JsonObject> getCountries(@Header("Authorization")String authToken);

}
