package com.example.ehr_mobile.configuration;

import retrofit2.Retrofit;
import retrofit2.converter.gson.GsonConverterFactory;

public class RetrofitClient {

    public static Retrofit INSTANCE;

    public static Retrofit getRetrofitInstance(String baseUrl){

         INSTANCE = new Retrofit.Builder().baseUrl(baseUrl)
                  .addConverterFactory(GsonConverterFactory.create())
                 .build();



        return INSTANCE;

    }

}
