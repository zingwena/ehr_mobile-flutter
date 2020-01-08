package zw.gov.mohcc.mrs.ehr_mobile.configuration.apolloClient;

import android.os.Build;
import android.util.Log;

import androidx.annotation.RequiresApi;

import com.apollographql.apollo.ApolloCall;
import com.apollographql.apollo.ApolloClient;
import com.apollographql.apollo.api.Response;
import com.apollographql.apollo.exception.ApolloException;

import org.apache.commons.lang3.StringUtils;
import org.jetbrains.annotations.NotNull;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Locale;

import okhttp3.OkHttpClient;
import zw.gov.mohcc.mrs.ehr_mobile.GetPatientsQuery;
import zw.gov.mohcc.mrs.ehr_mobile.QueueQuery;
import zw.gov.mohcc.mrs.ehr_mobile.SiteQuery;
import zw.gov.mohcc.mrs.ehr_mobile.WardQuery;
import zw.gov.mohcc.mrs.ehr_mobile.dto.Batch;
import zw.gov.mohcc.mrs.ehr_mobile.dto.BinTypeIdName;
import zw.gov.mohcc.mrs.ehr_mobile.enumeration.BinType;
import zw.gov.mohcc.mrs.ehr_mobile.enumeration.Gender;
import zw.gov.mohcc.mrs.ehr_mobile.model.FacilityWard;
import zw.gov.mohcc.mrs.ehr_mobile.model.person.Address;
import zw.gov.mohcc.mrs.ehr_mobile.model.person.Person;
import zw.gov.mohcc.mrs.ehr_mobile.model.terminology.NameCode;
import zw.gov.mohcc.mrs.ehr_mobile.model.terminology.SiteSetting;
import zw.gov.mohcc.mrs.ehr_mobile.model.vitals.FacilityQueue;
import zw.gov.mohcc.mrs.ehr_mobile.model.warehouse.TestKitBatchIssue;
import zw.gov.mohcc.mrs.ehr_mobile.persistance.database.EhrMobileDatabase;
import zw.gov.mohcc.mrs.ehr_mobile.service.SiteService;
import zw.gov.mohcc.mrs.sync.adapter.enums.RecordStatus;


public class PatientsApolloClient {

    // GraphQL GRAPHQL_RESOURCE

    private static final String GRAPHQL_RESOURCE = "/api/graphql";
    //private


    public static ApolloClient getApolloClient(String baseUrl) {
        System.out.println("baseUrl = " + baseUrl);
        String url = baseUrl.concat(GRAPHQL_RESOURCE);

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
                                System.out.println("=============-=-=-=-=============1=1=1=1=1=1=1=1=patientData" + patientData.birthdate());
                                Gender sex = patientData.sex() != null ? Gender.valueOf(patientData.sex().rawValue()) : null;
                                Gender selfIdentifiedGender = patientData.selfIdentifiedGender() != null ?
                                        Gender.valueOf(patientData.selfIdentifiedGender().rawValue()) : null;

                                int numberOfIdentifications = patientData.identifications().size();
                                String firstName = patientData.firstname();
                                String lastName = patientData.lastname();
                                Person person = new Person(firstName, lastName, sex);
                                person.setId(patientData.personId());
                                person.setStatus(RecordStatus.IMPORTED);
                                if (patientData.address() != null) {
                                    Address address = new Address(patientData.address().street(), patientData.address().city(), patientData.address().town().name());
                                    person.setAddress(address);
                                }
                                person.setSelfIdentifiedGender(selfIdentifiedGender);
                                person.setReligionId(patientData.religion() != null && StringUtils.isNoneBlank(patientData.religion().id())
                                        ? patientData.religion().id() : null);
                                person.setCountryId(patientData.countryOfBirth() != null && StringUtils.isNoneBlank(patientData.countryOfBirth().id())
                                        ? patientData.countryOfBirth().id() : null);
                                person.setEducationLevelId(patientData.education() != null && StringUtils.isNoneBlank(patientData.education().id())
                                        ? patientData.education().id() : null);
                                person.setMaritalStatusId(patientData.marital() != null && StringUtils.isNoneBlank(patientData.marital().id())
                                        ? patientData.marital().id() : null);
                                person.setNationalityId(patientData.nationality() != null && StringUtils.isNoneBlank(patientData.nationality().id())
                                        ? patientData.nationality().id() : null);
                                //person.setNationalityId(null);
                                person.setOccupationId(patientData.occupation() != null && StringUtils.isNoneBlank(patientData.occupation().id())
                                        ? patientData.occupation().id() : null);
                                person.setBirthDate(getDateFromString(patientData.birthdate()));


                                if (numberOfIdentifications > 0) {
                                    String identifierType = patientData.identifications().get(0).type().name();

                                    if (identifierType.equals("National Id")) {
                                        String nationalId = patientData.identifications().get(0).number();

                                        person.setNationalId(nationalId);
                                    } else {
                                        person.setNationalId(null);

                                    }

                                }
                                ehrMobileDatabase.personDao().createPatient(person);
                                System.out.println("*********** PATIENT ***********       " + person);
                                System.out.println("Number of Patients  = " + ehrMobileDatabase.personDao().listPatients().size());
                            } catch (Exception e) {
                                e.printStackTrace()
                                ;

                                System.out.println("e = " + e.getLocalizedMessage());
                            }


                        System.out.println("Number of Patients  = ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ " + ehrMobileDatabase.personDao().listPatients().size());

                        System.out.println("\"Person Table\" -------------------------------------------- " + ehrMobileDatabase.personDao().listPatients());


                    }

                    @Override
                    public void onFailure(@NotNull ApolloException e) {
                        System.out.println("Error =========" + e.toString());
                    }
                }
        );
    }

    private static Date getDateFromString(String date) {
        try {
            Date dateOfBirth = new SimpleDateFormat("yyyy-MM-dd", Locale.ENGLISH).parse(date);
        } catch (Exception e) {
            Log.d("Apollo Client", "Error occurred converting string to date :" + e.getMessage());
        }
        return null;
    }

    public static void getFacilityQueuesFromEhr(final EhrMobileDatabase ehrMobileDatabase, String baseUrl) {
        System.out.println("baseUrl = " + baseUrl);
        SiteService siteService = new SiteService(ehrMobileDatabase);
        PatientsApolloClient.getApolloClient(baseUrl).query(


                QueueQuery.builder()
                        .build()).enqueue(
                new ApolloCall.Callback<QueueQuery.Data>() {
                    @RequiresApi(api = Build.VERSION_CODES.O)
                    @Override
                    public void onResponse(@NotNull Response<QueueQuery.Data> response) throws IndexOutOfBoundsException {
                        List<QueueQuery.Content> queues = response.data().queues().content();
                        for (QueueQuery.Content queueData : queues)
                            try {

                                FacilityQueue facilityQueue = new FacilityQueue(
                                        queueData.queueId(),
                                        new NameCode(queueData.queue().id(), queueData.queue().name()),
                                        null, 0,
                                        new NameCode(queueData.department().id(), queueData.department().name())

                                );
                                List<TestKitBatchIssue> batchIssues = new ArrayList<>();
                                if (queueData.currentTestKits() != null || (queueData.currentTestKits().content() != null
                                        || !queueData.currentTestKits().content().isEmpty())) {

                                    List<QueueQuery.Content1> batches = queueData.currentTestKits().content();
                                    Log.d("QUEUE QUERY", "Queue Data here " + batches);
                                    Log.d("QUEUE QUERY", "Facility details here " + facilityQueue);
                                    int count = 0;
                                    for (QueueQuery.Content1 batch : batches) {
                                        if (batch.binType().equalsIgnoreCase("WARD")) {
                                            continue;
                                        }
                                        TestKitBatchIssue testKitBatchIssue = new TestKitBatchIssue();
                                        testKitBatchIssue.setBatch(
                                                new Batch(batch.batch().batchNumber(), getDateFromString(batch.batch().expiryDate()),
                                                        batch.batch().testKit().id(), batch.batch().testKit().name()));
                                        testKitBatchIssue.setDate(getDateFromString(batch.date()));
                                        testKitBatchIssue.setDetail(new BinTypeIdName(BinType.QUEUE,
                                                facilityQueue.getQueue().getName(), facilityQueue.getQueue().getCode()));
                                        testKitBatchIssue.setExpiredStatus(batch.expiredStatus());
                                        testKitBatchIssue.setQuantity(batch.quantity());
                                        testKitBatchIssue.setRemaining(batch.remaining());
                                        testKitBatchIssue.setStatusAccepted(batch.statusAccepted());
                                        testKitBatchIssue.setId(batch.batchIssueId());
                                        batchIssues.add(testKitBatchIssue);
                                    }
                                }

                                siteService.saveFacilityQueue(facilityQueue, batchIssues);


                            } catch (Exception e) {
                                e.printStackTrace();

                                System.out.println("e = " + e.getLocalizedMessage());
                            }
                    }

                    @Override
                    public void onFailure(@NotNull ApolloException e) {
                        System.out.println("Error =========" + e.toString());
                    }
                }
        );
    }

    public static void getFacilityWardsFromEhr(final EhrMobileDatabase ehrMobileDatabase, String baseUrl) {
        System.out.println("baseUrl = " + baseUrl);
        SiteService siteService = new SiteService(ehrMobileDatabase);
        PatientsApolloClient.getApolloClient(baseUrl).query(


                WardQuery.builder()
                        .build()).enqueue(
                new ApolloCall.Callback<WardQuery.Data>() {
                    @RequiresApi(api = Build.VERSION_CODES.O)
                    @Override
                    public void onResponse(@NotNull Response<WardQuery.Data> response) throws IndexOutOfBoundsException {
                        List<WardQuery.Content> queues = response.data().wards().content();
                        for (WardQuery.Content wardData : queues)
                            try {

                                FacilityWard facilityWard = new FacilityWard(
                                        wardData.wardId(),
                                        new NameCode(wardData.ward().id(), wardData.ward().name()),
                                        null, 0,
                                        new NameCode(wardData.department().id(), wardData.department().name())

                                );

                                /*List<TestKitBatchIssue> batchIssues = new ArrayList<>();
                                if (wardData.currentTestKits() != null || (wardData.currentTestKits().content() != null
                                        || !wardData.currentTestKits().content().isEmpty())) {

                                    List<WardQuery.Content1> batches = wardData.currentTestKits().content();
                                    Log.d("JUDGE", "The message here " + batches);
                                    for (WardQuery.Content1 batch : batches) {
                                        if (batch.binType().equalsIgnoreCase("QUEUE")) {
                                            continue;
                                        }
                                        TestKitBatchIssue testKitBatchIssue = new TestKitBatchIssue();
                                        testKitBatchIssue.setBatch(new Batch(batch.batch().batchNumber(), getDateFromString(batch.batch().expiryDate())));
                                        testKitBatchIssue.setBinType(batch.binType());
                                        testKitBatchIssue.setDate(getDateFromString(batch.date()));
                                        testKitBatchIssue.setDetail(new BinTypeIdName(BinType.WARD,
                                                facilityWard.getFacility().getName(), facilityWard.getFacility().getCode()));
                                        testKitBatchIssue.setExpiredStatus(batch.expiredStatus());
                                        testKitBatchIssue.setQuantity(batch.quantity());
                                        testKitBatchIssue.setRemaining(batch.remaining());
                                        testKitBatchIssue.setStatusAccepted(batch.statusAccepted());
                                        testKitBatchIssue.setId(batch.batchIssueId());
                                        batchIssues.add(testKitBatchIssue);
                                    }
                                }*/

                                siteService.saveFacilityWard(facilityWard, null);


                            } catch (Exception e) {
                                e.printStackTrace();

                                System.out.println("e = " + e.getLocalizedMessage());
                            }
                    }

                    @Override
                    public void onFailure(@NotNull ApolloException e) {
                        System.out.println("Error =========" + e.toString());
                    }
                }
        );
    }

    public static void getSiteDetail(final EhrMobileDatabase ehrMobileDatabase, String baseUrl) {
        System.out.println("baseUrl = " + baseUrl);
        PatientsApolloClient.getApolloClient(baseUrl).query(


                SiteQuery.builder()
                        .build()).enqueue(
                new ApolloCall.Callback<SiteQuery.Data>() {
                    @RequiresApi(api = Build.VERSION_CODES.O)
                    @Override
                    public void onResponse(@NotNull Response<SiteQuery.Data> response) throws IndexOutOfBoundsException {
                        SiteQuery.Data site = response.data();
                        try {

                            SiteSetting siteSetting = new SiteSetting(site.site().siteId(), site.site().name());
                            ehrMobileDatabase.siteSettingDao().saveOne(siteSetting);


                        } catch (Exception e) {
                            e.printStackTrace();

                            System.out.println("e = " + e.getLocalizedMessage());
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