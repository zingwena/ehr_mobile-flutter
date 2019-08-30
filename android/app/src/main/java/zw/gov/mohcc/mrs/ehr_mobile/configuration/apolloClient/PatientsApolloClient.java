package zw.gov.mohcc.mrs.ehr_mobile.configuration.apolloClient;

import android.os.Build;

import androidx.annotation.RequiresApi;

import com.apollographql.apollo.ApolloCall;
import com.apollographql.apollo.ApolloClient;
import com.apollographql.apollo.api.Response;
import com.apollographql.apollo.exception.ApolloException;

import org.apache.commons.lang3.StringUtils;
import org.jetbrains.annotations.NotNull;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Locale;

import okhttp3.OkHttpClient;
import zw.gov.mohcc.mrs.ehr_mobile.GetPatientsQuery;
import zw.gov.mohcc.mrs.ehr_mobile.model.Address;
import zw.gov.mohcc.mrs.ehr_mobile.model.Gender;
import zw.gov.mohcc.mrs.ehr_mobile.model.Patient;
import zw.gov.mohcc.mrs.ehr_mobile.model.SelfIdentifiedGender;
import zw.gov.mohcc.mrs.ehr_mobile.persistance.database.EhrMobileDatabase;


public class PatientsApolloClient {

    // GraphQL endpoint

   private static final String endpoint = "/api/graphql";

    private static Patient patient;

    public static ApolloClient getApolloClient(String baseUrl) {
        System.out.println("baseUrl = " + baseUrl);
        String url=baseUrl.concat(endpoint);

        OkHttpClient okHttpClient = new OkHttpClient.Builder()
                .build();

        return ApolloClient.builder()
                .serverUrl(url)
                .okHttpClient(okHttpClient).build();
    }




    public static void getPatientsFromEhr(final EhrMobileDatabase ehrMobileDatabase, String baseUrl) {
        System.out.println("baseUrl = " + baseUrl);
        PatientsApolloClient.getApolloClient(baseUrl).query(


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


                                    System.out.println("=============-=-=-=-=============1=1=1=1=1=1=1=1=patientData"+patientData.birthdate());
                                    Gender sex = Gender.valueOf(patientData.sex().rawValue());
                                    SelfIdentifiedGender selfIdentifiedGender = SelfIdentifiedGender.valueOf(patientData.selfIdentifiedGender().rawValue());
                                    Address address = new Address(patientData.address().street(), patientData.address().city(), patientData.address().town().name());

                                    int numberOfIdentifications = patientData.identifications().size();
                                    String firstName = patientData.firstname();
                                    String lastName = patientData.lastname();


                                    patient = new Patient(firstName, lastName, sex);
                                    patient.setSelfIdentifiedGender(selfIdentifiedGender);
                                    patient.setReligionId(patientData.religion() != null  && StringUtils.isNoneBlank(patientData.religion().id())
                                            ? patientData.religion().id() : null);
                                    patient.setCountryId(patientData.countryOfBirth() != null && StringUtils.isNoneBlank(patientData.countryOfBirth().id())
                                            ? patientData.countryOfBirth().id() : null);
                                    patient.setEducationLevelId(patientData.education() != null && StringUtils.isNoneBlank(patientData.education().id())
                                            ? patientData.education().id() : null);
                                    patient.setAddress(address);
                                    patient.setMaritalStatusId(patientData.marital() != null && StringUtils.isNoneBlank(patientData.marital().id())
                                            ? patientData.marital().id() : null);
                                    patient.setNationalityId(patientData.nationality() != null && StringUtils.isNoneBlank(patientData.nationality().id())
                                            ? patientData.nationality().id() : null);
                                    patient.setNationalityId(null);
                                    patient.setOccupationId(patientData.occupation() != null && StringUtils.isNoneBlank(patientData.occupation().id())
                                            ? patientData.occupation().id() : null);

                                    try {

                                        Date dateOfBirth = new SimpleDateFormat("yyyy-MM-dd", Locale.ENGLISH).parse(patientData.birthdate());
                                        patient.setBirthDate(dateOfBirth);


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
                                    System.out.println("*********** PATIENT ***********       "+ patient);
                                    System.out.println("Number of Patients  = " + ehrMobileDatabase.patientDao().listPatients().size());
                                }
                            } catch (Exception e) {
                                e.printStackTrace()
                                ;

                                System.out.println("e = " + e.getLocalizedMessage());
                            }


                        System.out.println("Number of Patients  = ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ " + ehrMobileDatabase.patientDao().listPatients().size());

                        System.out.println("\"Patient Table\" -------------------------------------------- " + ehrMobileDatabase.patientDao().listPatients());


                    }

                    @Override
                    public void onFailure(@NotNull ApolloException e) {
                        System.out.println("Error =========" + e.toString());
                    }
                }
        );
    }


}