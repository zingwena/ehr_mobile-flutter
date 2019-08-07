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

import com.example.ehr_mobile.persistance.database.EhrMobileDatabase;
public class PatientsApolloClient {

    // GraphQL endpoint
   private static final String SERVER_URL = "http://10.20.101.91:8080/api/graphql";
//    private static final String SERVER_URL = "http://10.20.100.178:8080/api/graphql";
    private static Patient patient;

    public static ApolloClient getApolloClient() {


        OkHttpClient okHttpClient = new OkHttpClient.Builder()
                .build();

        return ApolloClient.builder()
                .serverUrl(SERVER_URL)
                .okHttpClient(okHttpClient).build();
    }


    public static void getPatientsFromEhr(EhrMobileDatabase ehrMobileDatabase) {
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

                            patient.setFirstName(handleNullField(patientData.firstname()));
                            patient.setLastName(handleNullField(patientData.lastname()));
                            patient.setAge(patientData.age().years());
                            patient.setSex(handleNullField(patientData.sex().rawValue()));
//                            patient.setReligion(handleNullField(patientData.religion().name()));
//                            patient.setNumber(handleNullField(patientData.identifications().get(0).number()));
//                            patient.setBirthDate(handleNullField(patientData.birthdate()));
//                            patient.setMaritalStatus(handleNullField(patientData.marital().name()));
//                            patient.setEducationLevel(handleNullField(patientData.education().name()));
//                            patient.setOccupation(handleNullField(patientData.occupation().name()));
//                            patient.setSelfIdentifiedGender(handleNullField(patientData.selfIdentifiedGender().rawValue()));
//                            patient.setTown(handleNullField(patientData.address().town().name()));
//                            patient.setSchoolHouse(handleNullField(patientData.address().street()));
                            ehrMobileDatabase.patientDao().createPatient(patient);


                        }


                    }

                    @Override
                    public void onFailure(@NotNull ApolloException e) {
                        System.out.println("Error =========" + e.toString());
                    }
                }
        );
    }


    private static String handleNullField(String field) {
        if (field == null) {
            return "";
        }
        return field;
    }
}