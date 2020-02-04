package zw.gov.mohcc.mrs.ehr_mobile;

import android.os.Bundle;
import android.util.Log;

import androidx.room.Transaction;

import com.facebook.stetho.Stetho;
import com.facebook.stetho.okhttp3.StethoInterceptor;
import com.google.gson.Gson;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashSet;
import java.util.List;
import java.util.Set;
import java.util.UUID;

import io.flutter.app.FlutterActivity;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugins.GeneratedPluginRegistrant;
import okhttp3.OkHttpClient;
import retrofit2.Call;
import retrofit2.Callback;
import retrofit2.Response;
import zw.gov.mohcc.mrs.ehr_mobile.channels.AddPatientChannel;
import zw.gov.mohcc.mrs.ehr_mobile.channels.ArtChannel;
import zw.gov.mohcc.mrs.ehr_mobile.channels.DataChannel;
import zw.gov.mohcc.mrs.ehr_mobile.channels.HtsChannel;
import zw.gov.mohcc.mrs.ehr_mobile.channels.PatientChannel;
import zw.gov.mohcc.mrs.ehr_mobile.channels.SiteChannel;
import zw.gov.mohcc.mrs.ehr_mobile.channels.VisitChannel;
import zw.gov.mohcc.mrs.ehr_mobile.configuration.RetrofitClient;
import zw.gov.mohcc.mrs.ehr_mobile.configuration.apolloClient.PatientsApolloClient;
import zw.gov.mohcc.mrs.ehr_mobile.converter.LoginValidator;
import zw.gov.mohcc.mrs.ehr_mobile.dto.Page;
import zw.gov.mohcc.mrs.ehr_mobile.enumeration.QuestionType;
import zw.gov.mohcc.mrs.ehr_mobile.enumeration.RecordStatus;
import zw.gov.mohcc.mrs.ehr_mobile.enumeration.TestLevel;
import zw.gov.mohcc.mrs.ehr_mobile.enumeration.WorkArea;
import zw.gov.mohcc.mrs.ehr_mobile.model.Authorities;
import zw.gov.mohcc.mrs.ehr_mobile.model.BaseNameModel;
import zw.gov.mohcc.mrs.ehr_mobile.model.Token;
import zw.gov.mohcc.mrs.ehr_mobile.model.User;
import zw.gov.mohcc.mrs.ehr_mobile.model.laboratory.LaboratoryInvestigation;
import zw.gov.mohcc.mrs.ehr_mobile.model.terminology.ArtReasonModel;
import zw.gov.mohcc.mrs.ehr_mobile.model.terminology.ArtStatus;
import zw.gov.mohcc.mrs.ehr_mobile.model.terminology.ArvCombinationRegimenEhr;
import zw.gov.mohcc.mrs.ehr_mobile.model.terminology.ArvCombinationRegimenModel;
import zw.gov.mohcc.mrs.ehr_mobile.model.terminology.Country;
import zw.gov.mohcc.mrs.ehr_mobile.model.terminology.Diagnosis;
import zw.gov.mohcc.mrs.ehr_mobile.model.terminology.DisclosureMethod;
import zw.gov.mohcc.mrs.ehr_mobile.model.terminology.EducationLevel;
import zw.gov.mohcc.mrs.ehr_mobile.model.terminology.EntryPoint;
import zw.gov.mohcc.mrs.ehr_mobile.model.terminology.Facility;
import zw.gov.mohcc.mrs.ehr_mobile.model.terminology.HtsModel;
import zw.gov.mohcc.mrs.ehr_mobile.model.terminology.Investigation;
import zw.gov.mohcc.mrs.ehr_mobile.model.terminology.InvestigationEhr;
import zw.gov.mohcc.mrs.ehr_mobile.model.terminology.InvestigationModel;
import zw.gov.mohcc.mrs.ehr_mobile.model.terminology.InvestigationResultModel;
import zw.gov.mohcc.mrs.ehr_mobile.model.terminology.InvestigationTestkit;
import zw.gov.mohcc.mrs.ehr_mobile.model.terminology.InvestigationTestkitEhr;
import zw.gov.mohcc.mrs.ehr_mobile.model.terminology.InvestigationTestkitModel;
import zw.gov.mohcc.mrs.ehr_mobile.model.terminology.LaboratoryTest;
import zw.gov.mohcc.mrs.ehr_mobile.model.terminology.MaritalStatus;
import zw.gov.mohcc.mrs.ehr_mobile.model.terminology.NameIdModel;
import zw.gov.mohcc.mrs.ehr_mobile.model.terminology.NameIdSynchModel;
import zw.gov.mohcc.mrs.ehr_mobile.model.terminology.Nationality;
import zw.gov.mohcc.mrs.ehr_mobile.model.terminology.Occupation;
import zw.gov.mohcc.mrs.ehr_mobile.model.terminology.PurposeOfTest;
import zw.gov.mohcc.mrs.ehr_mobile.model.terminology.Question;
import zw.gov.mohcc.mrs.ehr_mobile.model.terminology.QuestionCategory;
import zw.gov.mohcc.mrs.ehr_mobile.model.terminology.QuestionCategoryEhr;
import zw.gov.mohcc.mrs.ehr_mobile.model.terminology.QuestionCategoryModel;
import zw.gov.mohcc.mrs.ehr_mobile.model.terminology.QuestionEhr;
import zw.gov.mohcc.mrs.ehr_mobile.model.terminology.QuestionModel;
import zw.gov.mohcc.mrs.ehr_mobile.model.terminology.ReasonForNotIssuingResult;
import zw.gov.mohcc.mrs.ehr_mobile.model.terminology.Religion;
import zw.gov.mohcc.mrs.ehr_mobile.model.terminology.Result;
import zw.gov.mohcc.mrs.ehr_mobile.model.terminology.Sample;
import zw.gov.mohcc.mrs.ehr_mobile.model.terminology.TerminologyModel;
import zw.gov.mohcc.mrs.ehr_mobile.model.terminology.TestKit;
import zw.gov.mohcc.mrs.ehr_mobile.model.terminology.TestKitModel;
import zw.gov.mohcc.mrs.ehr_mobile.model.terminology.TestKitTestLevel;
import zw.gov.mohcc.mrs.ehr_mobile.model.terminology.TestingPlan;
import zw.gov.mohcc.mrs.ehr_mobile.model.terminology.Town;
import zw.gov.mohcc.mrs.ehr_mobile.model.vitals.BloodPressure;
import zw.gov.mohcc.mrs.ehr_mobile.model.vitals.Height;
import zw.gov.mohcc.mrs.ehr_mobile.model.vitals.Pulse;
import zw.gov.mohcc.mrs.ehr_mobile.model.vitals.RespiratoryRate;
import zw.gov.mohcc.mrs.ehr_mobile.model.vitals.Temperature;
import zw.gov.mohcc.mrs.ehr_mobile.model.vitals.Weight;
import zw.gov.mohcc.mrs.ehr_mobile.persistance.database.EhrMobileDatabase;
import zw.gov.mohcc.mrs.ehr_mobile.service.AppWideService;
import zw.gov.mohcc.mrs.ehr_mobile.service.ArtService;
import zw.gov.mohcc.mrs.ehr_mobile.service.DataSyncService;
import zw.gov.mohcc.mrs.ehr_mobile.service.HistoryService;
import zw.gov.mohcc.mrs.ehr_mobile.service.HtsService;
import zw.gov.mohcc.mrs.ehr_mobile.service.IndexTestingService;
import zw.gov.mohcc.mrs.ehr_mobile.service.PersonService;
import zw.gov.mohcc.mrs.ehr_mobile.service.RelationshipService;
import zw.gov.mohcc.mrs.ehr_mobile.service.SiteService;
import zw.gov.mohcc.mrs.ehr_mobile.service.TerminologyService;
import zw.gov.mohcc.mrs.ehr_mobile.service.VisitService;

public class MainActivity extends FlutterActivity {

    final static String CHANNEL = "Authentication";
    final static String DATACHANNEL = "zw.gov.mohcc.mrs.ehr_mobile/dataChannel";
    final static String VISITCHANNEL = "zw.gov.mohcc.mrs.ehr_mobile/visitChannel";
    final static String SITECHANNEL = "zw.gov.mohcc.mrs.ehr_mobile/siteChannel";
    final static String HTSCHANNEL = "zw.gov.mohcc.mrs.ehr_mobile/htsChannel";
    final static String ADD_PATIENT_CHANNEL = "zw.gov.mohcc.mrs.ehr_mobile/addPatient";
    final static String DATA_SYNC_CHANNEL = "zw.gov.mohcc.mrs.ehr_mobile/dataSyncChannel";
    private final static String PATIENT_CHANNEL = "ehr_mobile.channel/patient";
    private final static String VITALS_CHANNEL = "ehr_mobile.channel/vitals";
    private final static String ART_CHANNEL = "zw.gov.mohcc.mrs.ehr_mobile.channel/art";

    private final static String TAG = "Main Activity";
    public Token token;
    public String url, username, password;
    private EhrMobileDatabase ehrMobileDatabase;
    private AppWideService appWideService;
    private VisitService visitService;
    private HtsService htsService;
    private TerminologyService terminologyService;
    private HistoryService historyService;
    private IndexTestingService indexTestingService;
    private RelationshipService relationshipService;
    private SiteService siteService;
    private ArtService artService;
    private PersonService personService;

    /**
     *
     * @param savedInstanceState
     * highly preferable to have all services as singletons, this will be implemented
     */
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        System.out.println("testing");
        GeneratedPluginRegistrant.registerWith(this);

        getApplicationContext();
        ehrMobileDatabase = EhrMobileDatabase.getDatabaseInstance(getApplication());

        siteService = new SiteService(ehrMobileDatabase);
        appWideService = new AppWideService(ehrMobileDatabase);
        artService = new ArtService(ehrMobileDatabase, appWideService);
        visitService = new VisitService(ehrMobileDatabase, siteService, artService, appWideService);
        htsService = new HtsService(ehrMobileDatabase, appWideService);
        historyService = new HistoryService(ehrMobileDatabase, htsService);
        terminologyService = new TerminologyService(ehrMobileDatabase);
        indexTestingService = new IndexTestingService(ehrMobileDatabase);
        relationshipService = new RelationshipService(ehrMobileDatabase);
        personService = new PersonService(ehrMobileDatabase);

        Stetho.initializeWithDefaults(this);
        new OkHttpClient.Builder()
                .addNetworkInterceptor(new StethoInterceptor())
                .build();

        new AddPatientChannel(getFlutterView(), ADD_PATIENT_CHANNEL, ehrMobileDatabase);

        new MethodChannel(getFlutterView(), CHANNEL).setMethodCallHandler(new MethodChannel.MethodCallHandler() {
            @Override
            public void onMethodCall(final MethodCall methodCall, final MethodChannel.Result result) {
                if (methodCall.method.equals("DataSync")) {

                    ArrayList args = methodCall.arguments();

                    url = args.get(0).toString();
                    String tokenString = args.get(1).toString();
                    Token token = new Token(tokenString);
                    clearTables();
                    //pullData(token, url);
                    result.success("SUCCESS");
                }

                if (methodCall.method.equals("login")) {

                    ArrayList args = methodCall.arguments();
                    username = args.get(0).toString();
                    password = args.get(1).toString();
                    System.out.println("username = " + username);
                    System.out.println("password = " + password);

                    Boolean userIsValid = LoginValidator.isUserValid(ehrMobileDatabase, username, password);
                    if (userIsValid) {

                        result.success("Welcome  " + username);


                    } else {
                        result.success("Username or password are invalid.");
                    }
                }
            }
        });

        new DataChannel(getFlutterView(), DATACHANNEL, ehrMobileDatabase, personService);

        new VisitChannel(getFlutterView(), VISITCHANNEL, appWideService, visitService);

        new SiteChannel(getFlutterView(), SITECHANNEL, ehrMobileDatabase, siteService);
        new PatientChannel(getFlutterView(), PATIENT_CHANNEL, ehrMobileDatabase, relationshipService);

        new MethodChannel(getFlutterView(), VITALS_CHANNEL).setMethodCallHandler(new MethodChannel.MethodCallHandler() {
            @Override
            public void onMethodCall(MethodCall methodCall, MethodChannel.Result result) {

                final String arguments = methodCall.arguments();

                Gson gson = new Gson();
                if (methodCall.method.equals("bloodPressure")) {
                    BloodPressure bloodPressure = gson.fromJson(arguments, BloodPressure.class);
                    bloodPressure.setId(UUID.randomUUID().toString());
                    String visitId = appWideService.getCurrentVisit(bloodPressure.getPersonId());
                    bloodPressure.setVisitId(visitId);
                    bloodPressure.setStatus(RecordStatus.NEW);
                    ehrMobileDatabase.bloodPressureDao().insert(bloodPressure);
                    BloodPressure bp = ehrMobileDatabase.bloodPressureDao().findByVisitId(visitId);

                } else if (methodCall.method.equals("temperature")) {

                    Temperature temperature = gson.fromJson(arguments, Temperature.class);
                    Log.i(TAG, "person ID from flutter : " + temperature.getPersonId());
                    Log.i(TAG, "Temparture : " + temperature);
                    temperature.setId(UUID.randomUUID().toString());
                    String visitId = appWideService.getCurrentVisit(temperature.getPersonId());
                    temperature.setVisitId(visitId);
                    temperature.setStatus(RecordStatus.NEW);
                    ehrMobileDatabase.temperatureDao().insert(temperature);
                    System.out.println("temp == " + ehrMobileDatabase.temperatureDao().getAll());


                } else if (methodCall.method.equals("respiratoryRate")) {

                    RespiratoryRate respiratoryRate = gson.fromJson(arguments, RespiratoryRate.class);
                    Log.i(TAG, "person ID from flutter : " + respiratoryRate.getPersonId());
                    Log.i(TAG, "RespiratoryRate : " + respiratoryRate);
                    respiratoryRate.setId(UUID.randomUUID().toString());
                    String visitId = appWideService.getCurrentVisit(respiratoryRate.getPersonId());
                    respiratoryRate.setVisitId(visitId);
                    respiratoryRate.setStatus(RecordStatus.NEW);
                    ehrMobileDatabase.respiratoryRateDao().insert(respiratoryRate);
                    System.out.println("respirat == " + ehrMobileDatabase.respiratoryRateDao().getAll());


                } else if (methodCall.method.equals("height")) {

                    Height height = gson.fromJson(arguments, Height.class);
                    height.setId(UUID.randomUUID().toString());
                    String visitId = appWideService.getCurrentVisit(height.getPersonId());
                    height.setVisitId(visitId);
                    height.setStatus(RecordStatus.NEW);
                    ehrMobileDatabase.heightDao().insert(height);
                    System.out.println("height == " + ehrMobileDatabase.heightDao().getAll());


                } else if (methodCall.method.equals("weight")) {

                    Weight weight = gson.fromJson(arguments, Weight.class);
                    weight.setId(UUID.randomUUID().toString());
                    String visitId = appWideService.getCurrentVisit(weight.getPersonId());
                    weight.setVisitId(visitId);
                    weight.setStatus(RecordStatus.NEW);
                    ehrMobileDatabase.weightDao().insert(weight);


                } else if (methodCall.method.equals("pulse")) {

                    Pulse pulse = gson.fromJson(arguments, Pulse.class);
                    pulse.setId(UUID.randomUUID().toString());
                    String visitId = appWideService.getCurrentVisit(pulse.getPersonId());
                    pulse.setVisitId(visitId);
                    pulse.setStatus(RecordStatus.NEW);
                    ehrMobileDatabase.pulseDao().insert(pulse);
                    System.out.println("pulse == " + ehrMobileDatabase.pulseDao().getAll());

                } else if (methodCall.method.equals("visit")) {
                    String visitId = appWideService.getCurrentVisit(arguments);
                    result.success(visitId);
                } else {
                    result.notImplemented();
                }
            }

        });

        new HtsChannel(getFlutterView(), HTSCHANNEL, ehrMobileDatabase, htsService, MainActivity.this.getLabInvestigation(), historyService, indexTestingService, appWideService, artService);

        new ArtChannel(getFlutterView(), ART_CHANNEL, ehrMobileDatabase, artService);

        Stetho.initializeWithDefaults(this);
        new OkHttpClient.Builder()
                .addNetworkInterceptor(new StethoInterceptor())
                .build();
    }

    private void pullData(Token token, String url) {

        getSample(token, url + "/api/");
        getDiagnosis(token, url + "/api/");
        getQuestionCategories(token, url + "/api/");
        getQuestions(token, url + "/api/");
        getLaboratoryTest(token, url + "/api/");
        getNationalities(token, url + "/api/");
        getFacilities(token, url + "/api/");
        getCountries(token, url + "/api/");
        getOccupation(token, url + "/api/");
        getInvestigations(token, url + "/api/");
        getMaritalStates(token, url + "/api/");
        getEducationLevels(token, url + "/api/");
        getLaboratoryResults(token, url + "/api/");
        getReligion(token, url + "/api/");
        getEntryPoints(token, url + "/api/");
        getHtsModels(token, url + "/api/");
        getPurpose_Of_Tests(token, url + "/api/");
        getReasonForNotIssuingResults(token, url + "/api/");
        getUsers(token, url + "/api/");
        getTestKits(token, url + "/api/");
        getTowns(token, url + "/api/");
        getInvestigationTestKits(token, url + "/api/");
        getInvestigationResults(token, url + "/api/");
        getArtStatus(token, url + "/api/");
        getArtReasons(token, url + "/api/");
        getArvCombinationRegimens(token, url + "/api/");
        getDisclosureMethods(token, url + "/api/");
        getTestingPlan(token, url + "/api/");
        getFacilityQueues(url);
        getFacilityWards(url);
        getSiteDetails(url);
        getPatients(url);
    }

    private void getPatients(String baseUrl) {
        ehrMobileDatabase.personDao().deleteAll();
        PatientsApolloClient.getPatientsFromEhr(ehrMobileDatabase, baseUrl);
    }

    private void getSiteDetails(String baseUrl) {
        ehrMobileDatabase.siteSettingDao().deleteAll();
        PatientsApolloClient.getSiteDetail(ehrMobileDatabase, baseUrl);
    }

    private void getFacilityQueues(String baseUrl) {
        ehrMobileDatabase.facilityQueueDao().deleteAll();
        ehrMobileDatabase.testKitBatchIssueDao().deleteAll();
        PatientsApolloClient.getFacilityQueuesFromEhr(ehrMobileDatabase, baseUrl);
    }

    private void getFacilityWards(String baseUrl) {
        ehrMobileDatabase.facilityWardDao().deleteAll();
        ehrMobileDatabase.testKitBatchIssueDao().deleteAll();
        PatientsApolloClient.getFacilityWardsFromEhr(ehrMobileDatabase, baseUrl);
    }

    public void getMaritalStates(Token token, String baseUrl) {

        DataSyncService service = RetrofitClient.getRetrofitInstance(baseUrl).create(DataSyncService.class);
        Call<TerminologyModel> call = service.getMaritalStates("Bearer " + token.getId_token(), new Page().size);
        call.enqueue(new Callback<TerminologyModel>() {
            @Override
            public void onResponse(Call<TerminologyModel> call, Response<TerminologyModel> response) {
                List<MaritalStatus> maritalStatusList = new ArrayList<MaritalStatus>();
                if (response.isSuccessful()) {
                    for (BaseNameModel item : response.body().getContent()) {
                        maritalStatusList.add(new MaritalStatus(item.getCode(), item.getName()));
                    }
                    if (maritalStatusList != null && !maritalStatusList.isEmpty()) {
                        terminologyService.saveMaritalStatesToDB(maritalStatusList);
                    }
                }
            }

            @Override
            public void onFailure(Call<TerminologyModel> call, Throwable t) {

            }
        });
    }

    public void getOccupation(Token token, String baseUrl) {

        DataSyncService service = RetrofitClient.getRetrofitInstance(baseUrl).create(DataSyncService.class);
        Call<TerminologyModel> call = service.getOccupation("Bearer " + token.getId_token(), new Page().size);
        call.enqueue(new Callback<TerminologyModel>() {
            @Override
            public void onResponse(Call<TerminologyModel> call, Response<TerminologyModel> response) {
                List<Occupation> occupationList = new ArrayList<Occupation>();
                for (BaseNameModel item : response.body().getContent()) {
                    occupationList.add(new Occupation(item.getCode(), item.getName()));
                }
                if (!occupationList.isEmpty()) {

                    terminologyService.saveOccupationsToDB(occupationList);
                }


            }

            @Override
            public void onFailure(Call<TerminologyModel> call, Throwable t) {

                System.out.println("tttttttttttttttttttttttt" + t);

            }
        });
    }


    public void getUsers(Token token, String baseUrl) {
        DataSyncService service = RetrofitClient.getRetrofitInstance(baseUrl).create(DataSyncService.class);
        Call<List<User>> call = service.getAllUsers("Bearer " + token.getId_token(), new Page().size);

        call.enqueue(new Callback<List<User>>() {
            @Override
            public void onResponse(Call<List<User>> call, Response<List<User>> response) {
                List<User> userList = response.body();
                System.out.println("User response   : \n   " + userList);
                saveUsersToDB(userList);
            }

            @Override
            public void onFailure(Call<List<User>> call, Throwable t) {
                System.out.println("Failed to get Patients \n-------------------" + t.getMessage());
            }
        });
    }

    //liberty
    public void getFacilities(Token token, String baseUrl) {


        DataSyncService service = RetrofitClient.getRetrofitInstance(baseUrl).create(DataSyncService.class);

        Call<TerminologyModel> call = service.getFacilities("Bearer " + token.getId_token(), new Page().size);
        call.enqueue(new Callback<TerminologyModel>() {
            @Override
            public void onResponse(Call<TerminologyModel> call, Response<TerminologyModel> response) {
                List<Facility> facilityList = new ArrayList<Facility>();
                for (BaseNameModel item : response.body().getContent()) {
                    facilityList.add(new Facility(item.getCode(), item.getName()));
                }
                if (facilityList != null && !facilityList.isEmpty()) {

                    terminologyService.saveFacilityToDB(facilityList);
                }
            }

            @Override
            public void onFailure(Call<TerminologyModel> call, Throwable t) {

                System.out.println("facility tttttttttttttttttttttttt" + t);

            }
        });

    }

    public LaboratoryInvestigation getLabInvestigation() {

        Date now = new Date();
        LaboratoryInvestigation laboratoryInvestigation = new LaboratoryInvestigation();

        return laboratoryInvestigation;

    }

    @Transaction
    public void getTestKits(Token token, String url) {
        final DataSyncService service = RetrofitClient.getRetrofitInstance(url).create(DataSyncService.class);
        Call<TestKitModel> call = service.getAllTestKits("Bearer " + token.getId_token(), new Page().size);
        call.enqueue(new Callback<TestKitModel>() {
            @Override
            public void onResponse(Call<TestKitModel> call, Response<TestKitModel> response) {
                List<TestKit> testKits = new ArrayList<>();

                if (response.isSuccessful()) {
                    for (TestKit item : response.body().getContent()) {
                        testKits.add(new TestKit(item.getCode(), item.getName(), item.getDescription()));
                    }
                    int count = saveTestKitsToDB(testKits);
                    Log.i(TAG, "Saved testkits : " + ehrMobileDatabase.testKitDao().findAll());

                    for (TestLevel testLevel : TestLevel.getEhrTestLevels()) {
                        Log.d(TAG, "Entering loop at this point : " + testLevel);
                        Call<List<TestKit>> innerCall = service.getTestKitLevels("Bearer " + token.getId_token(), testLevel);
                        Log.d(TAG, "After call to EHR for test levels");
                        innerCall.enqueue(new Callback<List<TestKit>>() {
                            @Override
                            public void onResponse(Call<List<TestKit>> innerCall, Response<List<TestKit>> innerResponse) {
                                // remove all duplicate testKitIds at this stage
                                Log.d(TAG, "Is anything coming from EHR : " + innerResponse.body());
                                Set<TestKit> formattedTestsKits = new HashSet<>(innerResponse.body());
                                Log.d(TAG, "After formatting and removing all duplicated testkit IDS : " + formattedTestsKits);
                                List<TestKitTestLevel> testKitTestLevels = new ArrayList<>();
                                for (TestKit item : formattedTestsKits) {
                                    testKitTestLevels.add(new TestKitTestLevel(item.getCode(), testLevel));
                                }
                                Log.i(TAG, "Test kits with test levels : " + testKitTestLevels);
                                terminologyService.saveTestkitTestLevels(testKitTestLevels);
                                Log.i(TAG, "Saved test kit test levels : " + ehrMobileDatabase.testKitTestLevelDao().findAll());
                            }

                            @Override
                            public void onFailure(Call<List<TestKit>> innerCall, Throwable t) {
                                Log.e(TAG, "Error has occurred : " + t.getMessage());
                            }
                        });
                    }
                }
            }

            @Override
            public void onFailure(Call<TestKitModel> call, Throwable t) {
                Log.e(TAG, "Error saving testkits : " + t.getMessage());
            }
        });
    }

    public void getNationalities(Token token, String baseUrl) {

        DataSyncService service = RetrofitClient.getRetrofitInstance(baseUrl).create(DataSyncService.class);
        Call<TerminologyModel> call = service.getNationalities("Bearer " + token.getId_token(), new Page().size);
        call.enqueue(new Callback<TerminologyModel>() {
            @Override
            public void onResponse(Call<TerminologyModel> call, Response<TerminologyModel> response) {
                List<Nationality> nationalities = new ArrayList<Nationality>();

                if (response.isSuccessful()) {
                    for (BaseNameModel item : response.body().getContent()) {
                        nationalities.add(new Nationality(item.getCode(), item.getName()));
                    }

                    if (!nationalities.isEmpty()) {
                        terminologyService.saveNationalityToDB(nationalities);
                    }
                }
            }

            @Override
            public void onFailure(Call<TerminologyModel> call, Throwable t) {

            }
        });
    }

    public void getLaboratoryResults(Token token, String baseUrl) {

        DataSyncService service = RetrofitClient.getRetrofitInstance(baseUrl).create(DataSyncService.class);
        Call<TerminologyModel> call = service.getLaboratoryResults("Bearer " + token.getId_token(), new Page().size);
        call.enqueue(new Callback<TerminologyModel>() {
            @Override
            public void onResponse(Call<TerminologyModel> call, Response<TerminologyModel> response) {
                List<Result> results = new ArrayList<Result>();
                for (BaseNameModel item : response.body().getContent()) {
                    results.add(new Result(item.getCode(), item.getName()));
                }

                if (!results.isEmpty()) {
                    terminologyService.saveLaboratoryResults(results);
                }
            }

            @Override
            public void onFailure(Call<TerminologyModel> call, Throwable t) {

            }
        });
    }

    public void getArtStatus(Token token, String baseUrl) {

        DataSyncService service = RetrofitClient.getRetrofitInstance(baseUrl).create(DataSyncService.class);
        Call<TerminologyModel> call = service.getArtStatuses("Bearer " + token.getId_token(), new Page().size);
        call.enqueue(new Callback<TerminologyModel>() {
            @Override
            public void onResponse(Call<TerminologyModel> call, Response<TerminologyModel> response) {
                List<ArtStatus> artStatuses = new ArrayList<ArtStatus>();
                for (BaseNameModel item : response.body().getContent()) {
                    artStatuses.add(new ArtStatus(item.getCode(), item.getName()));
                }

                if (!artStatuses.isEmpty()) {
                    terminologyService.saveArtStatus(artStatuses);
                }
            }

            @Override
            public void onFailure(Call<TerminologyModel> call, Throwable t) {

            }
        });
    }

    public void getInvestigationResults(Token token, String baseUrl) {

        DataSyncService service = RetrofitClient.getRetrofitInstance(baseUrl).create(DataSyncService.class);
        Call<InvestigationResultModel> call = service.getInvestigationResults("Bearer " + token.getId_token(), new Page().size);
        call.enqueue(new Callback<InvestigationResultModel>() {
            @Override
            public void onResponse(Call<InvestigationResultModel> call, Response<InvestigationResultModel> response) {
                terminologyService.saveInvestigationResultsToDB(response.body().getContent());
            }

            @Override
            public void onFailure(Call<InvestigationResultModel> call, Throwable t) {

            }
        });
    }

    public void getArtReasons(Token token, String baseUrl) {

        DataSyncService service = RetrofitClient.getRetrofitInstance(baseUrl).create(DataSyncService.class);
        Call<ArtReasonModel> call = service.getArtReasons("Bearer " + token.getId_token(), new Page().size);
        call.enqueue(new Callback<ArtReasonModel>() {
            @Override
            public void onResponse(Call<ArtReasonModel> call, Response<ArtReasonModel> response) {
                terminologyService.saveArtReason(response.body().getContent());
            }

            @Override
            public void onFailure(Call<ArtReasonModel> call, Throwable t) {

            }
        });
    }


    public void getCountries(Token token, String baseUrl) {
        DataSyncService service = RetrofitClient.getRetrofitInstance(baseUrl).create(DataSyncService.class);

        Call<TerminologyModel> call = service.getCountries("Bearer " + token.getId_token(), new Page().size);
        call.enqueue(new Callback<TerminologyModel>() {
            @Override
            public void onResponse(Call<TerminologyModel> call, Response<TerminologyModel> response) {
                List<Country> countries = new ArrayList<Country>();
                if (response.isSuccessful()) {
                    for (BaseNameModel item : response.body().getContent()) {
                        countries.add(new Country(item.getCode(), item.getName()));
                    }
                    if (!countries.isEmpty()) {
                        terminologyService.saveCountriesToDB(countries);
                    }
                }
            }

            @Override
            public void onFailure(Call<TerminologyModel> call, Throwable t) {

            }
        });


    }

    public void getDisclosureMethods(Token token, String baseUrl) {
        DataSyncService service = RetrofitClient.getRetrofitInstance(baseUrl).create(DataSyncService.class);

        Call<NameIdSynchModel> call = service.getDisclosureMethods("Bearer " + token.getId_token(), new Page().size);
        call.enqueue(new Callback<NameIdSynchModel>() {
            @Override
            public void onResponse(Call<NameIdSynchModel> call, Response<NameIdSynchModel> response) {
                List<DisclosureMethod> items = new ArrayList<DisclosureMethod>();
                if (response.isSuccessful()) {
                    for (NameIdModel item : response.body().getContent()) {
                        items.add(new DisclosureMethod(item.getId(), item.getName()));
                    }
                    if (!items.isEmpty()) {
                        terminologyService.saveDisclosureMethod(items);
                    }
                }
            }

            @Override
            public void onFailure(Call<NameIdSynchModel> call, Throwable t) {

            }
        });
    }

    public void getTestingPlan(Token token, String baseUrl) {
        DataSyncService service = RetrofitClient.getRetrofitInstance(baseUrl).create(DataSyncService.class);

        Call<NameIdSynchModel> call = service.getTestPlans("Bearer " + token.getId_token(), new Page().size);
        call.enqueue(new Callback<NameIdSynchModel>() {
            @Override
            public void onResponse(Call<NameIdSynchModel> call, Response<NameIdSynchModel> response) {
                List<TestingPlan> items = new ArrayList<TestingPlan>();
                if (response.isSuccessful()) {
                    for (NameIdModel item : response.body().getContent()) {
                        items.add(new TestingPlan(item.getId(), item.getName()));
                    }
                    if (!items.isEmpty()) {
                        terminologyService.saveTestingPlan(items);
                    }
                }
            }

            @Override
            public void onFailure(Call<NameIdSynchModel> call, Throwable t) {

            }
        });
    }

    //Phineas
    public void getEducationLevels(Token token, String baseUrl) {

        DataSyncService service = RetrofitClient.getRetrofitInstance(baseUrl).create(DataSyncService.class);
        Call<TerminologyModel> call = service.getEducationLevels("Bearer " + token.getId_token(), new Page().size);
        call.enqueue(new Callback<TerminologyModel>() {
            @Override
            public void onResponse(Call<TerminologyModel> call, Response<TerminologyModel> response) {
                List<EducationLevel> educationLevels = new ArrayList<EducationLevel>();

                if (response.isSuccessful()) {
                    for (BaseNameModel item : response.body().getContent()) {
                        educationLevels.add(new EducationLevel(item.getCode(), item.getName()));
                    }

                    if (educationLevels != null && !educationLevels.isEmpty()) {
                        terminologyService.saveEducationLevelToDB(educationLevels);
                    }
                }
            }

            @Override
            public void onFailure(Call<TerminologyModel> call, Throwable t) {

            }
        });
    }


    public void getEntryPoints(Token token, String baseUrl) {

        DataSyncService service = RetrofitClient.getRetrofitInstance(baseUrl).create(DataSyncService.class);
        Call<TerminologyModel> call = service.getEntryPoints("Bearer " + token.getId_token(), new Page().size);
        call.enqueue(new Callback<TerminologyModel>() {
            @Override
            public void onResponse(Call<TerminologyModel> call, Response<TerminologyModel> response) {
                List<EntryPoint> entryPointList = new ArrayList<EntryPoint>();
                for (BaseNameModel item : response.body().getContent()) {
                    entryPointList.add(new EntryPoint(item.getCode(), item.getName()));
                }
                if (entryPointList != null && !entryPointList.isEmpty()) {

                    terminologyService.saveEntryPointsToDB(entryPointList);
                }
            }

            @Override
            public void onFailure(Call<TerminologyModel> call, Throwable t) {

                System.out.println("tttttttttttttttttttttttt" + t);

            }
        });
    }

    public void getHtsModels(Token token, String baseUrl) {
        DataSyncService service = RetrofitClient.getRetrofitInstance(baseUrl).create(DataSyncService.class);
        Call<TerminologyModel> call = service.getHtsModels("Bearer " + token.getId_token(), new Page().size);
        call.enqueue(new Callback<TerminologyModel>() {
            @Override
            public void onResponse(Call<TerminologyModel> call, Response<TerminologyModel> response) {
                List<HtsModel> htsModelList = new ArrayList<HtsModel>();
                for (BaseNameModel item : response.body().getContent()) {
                    htsModelList.add(new HtsModel(item.getCode(), item.getName()));
                }
                if (htsModelList != null && !htsModelList.isEmpty()) {

                    terminologyService.saveHtsModelToDB(htsModelList);
                }
            }

            @Override
            public void onFailure(Call<TerminologyModel> call, Throwable t) {


            }
        });
    }


    public void getPurpose_Of_Tests(Token token, String baseUrl) {

        DataSyncService service = RetrofitClient.getRetrofitInstance(baseUrl).create(DataSyncService.class);
        Call<TerminologyModel> call = service.getPurpose_Of_Tests("Bearer " + token.getId_token(), new Page().size);
        call.enqueue(new Callback<TerminologyModel>() {
            @Override
            public void onResponse(Call<TerminologyModel> call, Response<TerminologyModel> response) {
                List<PurposeOfTest> purpose_of_testList = new ArrayList<PurposeOfTest>();
                for (BaseNameModel item : response.body().getContent()) {
                    purpose_of_testList.add(new PurposeOfTest(item.getCode(), item.getName()));
                }
                if (purpose_of_testList != null && !purpose_of_testList.isEmpty()) {

                    terminologyService.savePurposeOfTestToDB(purpose_of_testList);
                }


            }

            @Override
            public void onFailure(Call<TerminologyModel> call, Throwable t) {

                System.out.println("tttttttttttttttttttttttt" + t);

            }
        });
    }

    public void getReasonForNotIssuingResults(Token token, String baseUrl) {

        DataSyncService service = RetrofitClient.getRetrofitInstance(baseUrl).create(DataSyncService.class);
        Call<TerminologyModel> call = service.getReasonForNotIssuingResults("Bearer " + token.getId_token(), new Page().size);
        call.enqueue(new Callback<TerminologyModel>() {
            @Override
            public void onResponse(Call<TerminologyModel> call, Response<TerminologyModel> response) {
                List<ReasonForNotIssuingResult> reasonForNotIssuingResultList = new ArrayList<ReasonForNotIssuingResult>();
                for (BaseNameModel item : response.body().getContent()) {
                    reasonForNotIssuingResultList.add(new ReasonForNotIssuingResult(item.getCode(), item.getName()));
                }
                if (reasonForNotIssuingResultList != null && !reasonForNotIssuingResultList.isEmpty()) {

                    terminologyService.saveReasonForNotIssuingResultToDB(reasonForNotIssuingResultList);
                }
            }

            @Override
            public void onFailure(Call<TerminologyModel> call, Throwable t) {

                System.out.println("tttttttttttttttttttttttt" + t);

            }
        });
    }

    void saveUsersToDB(List<User> userListInstance) {

        ehrMobileDatabase.userDao().insertUsers(userListInstance);
        List<User> usersFromDB = ehrMobileDatabase.userDao().selectAllUsers();
        System.out.println("from database \n\n" + usersFromDB);
        saveAuthorities(usersFromDB);
        System.out.println("user by iiiiiidd%%%%%%%%%%%%%%%%%%" + ehrMobileDatabase.userDao().findUserByid(1));

    }

    void saveAuthorities(List<User> usersFromDB) {
        List<Authorities> authorities = new ArrayList<Authorities>();

        /*
        TODO brian refactor this part
        usersFromDB.forEach(user ->

                userList.forEach(user1 ->
                        user1.getAuthorities().forEach(authority ->
                                authorities.add(new Authorities(user.getUserId(), authority)))
                )

        );
        ehrMobileDatabase.authoritiesDao().insertAuthorities(authorities);
*/
        System.out.println("froooooooooooooom DB=================" + ehrMobileDatabase.authoritiesDao().getAllAuthorities());
//        ehrMobileDatabase.permissionsDao().insertPermissions();
        testById(1);


    }

    void testById(int id) {
        System.out.println("get by id --------------" + ehrMobileDatabase.authoritiesDao().findAuthoritiesByUserId(1));
    }


    public void getReligion(Token token, String baseUrl) {

        DataSyncService service = RetrofitClient.getRetrofitInstance(baseUrl).create(DataSyncService.class);
        Call<TerminologyModel> call = service.getReligion("Bearer " + token.getId_token(), new Page().size);
        call.enqueue(new Callback<TerminologyModel>() {
            @Override
            public void onResponse(Call<TerminologyModel> call, Response<TerminologyModel> response) {
                List<Religion> religionList = new ArrayList<Religion>();
                for (BaseNameModel item : response.body().getContent()) {
                    religionList.add(new Religion(item.getCode(), item.getName()));
                }
                if (religionList != null && !religionList.isEmpty()) {
                    terminologyService.saveReligionToDB(religionList);
                }
            }

            @Override
            public void onFailure(Call<TerminologyModel> call, Throwable t) {
                Log.i(TAG, t.getMessage());
            }
        });
    }

    public void getTowns(Token token, String baseUrl) {
        DataSyncService service = RetrofitClient.getRetrofitInstance(baseUrl).create(DataSyncService.class);
        Call<TerminologyModel> call = service.getTowns("Bearer " + token.getId_token(), new Page().size);
        call.enqueue(new Callback<TerminologyModel>() {
            @Override
            public void onResponse(Call<TerminologyModel> call, Response<TerminologyModel> response) {
                List<Town> townList = new ArrayList<Town>();
                for (BaseNameModel item : response.body().getContent()) {
                    townList.add(new Town(item.getCode(), item.getName()));
                }
                if (townList != null && !townList.isEmpty()) {
                    terminologyService.saveTownToDB(townList);
                }
            }

            @Override
            public void onFailure(Call<TerminologyModel> call, Throwable t) {

            }
        });
    }

    public void clearTables() {

        ehrMobileDatabase.patientWardDao().deleteAll();
        ehrMobileDatabase.artLinkageFromDao().deleteAll();
        ehrMobileDatabase.patientQueueDao().deleteAll();
        ehrMobileDatabase.sexualHistoryQuestionDao().deleteAll();
        ehrMobileDatabase.indexContactDao().deleteAll();
        ehrMobileDatabase.indexTestDao().deleteAll();
        ehrMobileDatabase.artDao().deleteAll();
        ehrMobileDatabase.htsScreeningDao().deleteAll();
        ehrMobileDatabase.sexualHistoryDao().deleteAll();
        ehrMobileDatabase.artCurrentStatusDao().deleteAll();
        ehrMobileDatabase.personInvestigationDao().deletePersonInvestigations();
        ehrMobileDatabase.htsDao().deleteAll();
        ehrMobileDatabase.bloodPressureDao().deleteAll();
        ehrMobileDatabase.temperatureDao().deleteAll();
        ehrMobileDatabase.pulseDao().deleteAll();
        ehrMobileDatabase.respiratoryRateDao().deleteAll();
        ehrMobileDatabase.weightDao().deleteAll();
        ehrMobileDatabase.heightDao().deleteAll();
        ehrMobileDatabase.visitDao().deleteAll();
        ehrMobileDatabase.relationshipDao().deleteAll();
        ehrMobileDatabase.personDao().deleteAll();
        ehrMobileDatabase.investigationResultDao().delete();
        ehrMobileDatabase.countryDao().deleteAll();
        ehrMobileDatabase.maritalStateDao().deleteALl();
        ehrMobileDatabase.facilityDao().deleteAll();
        ehrMobileDatabase.townsDao().deleteAll();
        ehrMobileDatabase.religionDao().deleteAll();
        ehrMobileDatabase.occupationDao().deleteAll();
        ehrMobileDatabase.disclosureMethodDao().deleteALl();
        ehrMobileDatabase.testingPlanDao().deleteALl();
        ehrMobileDatabase.nationalityDao().deleteAll();
        ehrMobileDatabase.educationLevelDao().deleteAll();
        ehrMobileDatabase.entryPointDao().deleteAll();
        ehrMobileDatabase.htsModelDao().deleteAll();
        ehrMobileDatabase.purposeOfTestDao().deleteAll();
        ehrMobileDatabase.reasonForNotIssuingResultDao().deleteAll();
        ehrMobileDatabase.userDao().deleteUsers();
        ehrMobileDatabase.testKitTestLevelDao().deleteAll();
        ehrMobileDatabase.testKitDao().deleteAll();
        ehrMobileDatabase.investigationTestkitDao().deleteAll();
        ehrMobileDatabase.investigationDao().deleteInvestigations();
        ehrMobileDatabase.resultDao().deleteAll();
        ehrMobileDatabase.laboratoryTestDao().deleteAll();
        ehrMobileDatabase.arvCombinationRegimenDao().deleteAll();
        ehrMobileDatabase.artReasonDao().deleteAll();
        ehrMobileDatabase.artStatusDao().deleteAll();
        ehrMobileDatabase.laboratoryInvestigationDao().deleteAll();
        ehrMobileDatabase.testKitBatchIssueDao().deleteAll();
        ehrMobileDatabase.sampleDao().deleteAll();
        ehrMobileDatabase.diagnosisDao().deleteAll();
        ehrMobileDatabase.questionDao().deleteAll();
        ehrMobileDatabase.questionCategoryDao().deleteAll();
        ehrMobileDatabase.labInvestTestdao().deleteLaboratoryInvestTests();
    }


    private int saveTestKitsToDB
            (List<TestKit> testKits) {
        ehrMobileDatabase.testKitDao().saveAll(testKits);
        Log.d(TAG, "^^&&&&&&& " + testKits);
        int testKitsCount = ehrMobileDatabase.testKitDao().findAll().size();

        return testKitsCount;
    }

    public void getSample(Token token, String baseUrl) {

        DataSyncService service = RetrofitClient.getRetrofitInstance(baseUrl).create(DataSyncService.class);
        Call<TerminologyModel> call = service.getSamples("Bearer " + token.getId_token(), new Page().size);
        call.enqueue(new Callback<TerminologyModel>() {
            @Override
            public void onResponse(Call<TerminologyModel> call, Response<TerminologyModel> response) {
                List<Sample> sampleList = new ArrayList<Sample>();
                for (BaseNameModel item : response.body().getContent()) {
                    sampleList.add(new Sample(item.getCode(), item.getName()));
                }
                if (sampleList != null && !sampleList.isEmpty()) {
                    terminologyService.saveSample(sampleList);
                }
            }

            @Override
            public void onFailure(Call<TerminologyModel> call, Throwable t) {
                Log.i(TAG, t.getMessage());
            }
        });
    }

    public void getDiagnosis(Token token, String baseUrl) {

        DataSyncService service = RetrofitClient.getRetrofitInstance(baseUrl).create(DataSyncService.class);
        Call<TerminologyModel> call = service.getDiagnosis("Bearer " + token.getId_token(), new Page().size);
        call.enqueue(new Callback<TerminologyModel>() {
            @Override
            public void onResponse(Call<TerminologyModel> call, Response<TerminologyModel> response) {
                List<Diagnosis> diagnosisList = new ArrayList<>();
                for (BaseNameModel item : response.body().getContent()) {
                    diagnosisList.add(new Diagnosis(item.getCode(), item.getName()));
                }
                terminologyService.saveDiagnosis(diagnosisList);
            }

            @Override
            public void onFailure(Call<TerminologyModel> call, Throwable t) {
                Log.i(TAG, t.getMessage());
            }
        });
    }

    public void getLaboratoryTest(Token token, String
            baseUrl) {

        DataSyncService service = RetrofitClient.getRetrofitInstance(baseUrl).create(DataSyncService.class);
        Call<TerminologyModel> call = service.getLaboratoryTests("Bearer " + token.getId_token(), new Page().size);
        call.enqueue(new Callback<TerminologyModel>() {
            @Override
            public void onResponse(Call<TerminologyModel> call, Response<TerminologyModel> response) {
                List<LaboratoryTest> laboratoryTestList = new ArrayList<LaboratoryTest>();
                for (BaseNameModel item : response.body().getContent()) {
                    laboratoryTestList.add(new LaboratoryTest(item.getCode(), item.getName()));
                }
                if (laboratoryTestList != null && !laboratoryTestList.isEmpty()) {
                    terminologyService.saveLaboratoryTests(laboratoryTestList);
                }
            }

            @Override
            public void onFailure(Call<TerminologyModel> call, Throwable t) {
                Log.i(TAG, t.getMessage());
            }
        });
    }

    public void getInvestigations(Token token, String
            baseUrl) {

        DataSyncService service = RetrofitClient.getRetrofitInstance(baseUrl).create(DataSyncService.class);
        Call<InvestigationModel> call = service.getInvestigations("Bearer " + token.getId_token(), new Page().size);
        call.enqueue(new Callback<InvestigationModel>() {
            @Override
            public void onResponse(Call<InvestigationModel> call, Response<InvestigationModel> response) {
                List<Investigation> investigations = new ArrayList<Investigation>();
                for (InvestigationEhr item : response.body().getContent()) {
                    investigations.add(new Investigation(item.getInvestigationId(), item.getLaboratoryTestId(), item.getSampleId()));
                }
                Log.i(TAG, ";;;;;;;;;;;;;; investigations from ehr : " + investigations);
                if (investigations != null && !investigations.isEmpty()) {
                    terminologyService.saveInvestigations(investigations);
                }
            }

            @Override
            public void onFailure(Call<InvestigationModel> call, Throwable t) {
                Log.i(TAG, t.getMessage());
            }
        });
    }

    public void getQuestionCategories(Token token, String baseUrl) {

        DataSyncService service = RetrofitClient.getRetrofitInstance(baseUrl).create(DataSyncService.class);
        Call<QuestionCategoryModel> call = service.getQuestionCategories("Bearer " + token.getId_token(), new Page().size);
        call.enqueue(new Callback<QuestionCategoryModel>() {
            @Override
            public void onResponse(Call<QuestionCategoryModel> call, Response<QuestionCategoryModel> response) {
                List<QuestionCategory> questionCategories = new ArrayList<>();
                for (QuestionCategoryEhr item : response.body().getContent()) {
                    //
                    questionCategories.add(new QuestionCategory(
                            item.getQuestionCategoryId(), item.getName(), item.getSortOrder(), WorkArea.get(item.getWorkArea())
                    ));
                }
                terminologyService.saveQuestionCategory(questionCategories);
            }

            @Override
            public void onFailure(Call<QuestionCategoryModel> call, Throwable t) {
                Log.i(TAG, t.getMessage());
            }
        });
    }

    public void getQuestions(Token token, String baseUrl) {

        DataSyncService service = RetrofitClient.getRetrofitInstance(baseUrl).create(DataSyncService.class);
        Call<QuestionModel> call = service.getQuestions("Bearer " + token.getId_token(), new Page().size);
        call.enqueue(new Callback<QuestionModel>() {
            @Override
            public void onResponse(Call<QuestionModel> call, Response<QuestionModel> response) {
                List<Question> questions = new ArrayList<>();
                Log.d(TAG, "&&&&&&&&&&&&&&&&&&&&&&&&&& : " + response.body().getContent());
                for (QuestionEhr item : response.body().getContent()) {
                    questions.add(new Question(
                            item.getQuestionId(), item.getName(), item.getCategoryId(), QuestionType.get(item.getType())
                    ));
                }
                terminologyService.saveQuestions(questions);
            }

            @Override
            public void onFailure(Call<QuestionModel> call, Throwable t) {
                Log.i(TAG, t.getMessage());
            }
        });
    }

    public void getInvestigationTestKits(Token token, String baseUrl) {

        DataSyncService service = RetrofitClient.getRetrofitInstance(baseUrl).create(DataSyncService.class);
        Call<InvestigationTestkitModel> call = service.getInvestigationTestKits("Bearer " + token.getId_token(), new Page().size);
        call.enqueue(new Callback<InvestigationTestkitModel>() {
            @Override
            public void onResponse(Call<InvestigationTestkitModel> call, Response<InvestigationTestkitModel> response) {
                List<InvestigationTestkit> investigationTestKits = new ArrayList<>();
                Log.d(TAG, "Investigation testkits : " + response.body().getContent());
                for (InvestigationTestkitEhr item : response.body().getContent()) {
                    investigationTestKits.add(new InvestigationTestkit(
                            item.getInvestigationTestKitId(), item.getInvestigationId(), item.getTestKitId()));
                }
                terminologyService.saveInvestigationTestKits(investigationTestKits);
            }

            @Override
            public void onFailure(Call<InvestigationTestkitModel> call, Throwable t) {
                Log.i(TAG, t.getMessage());
            }
        });
    }

    public void getArvCombinationRegimens(Token token, String baseUrl) {

        DataSyncService service = RetrofitClient.getRetrofitInstance(baseUrl).create(DataSyncService.class);
        Call<ArvCombinationRegimenModel> call = service.getArvCombinationRegimen("Bearer " + token.getId_token(), new Page().size);
        call.enqueue(new Callback<ArvCombinationRegimenModel>() {
            @Override
            public void onResponse(Call<ArvCombinationRegimenModel> call, Response<ArvCombinationRegimenModel> response) {

                if (response.body() == null || response.body().getContent() == null) {
                    return;
                }
                Log.d(TAG, "Arv combination regmines : " + response.body().getContent());

                terminologyService.saveArvCombinationRegimen(ArvCombinationRegimenEhr.getInstance(response.body().getContent()));
            }

            @Override
            public void onFailure(Call<ArvCombinationRegimenModel> call, Throwable t) {
                Log.i(TAG, t.getMessage());
            }
        });
    }
}