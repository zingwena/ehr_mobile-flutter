package zw.gov.mohcc.mrs.ehr_mobile.configuration.apolloClient;

import com.apollographql.apollo.ApolloCall;
import com.apollographql.apollo.ApolloClient;
import com.apollographql.apollo.api.Response;
import com.apollographql.apollo.exception.ApolloException;


import zw.gov.mohcc.mrs.ehr_mobile.GetPatientsQuery;
import zw.gov.mohcc.mrs.ehr_mobile.model.Patient;

import org.jetbrains.annotations.NotNull;

import java.util.List;

import okhttp3.OkHttpClient;

import zw.gov.mohcc.mrs.ehr_mobile.persistance.database.EhrMobileDatabase;



public class PatientsApolloClient {

    // GraphQL endpoint
//   private static final String SERVER_URL = "http://10.20.101.91:8080/api/graphql";
    private static final String SERVER_URL = "http://10.20.100.178:8080/api/graphql";
    private static Patient patient;

    public static ApolloClient getApolloClient() {


        OkHttpClient okHttpClient = new OkHttpClient.Builder()
                .build();

        return ApolloClient.builder()
                .serverUrl(SERVER_URL)
                .okHttpClient(okHttpClient).build();
    }


    public static void getPatientsFromEhr(EhrMobileDatabase ehrMobileDatabase) {
        PatientsApolloClient.getApolloClient().query(
                GetPatientsQuery.builder()
                        .build()).enqueue(
                new ApolloCall.Callback<GetPatientsQuery.Data>() {
                    @Override
                    public void onResponse(@NotNull Response<GetPatientsQuery.Data> response) throws IndexOutOfBoundsException {
                        List<GetPatientsQuery.Content> patients = response.data().people().content();
                        for (GetPatientsQuery.Content patientData : patients) {
                            int numberOfIdentifications = patientData.identifications().size();
                            String firstName = patientData.firstname();
                            String lastName = patientData.lastname();
                            String sex = patientData.sex().rawValue();
                            patient=new Patient(firstName,lastName,sex);


                                if(numberOfIdentifications>0)
                                {
                                    String identifierType= patientData.identifications().get(0).type().name();

                                    if(identifierType.equals("National Id")){
                                        String nationalId=patientData.identifications().get(0).number();

                                        patient.setNationalId(nationalId);
                                    }
                                    else {
                                        patient.setNationalId(null);

                                    }

                                }



                              ehrMobileDatabase.patientDao().createPatient(patient);
//                            System.out.println("Number of Patients  = " + ehrMobileDatabase.patientDao().listPatients().size());
                        }
                        System.out.println("Number of Patients  = " + ehrMobileDatabase.patientDao().listPatients().size());

                        System.out.println("\"Patient Table\" " + ehrMobileDatabase.patientDao().listPatients());


                    }

                    @Override
                    public void onFailure(@NotNull ApolloException e) {
                        System.out.println("Error =========" + e.toString());
                    }
                }
        );
    }


}