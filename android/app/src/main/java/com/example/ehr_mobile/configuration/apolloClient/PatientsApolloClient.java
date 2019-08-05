package com.example.ehr_mobile.configuration.apolloClient;

import com.apollographql.apollo.ApolloCall;
import com.apollographql.apollo.ApolloClient;
import com.apollographql.apollo.api.Response;
import com.apollographql.apollo.exception.ApolloException;
import com.example.ehr_mobile.GetPatientsQuery;
import com.example.ehr_mobile.model.Patient;

import org.jetbrains.annotations.NotNull;

import java.util.List;

import okhttp3.OkHttpClient;

import static java.util.Objects.requireNonNull;

public class PatientsApolloClient {

    // GraphQL endpoint
    private static final String SERVER_URL = "http://10.20.101.91:8080/api/graphql";
    // private static final String SERVER_URL = "http://10.20.100.178:8080/api/graphql";
    private static Patient patient;

    public static ApolloClient getApolloClient() {


        OkHttpClient okHttpClient = new OkHttpClient.Builder()
                .build();

        return ApolloClient.builder()
                .serverUrl(SERVER_URL)
                .okHttpClient(okHttpClient).build();
    }


    public static void getPatientsFromEhr() {
        patient = new Patient();
        PatientsApolloClient.getApolloClient().query(
                GetPatientsQuery.builder()
                        .build()).enqueue(
                new ApolloCall.Callback<GetPatientsQuery.Data>() {
                    @Override
                    public void onResponse(@NotNull Response<GetPatientsQuery.Data> response) {
                        List<GetPatientsQuery.Content> patients = response.data().people().content();
                        for (GetPatientsQuery.Content patientData : patients) {
                            System.out.println("Response =========" + patientData.toString());
                            patient.setFirstName(requireNonNull(patientData.firstname()));
                            patient.setLastName(requireNonNull(patientData.lastname()));
                            patient.setAge(patientData.age().years());
                            patient.setReligion(patientData.religion().name());
//                             patient.setReligion(patientData.religion().name());
//                             patient.setNumber(patientData.identifications().get(0).number());
//                                patient.setBirthDate(new Date(patientData.birthdate()));
//                                patient.setMaritalStatus(patientData.marital().name());


                        }
                    }

                    @Override
                    public void onFailure(@NotNull ApolloException e) {
                        System.out.println("Error =========" + e.toString());
                    }
                }
        );
    }
}
