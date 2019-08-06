package com.example.ehr_mobile.configuration;

import com.example.ehr_mobile.model.Login;
import com.example.ehr_mobile.model.Token;

import java.io.IOException;

import okhttp3.Interceptor;
import okhttp3.OkHttpClient;
import okhttp3.Request;
import okhttp3.Response;
import retrofit2.Call;
import retrofit2.Callback;
import retrofit2.Retrofit;
import retrofit2.converter.gson.GsonConverterFactory;

public class RetrofitClientInstance  {

    private  static Retrofit retrofit;

    private static  final String  BASE_URL="http://10.20.100.178:8080/api/";

    public static Retrofit getRetrofit(){
        retrofit = new retrofit2.Retrofit.Builder()
                .baseUrl(BASE_URL)
                .addConverterFactory(GsonConverterFactory.create())
                .build();
        return retrofit;
    }


}
