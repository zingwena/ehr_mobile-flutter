package zw.gov.ehr_mobile.configuration.apolloClient;

import com.apollographql.apollo.ApolloCall;
import com.apollographql.apollo.ApolloClient;
import com.apollographql.apollo.api.Response;
import com.apollographql.apollo.exception.ApolloException;
import com.example.ehr_mobile.GetPatientsQuery;

import org.jetbrains.annotations.NotNull;
import org.junit.Test;

import java.util.List;

import okhttp3.OkHttpClient;
import zw.gov.mohcc.mrs.ehr_mobile.configuration.apolloClient.PatientsApolloClient;

public class PatientsApolloClientTest {

    private String SERVER_URL = "http://10.20.100.178:8080/api/graphql";
private String type;
    @Test
    public void getApolloClient() {


        OkHttpClient okHttpClient = new OkHttpClient.Builder()
                .build();

        ApolloClient.builder()
                .serverUrl(SERVER_URL)
                .okHttpClient(okHttpClient).build();

    }


    private void getNationalId() {

        PatientsApolloClient.getApolloClient().query(
                GetPatientsQuery.builder()
                        .build()).enqueue(
                new ApolloCall.Callback<GetPatientsQuery.Data>() {
                    String p;
                    @Override
                    public void onResponse(@NotNull Response<GetPatientsQuery.Data> response) {
                        List<GetPatientsQuery.Content> patients = response.data().people().content();
                        p= patients.get(0).identifications().get(0).type().name();


                    }

                    @Override
                    public void onFailure(@NotNull ApolloException e) {
                        System.out.println("Error =========" + e.toString());
                    }


                }

        );
    }

    @Test
    public void testNationalId() {

    }
//    private void typeIdentifier(String type) {
//        return type;
//    }

}