package zw.gov.mohcc.mrs.ehr_mobile.configuration;

import retrofit2.Retrofit;
import retrofit2.converter.gson.GsonConverterFactory;

public class RetrofitClientInstance  {

    private  static Retrofit retrofit;

    //private static  final String  BASE_URL="http://10.20.100.178:8080/api/";
    private static  final String  BASE_URL="http://10.20.101.91:8080/api/";


    public static Retrofit getRetrofit(){
        retrofit = new retrofit2.Retrofit.Builder()
                .baseUrl(BASE_URL)
                .addConverterFactory(GsonConverterFactory.create())
                .build();
        return retrofit;
    }


}
