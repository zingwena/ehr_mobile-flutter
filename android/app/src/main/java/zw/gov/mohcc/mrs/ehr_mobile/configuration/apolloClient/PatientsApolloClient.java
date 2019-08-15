package zw.gov.mohcc.mrs.ehr_mobile.configuration.apolloClient;

import android.os.Build;

import androidx.annotation.RequiresApi;

import com.apollographql.apollo.ApolloCall;
import com.apollographql.apollo.ApolloClient;
import com.apollographql.apollo.api.Response;
import com.apollographql.apollo.exception.ApolloException;


import zw.gov.mohcc.mrs.ehr_mobile.GetPatientsQuery;
import zw.gov.mohcc.mrs.ehr_mobile.model.Address;
import zw.gov.mohcc.mrs.ehr_mobile.model.Country;
import zw.gov.mohcc.mrs.ehr_mobile.model.EducationLevel;
import zw.gov.mohcc.mrs.ehr_mobile.model.MaritalStatus;
import zw.gov.mohcc.mrs.ehr_mobile.model.Nationality;
import zw.gov.mohcc.mrs.ehr_mobile.model.Occupation;
import zw.gov.mohcc.mrs.ehr_mobile.model.Patient;

import org.jetbrains.annotations.NotNull;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.time.LocalDate;

import java.util.List;

import okhttp3.OkHttpClient;

import zw.gov.mohcc.mrs.ehr_mobile.model.Religion;
import zw.gov.mohcc.mrs.ehr_mobile.model.Gender;
import zw.gov.mohcc.mrs.ehr_mobile.model.SelfIdentifiedGender;
import zw.gov.mohcc.mrs.ehr_mobile.persistance.database.EhrMobileDatabase;


public class PatientsApolloClient {

    // GraphQL endpoint
   private static final String SERVER_URL = "http://10.20.101.91:8080/api/graphql";
 //       private static final String SERVER_URL = "http://10.20.100.178:8080/api/graphql";
    private static Patient patient;

    public static ApolloClient getApolloClient() {


        OkHttpClient okHttpClient = new OkHttpClient.Builder()
                .build();

        return ApolloClient.builder()
                .serverUrl(SERVER_URL)
                .okHttpClient(okHttpClient).build();
    }


    public static void getPatientsFromEhr(final EhrMobileDatabase ehrMobileDatabase) {
        PatientsApolloClient.getApolloClient().query(
                GetPatientsQuery.builder()
                        .build()).enqueue(
                new ApolloCall.Callback<GetPatientsQuery.Data>() {
                    @RequiresApi(api = Build.VERSION_CODES.O)
                    @Override
                    public void onResponse(@NotNull Response<GetPatientsQuery.Data> response) throws IndexOutOfBoundsException {
                        List<GetPatientsQuery.Content> patients = response.data().people().content();
                        for (GetPatientsQuery.Content patientData : patients)
                            try {
                                {


                                    Gender sex = Gender.valueOf(patientData.sex().rawValue());
                                    SelfIdentifiedGender selfIdentifiedGender = SelfIdentifiedGender.valueOf(patientData.selfIdentifiedGender().rawValue());
                                    Address address = new Address(patientData.address().street(), patientData.address().city(), patientData.address().town().name());

                                    int numberOfIdentifications = patientData.identifications().size();
                                    String firstName = patientData.firstname();
                                    String lastName = patientData.lastname();
                                    String date = patientData.birthdate();

                                    int age = patientData.age().years();


                                    patient = new Patient(firstName, lastName);
//                                    patient.setReligionCode(patientData.religion().id());
//                                    patient.setAge(age);
//                                    patient.setCountryOfBirthCode(patientData.countryOfBirth().id());
//                                    patient.setEducationLevelCode(patientData.education().id());
//                                    patient.setAddress(address);
//                                    patient.setMaritalStatusCode(patientData.marital().id());
//                                    patient.setNationalityCode(patientData.nationality().id());
//                                    patient.setSelfIdentifiedGender(selfIdentifiedGender);
//                                    patient.setOccupationCode(patientData.occupation().id());

                                    try {
                                        LocalDate dateOfBirth = LocalDate.parse(date);
                                        System.out.println("dateOfBirth = " + dateOfBirth);
//                                        patient.setBirthDate(dateOfBirth);


                                    } catch (Exception e) {
                                        e.printStackTrace();
                                    }

                                    if (numberOfIdentifications > 0) {
                                        String identifierType = patientData.identifications().get(0).type().name();

                                        if (identifierType.equals("National Id")) {
                                            String nationalId = patientData.identifications().get(0).number();

                                            patient.setNationalId(nationalId);
                                        } else {
                                            patient.setNationalId(null);

                                        }


                                    }

                                    ehrMobileDatabase.patientDao().createPatient(patient);

                                    System.out.println("Number of Patients  = " + ehrMobileDatabase.patientDao().listPatients().size());
                                }
                            } catch (Exception e) {
                                e.printStackTrace()
                                ;

                                System.out.println("e = " + e.getLocalizedMessage());
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