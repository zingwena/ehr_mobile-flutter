package zw.gov.mohcc.mrs.ehr_mobile;

import android.os.Bundle;
import android.util.Log;

import androidx.sqlite.db.SimpleSQLiteQuery;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;

import org.apache.commons.lang3.StringUtils;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import io.flutter.app.FlutterActivity;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugins.GeneratedPluginRegistrant;
import retrofit2.Call;
import retrofit2.Callback;
import retrofit2.Response;
import zw.gov.mohcc.mrs.ehr_mobile.configuration.RetrofitClient;
import zw.gov.mohcc.mrs.ehr_mobile.configuration.apolloClient.PatientsApolloClient;
import zw.gov.mohcc.mrs.ehr_mobile.dto.HtsRegDTO;
import zw.gov.mohcc.mrs.ehr_mobile.dto.LaboratoryInvestigationDTO;
import zw.gov.mohcc.mrs.ehr_mobile.dto.PatientDto;
import zw.gov.mohcc.mrs.ehr_mobile.dto.PatientPhoneDto;
import zw.gov.mohcc.mrs.ehr_mobile.dto.PreTestDTO;
import zw.gov.mohcc.mrs.ehr_mobile.model.Address;
import zw.gov.mohcc.mrs.ehr_mobile.model.ArtInitiation;
import zw.gov.mohcc.mrs.ehr_mobile.model.ArtRegistration;
import zw.gov.mohcc.mrs.ehr_mobile.model.Authorities;
import zw.gov.mohcc.mrs.ehr_mobile.model.BaseNameModel;
import zw.gov.mohcc.mrs.ehr_mobile.model.Country;
import zw.gov.mohcc.mrs.ehr_mobile.model.EducationLevel;
import zw.gov.mohcc.mrs.ehr_mobile.model.EntryPoint;
import zw.gov.mohcc.mrs.ehr_mobile.model.Facility;
import zw.gov.mohcc.mrs.ehr_mobile.model.Hts;
import zw.gov.mohcc.mrs.ehr_mobile.model.HtsModel;
import zw.gov.mohcc.mrs.ehr_mobile.model.Investigation;
import zw.gov.mohcc.mrs.ehr_mobile.model.InvestigationEhr;
import zw.gov.mohcc.mrs.ehr_mobile.model.InvestigationModel;
import zw.gov.mohcc.mrs.ehr_mobile.model.InvestigationResultModel;
import zw.gov.mohcc.mrs.ehr_mobile.model.LaboratoryInvestigation;
import zw.gov.mohcc.mrs.ehr_mobile.model.LaboratoryInvestigationTest;
import zw.gov.mohcc.mrs.ehr_mobile.model.LaboratoryTest;
import zw.gov.mohcc.mrs.ehr_mobile.model.MaritalStatus;
import zw.gov.mohcc.mrs.ehr_mobile.model.Nationality;
import zw.gov.mohcc.mrs.ehr_mobile.model.Occupation;
import zw.gov.mohcc.mrs.ehr_mobile.model.PatientPhoneNumber;
import zw.gov.mohcc.mrs.ehr_mobile.model.Person;
import zw.gov.mohcc.mrs.ehr_mobile.model.PersonInvestigation;
import zw.gov.mohcc.mrs.ehr_mobile.model.PurposeOfTest;
import zw.gov.mohcc.mrs.ehr_mobile.model.ReasonForNotIssuingResult;
import zw.gov.mohcc.mrs.ehr_mobile.model.Religion;
import zw.gov.mohcc.mrs.ehr_mobile.model.Result;
import zw.gov.mohcc.mrs.ehr_mobile.model.Sample;
import zw.gov.mohcc.mrs.ehr_mobile.model.TerminologyModel;
import zw.gov.mohcc.mrs.ehr_mobile.model.TestKit;
import zw.gov.mohcc.mrs.ehr_mobile.model.Token;
import zw.gov.mohcc.mrs.ehr_mobile.model.Town;
import zw.gov.mohcc.mrs.ehr_mobile.model.User;
import zw.gov.mohcc.mrs.ehr_mobile.model.vitals.BloodPressure;
import zw.gov.mohcc.mrs.ehr_mobile.model.vitals.Height;
import zw.gov.mohcc.mrs.ehr_mobile.model.vitals.Pulse;
import zw.gov.mohcc.mrs.ehr_mobile.model.vitals.RespiratoryRate;
import zw.gov.mohcc.mrs.ehr_mobile.model.vitals.Temperature;
import zw.gov.mohcc.mrs.ehr_mobile.model.vitals.Weight;
import zw.gov.mohcc.mrs.ehr_mobile.persistance.dao.raw.PersonQuery;
import zw.gov.mohcc.mrs.ehr_mobile.persistance.database.EhrMobileDatabase;
import zw.gov.mohcc.mrs.ehr_mobile.service.DataSyncService;
import zw.gov.mohcc.mrs.ehr_mobile.service.HtsService;
import zw.gov.mohcc.mrs.ehr_mobile.service.TerminologyService;
import zw.gov.mohcc.mrs.ehr_mobile.service.VisitService;
import zw.gov.mohcc.mrs.ehr_mobile.util.DateDeserializer;
import zw.gov.mohcc.mrs.ehr_mobile.util.LoginValidator;

public class MainActivity extends FlutterActivity {

    final static String CHANNEL = "Authentication";
    final static String DATACHANNEL = "zw.gov.mohcc.mrs.ehr_mobile/dataChannel";
    final static String HTSCHANNEL = "zw.gov.mohcc.mrs.ehr_mobile/htsChannel";
    final static String PATIENTCHANNEL = "zw.gov.mohcc.mrs.ehr_mobile/addPatient";
    private final static String PATIENT_CHANNEL = "ehr_mobile.channel/patient";
    private final static String VITALS_CHANNEL = "ehr_mobile.channel/vitals";
    private final static String ART_CHANNEL = "zw.gov.mohcc.mrs.ehr_mobile.channel/art";
    private final static String TAG = "Main Activity";
    public Token token;
    public String url, username, password;
    private EhrMobileDatabase ehrMobileDatabase;
    private VisitService visitService;
    private HtsService htsService;
    private TerminologyService terminologyService;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        GeneratedPluginRegistrant.registerWith(this);

        getApplicationContext();
        ehrMobileDatabase = EhrMobileDatabase.getDatabaseInstance(getApplication());

        visitService = new VisitService(ehrMobileDatabase);
        htsService = new HtsService(ehrMobileDatabase);
        terminologyService = new TerminologyService(ehrMobileDatabase);


        new MethodChannel(getFlutterView(), PATIENTCHANNEL).setMethodCallHandler(new MethodChannel.MethodCallHandler() {
            @Override
            public void onMethodCall(MethodCall methodCall, MethodChannel.Result result) {

                Gson gson = new GsonBuilder().registerTypeAdapter(Date.class, new DateDeserializer()).create();
                if (methodCall.method.equals("registerPatient")) {
                    String args = methodCall.arguments();

                    PatientDto patientDto = gson.fromJson(args, PatientDto.class);

                    Person person = new Person(patientDto.getFirstName(), patientDto.getLastName(), patientDto.getSex());

                    person.setId(patientDto.getPersonId());
                    person.setNationalId(patientDto.getNationalId());
                    person.setReligionId(patientDto.getReligion());
                    person.setMaritalStatusId(patientDto.getMaritalStatus());
                    person.setEducationLevelId(patientDto.getEducationLevel());
                    person.setNationalityId(patientDto.getNationality());
                    person.setCountryId(patientDto.getCountryOfBirth());
                    person.setSelfIdentifiedGender(patientDto.getSelfIdentifiedGender());
                    person.setAddress(patientDto.getAddress());
                    person.setNationalId(patientDto.getNationalId());
                    person.setReligionId(patientDto.getReligion());
                    person.setMaritalStatusId(patientDto.getMaritalStatus());
                    person.setEducationLevelId(patientDto.getEducationLevel());
                    person.setNationalityId(patientDto.getNationality());
                    person.setCountryId(patientDto.getCountryOfBirth());
                    person.setSelfIdentifiedGender(patientDto.getSelfIdentifiedGender());
                    person.setAddress(patientDto.getAddress());
                    person.setOccupationId(patientDto.getOccupation());
                    person.setBirthDate(patientDto.getBirthDate());

                    ehrMobileDatabase.personDao().createPatient(person);
                    result.success(person.getId());

                    System.out.println("==================-=-=-=-=-fromDB " + ehrMobileDatabase.personDao().findPatientById(person.getId()));
                }
                if (methodCall.method.equals("getPatientById")) {
                    String ags = methodCall.arguments();
                    Person person = ehrMobileDatabase.personDao().findPatientById(ags);

                    String response = gson.toJson(person);
                    result.success(response);
                }
                if (methodCall.method.equals("getPatientMaritalStatus")) {
                    String code = methodCall.arguments();
                    String name = ehrMobileDatabase.maritalStateDao().getMaritalStatusNameByCode(code);
                    result.success(name);
                }

                if (methodCall.method.equals("getEducationLevel")) {
                    String code = methodCall.arguments();
                    String name = ehrMobileDatabase.educationLevelDao().findByEducationLevelId(code);
                    result.success(name);
                }
                if (methodCall.method.equals("getOccupation")) {
                    String code = methodCall.arguments();
                    String name = ehrMobileDatabase.occupationDao().findOccupationsById(code);
                    result.success(name);
                }
                if (methodCall.method.equals("getNationality")) {
                    String code = methodCall.arguments();
                    String name = ehrMobileDatabase.nationalityDao().selectNationality(code);
                    result.success(name);
                }
                if (methodCall.method.equals("getAddress")) {
                    String code = methodCall.arguments();
                    Person patient = ehrMobileDatabase.personDao().findPatientById(code);
                    Address address = patient.getAddress();
                    String patient_address = address.getStreet() + " " + address.getTown() + "  ," + address.getCity();
                    System.out.println("ADDRESSS " + "street" + address.getStreet() + "town" + address.getTown() + "city" + address.getCity());
                    result.success(patient_address);
                }
                if (methodCall.method.equals("savephonenumber")) {

                    String args = methodCall.arguments();
                    System.out.println("PATIENT FROM FLUTTER" + args);
                    PatientPhoneDto patientPhoneDto = gson.fromJson(args, PatientPhoneDto.class);
                    System.out.println("PATIENT DTO" + patientPhoneDto);
                    String phoneNumberId = UUID.randomUUID().toString();
                    PatientPhoneNumber patientPhoneNumber = new PatientPhoneNumber(phoneNumberId, patientPhoneDto.getPersonId(), patientPhoneDto.getPhoneNumber1(), patientPhoneDto.getPhoneNumber2());
                    ehrMobileDatabase.patientPhoneDao().insertpatientphonenumber(patientPhoneNumber).intValue();
                    System.out.println("PATIENT NUMBER SAVED HERE ");
                  /*  PatientPhoneNumber patient_PhoneNumber = ehrMobileDatabase.patientPhoneDao().findById(phonenumber_id);
                    System.out.println("NUMBER 1" + patient_PhoneNumber.getPhonenumber_1());*/
                    /*System.out.println("PATIENT ID HERE"+ patient_PhoneNumber.getPatientId());*/
                    result.success(phoneNumberId);

/*
                    System.out.println("==================-=-=-=-=-fromDB " + ehrMobileDatabase.patientDao().findPatientById(id));
*/
                }
                if (methodCall.method.equals("getPhonenumber")) {
                    String args = methodCall.arguments();
                    Log.i(TAG, "PATIENT ID FROM FLUTTER " + args);
                    PatientPhoneNumber patientPhoneNumber = ehrMobileDatabase.patientPhoneDao().findByPatientId(args);

                    String phoneNumber = "";
                    if (patientPhoneNumber != null) {
                        if (StringUtils.isNoneBlank(patientPhoneNumber.getPhoneNumber1())) {
                            phoneNumber += patientPhoneNumber.getPhoneNumber1();
                        }
                        if (StringUtils.isNoneBlank(patientPhoneNumber.getPhoneNumber2())) {
                            if (StringUtils.isNoneBlank(phoneNumber)) {
                                phoneNumber += "/ " + patientPhoneNumber.getPhoneNumber2();
                            } else {
                                phoneNumber += patientPhoneNumber.getPhoneNumber2();
                            }
                        }
                    }

                    result.success(phoneNumber);
                }

            }
        });

        new MethodChannel(getFlutterView(), CHANNEL).setMethodCallHandler(new MethodChannel.MethodCallHandler() {
            @Override
            public void onMethodCall(final MethodCall methodCall, final MethodChannel.Result result) {
                if (methodCall.method.equals("DataSync")) {

                    ArrayList args = methodCall.arguments();

                    url = args.get(0).toString();
                    String tokenString = args.get(1).toString();
                    Token token = new Token(tokenString);


                    clearTables();
                    pullData(token, url);

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


        new MethodChannel(getFlutterView(), DATACHANNEL).setMethodCallHandler(
                new MethodChannel.MethodCallHandler() {
                    @Override
                    public void onMethodCall(MethodCall methodCall1, MethodChannel.Result result1) {
                        Gson gson = new Gson();
                        final String arguments = methodCall1.arguments();

                        if (methodCall1.method.equals("townOptions")) {
                            try {
                                System.out.println("----------==-=-=" + "here");
                                List<Town> towns = ehrMobileDatabase.townsDao().getAllTowns();
                                String townList = gson.toJson(towns);
                                result1.success(townList);
                            } catch (Exception e) {
                                System.out.println("Something went wrong " + e);
                            }
                        }

                        if (methodCall1.method.equals("religionOptions")) {
                            try {
                                List<Religion> religions = ehrMobileDatabase.religionDao().getAllReligions();

                                String religionList = gson.toJson(religions);
                                result1.success(religionList);
                            } catch (Exception e) {
                                System.out.println("something went wrong " + e.getMessage());
                            }
                        }
                        if (methodCall1.method.equals("countryOptions")) {
                            try {
                                List<Country> countries = ehrMobileDatabase.countryDao().getAllCountries();
                                System.out.println("*************************** native" + countries);
                                String countryList = gson.toJson(countries);
                                result1.success(countryList);
                            } catch (Exception e) {
                                System.out.println("something went wrong " + e.getMessage());
                            }
                        }
                        if (methodCall1.method.equals("occupationOptions")) {
                            try {
                                List<Occupation> occupations = ehrMobileDatabase.occupationDao().getAllOccupations();
                                String occupationList = gson.toJson(occupations);
                                result1.success(occupationList);
                            } catch (Exception e) {
                                System.out.println("something went wrong " + e.getMessage());
                            }
                        }
                        if (methodCall1.method.equals("educationLevelOptions")) {
                            try {
                                List<EducationLevel> educationLevels = ehrMobileDatabase.educationLevelDao().getEducationLevels();
                                String educationLevelList = gson.toJson(educationLevels);
                                result1.success(educationLevelList);

                            } catch (Exception e) {
                                System.out.println("something went wrong " + e.getMessage());

                            }
                        }

                        if (methodCall1.method.equals("nationalityOptions")) {
                            try {
                                List<Nationality> nationalities = ehrMobileDatabase.nationalityDao().selectAllNationalities();
                                String nationalityList = gson.toJson(nationalities);
                                result1.success(nationalityList);
                            } catch (Exception e) {
                                System.out.println("something went wrong " + e.getMessage());

                            }
                        }

                        if (methodCall1.method.equals("maritalStatusOptions")) {
                            try {
                                List<MaritalStatus> maritalStatuses = ehrMobileDatabase.maritalStateDao().getAllMaritalStates();
                                String maritalStatusList = gson.toJson(maritalStatuses);
                                result1.success(maritalStatusList);

                            } catch (Exception e) {
                                System.out.println("something went wrong " + e.getMessage());

                            }
                        }

                        if (methodCall1.method.equals("getEntryPointsOptions")) {
                            try {
                                List<EntryPoint> entryPoints = ehrMobileDatabase.entryPointDao().getAllEntryPoints();
                                String list = gson.toJson(entryPoints);
                                result1.success(list);
                            } catch (Exception e) {
                                System.out.println("something went wrong " + e.getMessage());

                            }
                        }

                        if (methodCall1.method.equals("saveHtsRegistration")) {
                            // TODO judge to add code here
                            /*try {
                                HtsRegistration htsRegistration = gson.fromJson(arguments, HtsRegistration.class);
//                                ehrMobileDatabase.htsRegistrationDao().createHtsRegistration()
                            } catch (Exception e) {
                                System.out.println("something went wrong " + e.getMessage());

                            }*/
                        }

                    }
                });
        new MethodChannel(getFlutterView(), PATIENT_CHANNEL).setMethodCallHandler(new MethodChannel.MethodCallHandler() {
            @Override
            public void onMethodCall(MethodCall call, MethodChannel.Result result1) {
                final String arguments = call.arguments();
                if (call.method.equals("searchPerson")) {
                    List<Person> _list;

                    String searchItem = arguments;
                    PersonQuery personQuery = new PersonQuery();
                    SimpleSQLiteQuery sqLiteQuery = personQuery.searchPerson(searchItem);
                    _list = ehrMobileDatabase.personDao().searchPatient(sqLiteQuery);
                    if (_list.isEmpty()){
                        SimpleSQLiteQuery sqLiteQuery1= personQuery.searchPersonBySurnameAndName(searchItem);
                        _list = ehrMobileDatabase.personDao().searchPatient(sqLiteQuery1);
                    }
                    Gson gson = new Gson();
                    result1.success(gson.toJson(_list));
                }
            }

        });


        new MethodChannel(getFlutterView(), VITALS_CHANNEL).setMethodCallHandler(new MethodChannel.MethodCallHandler() {
            @Override
            public void onMethodCall(MethodCall methodCall, MethodChannel.Result result) {

                final String arguments = methodCall.arguments();

                Gson gson = new Gson();
                if (methodCall.method.equals("bloodPressure")) {
                    BloodPressure bloodPressure = gson.fromJson(arguments, BloodPressure.class);
                    bloodPressure.setId(UUID.randomUUID().toString());
                    String visitId = visitService.getCurrentVisit(bloodPressure.getPersonId());
                    bloodPressure.setVisitId(visitId);
                    ehrMobileDatabase.bloodPressureDao().insert(bloodPressure);
                    BloodPressure bp = ehrMobileDatabase.bloodPressureDao().findByVisitId(visitId);

                } else if (methodCall.method.equals("temperature")) {

                    Temperature temperature = gson.fromJson(arguments, Temperature.class);
                    temperature.setId(UUID.randomUUID().toString());
                    String visitId = visitService.getCurrentVisit(temperature.getPersonId());
                    temperature.setVisitId(visitId);
                    ehrMobileDatabase.temperatureDao().insert(temperature);
                    System.out.println("temp == " + ehrMobileDatabase.temperatureDao().getAll());


                } else if (methodCall.method.equals("respiratoryRate")) {

                    RespiratoryRate respiratoryRate = gson.fromJson(arguments, RespiratoryRate.class);
                    respiratoryRate.setId(UUID.randomUUID().toString());
                    String visitId = visitService.getCurrentVisit(respiratoryRate.getPersonId());
                    respiratoryRate.setVisitId(visitId);
                    ehrMobileDatabase.respiratoryRateDao().insert(respiratoryRate);
                    System.out.println("respirat == " + ehrMobileDatabase.respiratoryRateDao().getAll());


                } else if (methodCall.method.equals("height")) {

                    Height height = gson.fromJson(arguments, Height.class);
                    height.setId(UUID.randomUUID().toString());
                    String visitId = visitService.getCurrentVisit(height.getPersonId());
                    height.setVisitId(visitId);
                    ehrMobileDatabase.heightDao().insert(height);
                    System.out.println("height == " + ehrMobileDatabase.heightDao().getAll());


                } else if (methodCall.method.equals("weight")) {

                    Weight weight = gson.fromJson(arguments, Weight.class);
                    weight.setId(UUID.randomUUID().toString());
                    String visitId = visitService.getCurrentVisit(weight.getPersonId());
                    weight.setVisitId(visitId);
                    ehrMobileDatabase.weightDao().insert(weight);


                } else if (methodCall.method.equals("pulse")) {

                    Pulse pulse = gson.fromJson(arguments, Pulse.class);
                    pulse.setId(UUID.randomUUID().toString());
                    String visitId = visitService.getCurrentVisit(pulse.getPersonId());
                    pulse.setVisitId(visitId);
                    ehrMobileDatabase.pulseDao().insert(pulse);
                    System.out.println("pulse == " + ehrMobileDatabase.pulseDao().getAll());


                } else {
                    result.notImplemented();
                }
            }

        });


        /*   ===============================================HTS TESTING  =============================================================== */
        new MethodChannel(getFlutterView(), HTSCHANNEL).setMethodCallHandler(
                new MethodChannel.MethodCallHandler() {
                    @Override
                    public void onMethodCall(MethodCall methodCall, MethodChannel.Result result) {
                        String arguments = methodCall.arguments();
                        Gson gson = new GsonBuilder().registerTypeAdapter(Date.class, new DateDeserializer()).create();

                        if (methodCall.method.equals("getResults")) {
                            try {
                                List<Result> resultList = ehrMobileDatabase.resultDao().getAllResults();
                                String results = gson.toJson(resultList);
                                result.success(results);
                            } catch (Exception e) {

                            }
                        }
                        if (methodCall.method.equals("htsModelOptions")) {
                            try {
                                List<HtsModel> htsModels = ehrMobileDatabase.htsModelDao().getAllHtsModels();

                                String htsModelList = gson.toJson(htsModels);
                                System.out.println("htsModel=====:" + htsModels);
                                result.success(htsModelList);
                            } catch (Exception e) {
                                System.out.println("something went wrong " + e.getMessage());
                            }
                        }
                        if (methodCall.method.equals("entrypointOptions")) {
                            try {
                                List<EntryPoint> entryPoints = ehrMobileDatabase.entryPointDao().getAllEntryPoints();
                                System.out.println("*************************** native" + entryPoints);
                                String entrypointList = gson.toJson(entryPoints);
                                result.success(entrypointList);
                            } catch (Exception e) {
                                System.out.println("something went wrong " + e.getMessage());
                            }
                        }
                        if (methodCall.method.equals("htsRegistration")) {
                            try {
                                System.out.println("HTS HERE HERE HERE" + arguments);
                                HtsRegDTO htsRegDTO = gson.fromJson(arguments, HtsRegDTO.class);
                                result.success(htsService.createHts(htsRegDTO));

                            } catch (Exception e) {
                                System.out.println("something went wrong " + e.getMessage());

                            }

                        }


                        if (methodCall.method.equals("purposeOfTestsOptions")) {
                            try {
                                List<PurposeOfTest> purpose_of_tests = ehrMobileDatabase.purposeOfTestDao().getAllPurposeOfTest();
                                String purposeOfTestsList = gson.toJson(purpose_of_tests);
                                result.success(purposeOfTestsList);
                            } catch (Exception e) {
                                System.out.println("something went wrong " + e.getMessage());
                            }
                        }

                        if (methodCall.method.equals("reasonForNotIssuingResultOptions")) {

                            try {
                                List<ReasonForNotIssuingResult> reasonForNotIssuingResults = ehrMobileDatabase.reasonForNotIssuingResultDao().getAllReasonForNotIssuingResults();
                                System.out.println("&&&&&&&&&&&&&&&&&&&&&&& reason for not issuing results :" + reasonForNotIssuingResults);
                                String reasonForNotIssuingResultList = gson.toJson(reasonForNotIssuingResults);
                                result.success(reasonForNotIssuingResultList);
                            } catch (Exception e) {
                                System.out.println("something went wrong" + e.getMessage());
                            }
                        }

                        if (methodCall.method.equals("savePreTest")) {

                            try {

                                PreTestDTO preTestDTO = gson.fromJson(arguments, PreTestDTO.class);
                                System.out.println(">>>>>>>>>>>>>>>>>>>>>>>>>>" + arguments);
                                Hts hts = ehrMobileDatabase.htsDao().findHtsById(preTestDTO.getHts_id());
                                hts.setHtsApproach(preTestDTO.getHtsApproach());
                                hts.setNewTestInClientLife(preTestDTO.getNewTest());
                                hts.setNewTestPregLact(preTestDTO.getNewTestPregLact());
                                hts.setCoupleCounselling(preTestDTO.getCoupleCounselling());
                                hts.setOptOutOfTest(preTestDTO.getOptOutOfTest());
                                ehrMobileDatabase.htsDao().updateHts(hts);


                            } catch (Exception e) {
                                System.out.println("something went wrong " + e.getMessage());

                            }
                        }
                        if (methodCall.method.equals("getHtsModel")) {
                            try {
                                HtsModel htsModel = ehrMobileDatabase.htsModelDao().findHtsModelByName(arguments);

                                result.success(htsModel);
                            } catch (Exception e) {

                                System.out.println("something went wrong " + e.getMessage());
                            }
                        }
                        if (methodCall.method.equals("getPurposeofTest")) {
                            try {
                                PurposeOfTest purposeOfTest = ehrMobileDatabase.purposeOfTestDao().findPurposeOfTestByName(arguments);
                                result.success(purposeOfTest);
                            } catch (Exception e) {
                                System.out.println("something went wrong " + e.getMessage());
                            }
                        }
                        if (methodCall.method.equals("saveLabInvestTest")) {
                            try {
                                LaboratoryInvestigationTest labInvestTest = gson.fromJson(arguments, LaboratoryInvestigationTest.class);

                                String labInvestigationId = UUID.randomUUID().toString();
                                labInvestTest.setId(labInvestigationId);
                                ehrMobileDatabase.labInvestTestdao().insertLaboratoryInvestTest(labInvestTest);
                                LaboratoryInvestigationTest laboratoryInvestigationTest = ehrMobileDatabase.labInvestTestdao().findByLaboratoryInvestTestId(labInvestigationId);
                                System.out.println("LABORATORY TEST LABORATORY TEST" + laboratoryInvestigationTest.getResultId());
                                System.out.println("List of LabInvestigations" + ehrMobileDatabase.labInvestTestdao().findAll());
                            } catch (Exception e) {
                                System.out.println("something went wrong " + e.getMessage());
                            }
                        }

                        if (methodCall.method.equals("saveResult")) {
                            try {
                                // get variables
                                Result result1 = gson.fromJson(arguments, Result.class);
                                System.out.println("HTS RESULT FROM FLUTTER" + result1);
                                LaboratoryInvestigationTest laboratoryInvestigationTest = new LaboratoryInvestigationTest();
                                //
                                //  laboratoryInvestigationTest.setResultId(result1.getId());


                            } catch (Exception e) {
                            }
                        }
                        if (methodCall.method.equals("savePostTest")) {
                            // TODO judge to add post test counselling code here
                            /*try {
                                PostTest postTest = gson.fromJson(arguments, PostTest.class);

                                ehrMobileDatabase.postTestDao().createPostTest(postTest);
                                System.out.println("List of postTest" + ehrMobileDatabase.postTestDao().listPostTest());
                            } catch (Exception e) {
                                System.out.println("something went wrong " + e.getMessage());
                            }*/
                        }


                        /* */

                        if (methodCall.method.equals("getSample")) {

                            try {
                                System.out.println("HERE ARE THE ARGUMENTS FROM FLUTTER " + arguments);
                                Hts hts = ehrMobileDatabase.htsDao().findHtsByPersonId(arguments);
                                System.out.println("HERE IS THE HTS MODEL" + hts.getPersonId());
                                Date htsregdate = hts.getDateOfHivTest();
                                PersonInvestigation personInvestigation = ehrMobileDatabase.personInvestigationDao().findByPersonIdAndDate(arguments, htsregdate.getTime());
                                System.out.println("HERE IS THE PERSON INVESTIGATION should be similar to hts " + personInvestigation.getPersonId());
                                Log.i(TAG, "Investigations : " + ehrMobileDatabase.investigationDao().getInvestigations());
                                Investigation investigation = ehrMobileDatabase.investigationDao().findByInvestigationId(personInvestigation.getInvestigationId());
                                Sample sample = ehrMobileDatabase.sampleDao().findBySampleId(investigation.getSampleId());
                                String sample_name = sample.getName();
                                Log.i(TAG, "YOUR SAMPLE NAME"+ sample_name);
                                result.success(sample_name);
                            } catch (Exception e) {
                                System.out.println("something went wrong " + e.getMessage());
                            }
                        }

                        if (methodCall.method.equals("getLabTest")) {

                            try {
                                Hts hts = ehrMobileDatabase.htsDao().findHtsByPersonId(arguments);
                                Date htsregdate = hts.getDateOfHivTest();
                                PersonInvestigation personInvestigation = ehrMobileDatabase.personInvestigationDao().findByPersonIdAndDate(arguments, htsregdate.getTime());
                                Log.i(TAG, "Investigations : " + ehrMobileDatabase.investigationDao().getInvestigations());
                                Investigation investigation = ehrMobileDatabase.investigationDao().findByInvestigationId(personInvestigation.getInvestigationId());
                                LaboratoryTest laboratoryTest = ehrMobileDatabase.laboratoryTestDao().findByLaboratoryTestId(investigation.getLaboratoryTestId());
                                String labtest_name = laboratoryTest.getName();
                                Log.i(TAG, "YOUR TEST NAME"+ labtest_name);
                                result.success(labtest_name);
                            } catch (Exception e) {
                                System.out.println("something went wrong " + e.getMessage());
                            }

                        }
                        if (methodCall.method.equals("getLabInvestigation")) {

                            try {

                                LaboratoryInvestigation laboratoryInvestigation = MainActivity.this.getLabInvestigation();
                                String labId = laboratoryInvestigation.getId();
                                System.out.println(" investigation***************" +
                                        labId);
                                Map<String, String> map = new HashMap<>();
                                //System.out.println("visitIdPatient = " + visitIdPatient);
                                System.out.println("labId = " + labId);
                                // TODO jduge to resolve hard coded value here
                                map.put("visitPatientId", "1");
                                map.put("labId", labId);
                                String mapData = gson.toJson(map);
                                result.success(mapData);
                            } catch (Exception e) {
                                System.out.println("something went wrong " + e.getMessage());
                            }
                        }

                        if (methodCall.method.equals("getTestKitsByLevel")) {

                            try {
                                String testKits;
                                int count = Integer.valueOf(arguments);
                                switch (count) {
                                    case 0: {
                                        List<TestKit> firstLevelTestKits = ehrMobileDatabase.testKitDao().findTestKitsByLevel("FIRST");
                                        testKits = gson.toJson(firstLevelTestKits);
                                        System.out.println("firstLevelTestKits = " + firstLevelTestKits);
                                        result.success(testKits);

                                    }
                                    break;

                                    case 1: {
                                        List<TestKit> secondLevelTestKits = ehrMobileDatabase.testKitDao().findTestKitsByLevel("SECOND");
                                        testKits = gson.toJson(secondLevelTestKits);
                                        result.success(testKits);

                                    }
                                    break;
                                    case 2: {
                                        List<TestKit> thirdLevelTestKits = ehrMobileDatabase.testKitDao().findTestKitsByLevel("THIRD");
                                        testKits = gson.toJson(thirdLevelTestKits);
                                        result.success(testKits);

                                    }
                                    break;
                                    default:
                                        throw new IllegalStateException("Cannot read" + arguments);
                                }

                            } catch (Exception e) {
                                System.out.println("something went wrong " + e.getMessage());
                            }
                        }

                        if (methodCall.method.equals("getSample")) {

                            try {
                                Investigation investigation = ehrMobileDatabase.investigationDao().findByInvestigationId("36069471-adee-11e7-b30f-3372a2d8551e");
                                System.out.println("arguments = " + arguments);


                                InvestigationEhr investigationEhr = new InvestigationEhr("36069471-adee-11e7-b30f-3372a2d8551e", "Blood", "HIV");
                                Sample sample = ehrMobileDatabase.sampleDao().findBySampleId(investigation.getSampleId());
                                String investigationString = gson.toJson(investigationEhr);
                                System.out.println(" investigation***************" + sample);
                                result.success(investigationString);
                            } catch (Exception e) {
                                System.out.println("something went wrong " + e.getMessage());
                            }
                        }

                    }
                });



        /*   ===============================================ART REGISTRATION AND INITIATION  =============================================================== */
        new MethodChannel(getFlutterView(), ART_CHANNEL).setMethodCallHandler(
                new MethodChannel.MethodCallHandler() {
                    @Override
                    public void onMethodCall(MethodCall methodCall, MethodChannel.Result result) {
                        String arguments = methodCall.arguments();
                        Gson gson = new GsonBuilder().registerTypeAdapter(Date.class, new DateDeserializer()).create();

        if (methodCall.method.equals("saveArtRegistration")) {

            ArtRegistration artRegistration = gson.fromJson(arguments, ArtRegistration.class);
            artRegistration.setId(UUID.randomUUID().toString());
            artRegistration.setPersonId(artRegistration.getPersonId());
            artRegistration.setDateOfEnrolmentIntoCare(artRegistration.getDateOfEnrolmentIntoCare());
            artRegistration.setDateOfHivTest(artRegistration.getDateOfHivTest());
            artRegistration.setOiArtNumber(artRegistration.getOiArtNumber());
            ehrMobileDatabase.artRegistrationDao().createArtRegistration(artRegistration);

            String artRegistrationFromDB= ehrMobileDatabase.artRegistrationDao().listArtRegistration().toString();

            System.out.println("Art from db :"+  artRegistrationFromDB);



        }

        else {
            result.notImplemented();
        }


        if (methodCall.method.equals("saveArtInitiation")) {

            ArtInitiation artInitiation = gson.fromJson(arguments, ArtInitiation.class);
            artInitiation.setId(UUID.randomUUID().toString());
            artInitiation.setPersonId(artInitiation.getPersonId());
            artInitiation.setArtRegimen(artInitiation.getArtRegimen());
            artInitiation.setClientEligibility(artInitiation.getClientEligibility());
            artInitiation.setDateInitiatedOnArt(artInitiation.getDateInitiatedOnArt());
            artInitiation.setDateOfEnrolmentIntoCare(artInitiation.getDateOfEnrolmentIntoCare());
            artInitiation.setClientType(artInitiation.getClientType());
            artInitiation.setLine(artInitiation.getLine());
            artInitiation.setReason(artInitiation.getReason());
            ehrMobileDatabase.artInitiationDao().createArtInitiation(artInitiation);

            String artInitiationFromDB= ehrMobileDatabase.artInitiationDao().listArtInitiation().toString();
            System.out.println("Art from db :"+  artInitiationFromDB);


        }

        else {
            result.notImplemented();
        }}});



    }


    private void pullData(Token token, String url) {
        getNationalities(token, url + "/api/");
        getFacilities(token, url + "/api/");
        getCountries(token, url + "/api/");
        getOccupation(token, url + "/api/");
        getMaritalStates(token, url + "/api/");
        getEducationLevels(token, url + "/api/");
        getReligion(token, url + "/api/");
        getEntryPoints(token, url + "/api/");
        getHtsModels(token, url + "/api/");
        getPurpose_Of_Tests(token, url + "/api/");
        getReasonForNotIssuingResults(token, url + "/api/");
        getUsers(token, url + "/api/");
        getTestKits(token, url + "/api/");
        getSample(token, url + "/api/");
        getLaboratoryTest(token, url + "/api/");
        getInvestigations(token, url + "/api/");
        getTowns(token, url + "/api/");
        getInvestigationResults(token, url + "/api/");
        getLaboratoryResults(token, url + "/api/");
        getPatients(url);

    }

    private void getPatients(String baseUrl) {
        ehrMobileDatabase.personDao().deleteAll();
        PatientsApolloClient.getPatientsFromEhr(ehrMobileDatabase, baseUrl);
    }

    public void getMaritalStates(Token token, String baseUrl) {

        DataSyncService service = RetrofitClient.getRetrofitInstance(baseUrl).create(DataSyncService.class);
        Call<TerminologyModel> call = service.getMaritalStates("Bearer " + token.getId_token());
        call.enqueue(new Callback<TerminologyModel>() {
            @Override
            public void onResponse(Call<TerminologyModel> call, Response<TerminologyModel> response) {
                List<MaritalStatus> maritalStatusList = new ArrayList<MaritalStatus>();
                if (response.isSuccessful()) {
                    for (BaseNameModel item : response.body().getContent()) {
                        maritalStatusList.add(new MaritalStatus(item.getCode(), item.getName()));
                    }
                    if (maritalStatusList != null && !maritalStatusList.isEmpty()) {
                        saveMaritalStatesToDB(maritalStatusList);
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
        Call<TerminologyModel> call = service.getOccupation("Bearer " + token.getId_token());
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
        Call<List<User>> call = service.getAllUsers("Bearer " + token.getId_token());

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

        Call<TerminologyModel> call = service.getFacilities("Bearer " + token.getId_token());
        call.enqueue(new Callback<TerminologyModel>() {
            @Override
            public void onResponse(Call<TerminologyModel> call, Response<TerminologyModel> response) {
                List<Facility> facilityList = new ArrayList<Facility>();
                for (BaseNameModel item : response.body().getContent()) {
                    facilityList.add(new Facility(item.getCode(), item.getName()));
                }
                if (facilityList != null && !facilityList.isEmpty()) {

                    saveFacilityToDB(facilityList);
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

    public void getTestKits(Token token, String url) {
        DataSyncService service = RetrofitClient.getRetrofitInstance(url).create(DataSyncService.class);
        //Call First Level Test Kits
        Call<List<TestKit>> call = service.getTestKits("Bearer " + token.getId_token(), "FIRST");

        call.enqueue(new Callback<List<TestKit>>() {
            @Override
            public void onResponse(Call<List<TestKit>> call, Response<List<TestKit>> response) {
                List<TestKit> testKits = new ArrayList<TestKit>();
                if (response.isSuccessful()) {
                    for (TestKit item : response.body()) {
                        testKits.add(new TestKit(item.getCode(), item.getName(), item.getDescription(), "FIRST"));
                    }


                    System.out.println("test kiiiiiiiiiiiiiits ==========" + testKits);

                    saveTestKitsToDB(testKits);

                } else {

                }
            }

            @Override
            public void onFailure(Call<List<TestKit>> call, Throwable t) {

            }
        });
        //Call All Second Level Test kits
        Call<List<TestKit>> callSecond = service.getTestKits("Bearer " + token.getId_token(), "SECOND");
        callSecond.enqueue(new Callback<List<TestKit>>() {
            @Override
            public void onResponse(Call<List<TestKit>> call, Response<List<TestKit>> response) {
                List<TestKit> secondTestKits = new ArrayList<TestKit>();
                if (response.isSuccessful()) {
                    for (TestKit item : response.body()) {
                        secondTestKits.add(new TestKit(item.getCode(), item.getName(), item.getDescription(), "SECOND"));
                    }

                    System.out.println("******Secondtest kiiiiiiiiiiiiiits ==========" + secondTestKits);
                    saveTestKitsToDB(secondTestKits);


                } else {

                }

            }

            @Override
            public void onFailure(Call<List<TestKit>> call, Throwable t) {

            }
        });
        //Call all Third Level Test Kits
        Call<List<TestKit>> callThird = service.getTestKits("Bearer " + token.getId_token(), "THIRD");
        callThird.enqueue(new Callback<List<TestKit>>() {
            @Override
            public void onResponse(Call<List<TestKit>> call, Response<List<TestKit>> response) {
                List<TestKit> thirdTestKits = new ArrayList<TestKit>();
                if (response.isSuccessful()) {
                    for (TestKit item : response.body()) {
                        thirdTestKits.add(new TestKit(item.getCode(), item.getName(), item.getDescription(), "THIRD"));
                    }

                    System.out.println("******Third test kiiiiiiiiiiiiiits ==========" + thirdTestKits);
                    saveTestKitsToDB(thirdTestKits);
                    System.out.println("All test kits$$$$$$$$$$$$$" + ehrMobileDatabase.testKitDao().getAllTestKits());

                } else {

                }

            }

            @Override
            public void onFailure(Call<List<TestKit>> call, Throwable t) {

            }
        });

    }


    public void getNationalities(Token token, String baseUrl) {

        DataSyncService service = RetrofitClient.getRetrofitInstance(baseUrl).create(DataSyncService.class);
        Call<TerminologyModel> call = service.getNationalities("Bearer " + token.getId_token());
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
        Call<TerminologyModel> call = service.getLaboratoryResults("Bearer " + token.getId_token());
        call.enqueue(new Callback<TerminologyModel>() {
            @Override
            public void onResponse(Call<TerminologyModel> call, Response<TerminologyModel> response) {
                List<Result> results = new ArrayList<Result>();
                Log.d(TAG, "999999999999999999999 " + response.body().getContent());
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

    public void getInvestigationResults(Token token, String baseUrl) {

        DataSyncService service = RetrofitClient.getRetrofitInstance(baseUrl).create(DataSyncService.class);
        Call<InvestigationResultModel> call = service.getInvestigationResults("Bearer " + token.getId_token());
        call.enqueue(new Callback<InvestigationResultModel>() {
            @Override
            public void onResponse(Call<InvestigationResultModel> call, Response<InvestigationResultModel> response) {
                List<Nationality> nationalities = new ArrayList<Nationality>();

                terminologyService.saveInvestiogationResultsToDB(response.body().getContent());
            }

            @Override
            public void onFailure(Call<InvestigationResultModel> call, Throwable t) {

            }
        });
    }


    public void getCountries(Token token, String baseUrl) {
        DataSyncService service = RetrofitClient.getRetrofitInstance(baseUrl).create(DataSyncService.class);

        Call<TerminologyModel> call = service.getCountries("Bearer " + token.getId_token());
        call.enqueue(new Callback<TerminologyModel>() {
            @Override
            public void onResponse(Call<TerminologyModel> call, Response<TerminologyModel> response) {
                List<Country> countries = new ArrayList<Country>();
                if (response.isSuccessful()) {
                    for (BaseNameModel item : response.body().getContent()) {
                        countries.add(new Country(item.getCode(), item.getName()));
                    }
                    if (!countries.isEmpty()) {
                        saveCountriesToDB(countries);
                    }
                }
            }

            @Override
            public void onFailure(Call<TerminologyModel> call, Throwable t) {

            }
        });


    }

    //Phineas
    public void getEducationLevels(Token token, String baseUrl) {

        DataSyncService service = RetrofitClient.getRetrofitInstance(baseUrl).create(DataSyncService.class);
        Call<TerminologyModel> call = service.getEducationLevels("Bearer " + token.getId_token());
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
        Call<TerminologyModel> call = service.getEntryPoints("Bearer " + token.getId_token());
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
        Call<TerminologyModel> call = service.getHtsModels("Bearer " + token.getId_token());
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

                System.out.println("tttttttttttttttttttttttt" + t);

            }
        });
    }


    public void getPurpose_Of_Tests(Token token, String baseUrl) {

        DataSyncService service = RetrofitClient.getRetrofitInstance(baseUrl).create(DataSyncService.class);
        Call<TerminologyModel> call = service.getHtsModels("Bearer " + token.getId_token());
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
        Call<TerminologyModel> call = service.getReasonForNotIssuingResults("Bearer " + token.getId_token());
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


    /**
     * Save to DB methods
     */

    void saveCountriesToDB(List<Country> countries) {


        ehrMobileDatabase.countryDao().insertCountries(countries);


        System.out.println("countries from DBBBBBBBBBBBBBB" + ehrMobileDatabase.countryDao().getAllCountries());
    }

    void saveMaritalStatesToDB(List<MaritalStatus> maritalStatuses) {


        ehrMobileDatabase.maritalStateDao().insertMaritalStates(maritalStatuses);

        System.out.println("marital states from DB #################" + ehrMobileDatabase.maritalStateDao().getAllMaritalStates());
    }

    void saveFacilityToDB(List<Facility> facilities) {

        ehrMobileDatabase.facilityDao().insertFacilities(facilities);

        System.out.println("facilities from DB #################" + ehrMobileDatabase.facilityDao().getAllFacilities());
    }


    public void getReligion(Token token, String baseUrl) {

        DataSyncService service = RetrofitClient.getRetrofitInstance(baseUrl).create(DataSyncService.class);
        Call<TerminologyModel> call = service.getReligion("Bearer " + token.getId_token());
        call.enqueue(new Callback<TerminologyModel>() {
            @Override
            public void onResponse(Call<TerminologyModel> call, Response<TerminologyModel> response) {
                List<Religion> religionList = new ArrayList<Religion>();
                for (BaseNameModel item : response.body().getContent()) {
                    religionList.add(new Religion(String.valueOf(item.getCode()), item.getName()));
                }
                if (religionList != null && !religionList.isEmpty()) {
                    terminologyService.saveReligionToDB(religionList);
                }
            }

            @Override
            public void onFailure(Call<TerminologyModel> call, Throwable t) {

                System.out.println("tttttttttttttttttttttttt" + t);
            }
        });
    }

    public void getTowns(Token token, String baseUrl) {
        DataSyncService service = RetrofitClient.getRetrofitInstance(baseUrl).create(DataSyncService.class);
        Call<TerminologyModel> call = service.getTowns("Bearer " + token.getId_token());
        call.enqueue(new Callback<TerminologyModel>() {
            @Override
            public void onResponse(Call<TerminologyModel> call, Response<TerminologyModel> response) {
                List<Town> townList = new ArrayList<Town>();
                for (BaseNameModel item : response.body().getContent()) {
                    townList.add(new Town(String.valueOf(item.getCode()), item.getName()));
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

        ehrMobileDatabase.personInvestigationDao().deletePersonInvestigations();
        ehrMobileDatabase.htsDao().deleteAll();
        ehrMobileDatabase.bloodPressureDao().deleteAll();
        ehrMobileDatabase.temperatureDao().deleteAll();
        ehrMobileDatabase.pulseDao().deleteAll();
        ehrMobileDatabase.respiratoryRateDao().deleteAll();
        ehrMobileDatabase.weightDao().deleteAll();
        ehrMobileDatabase.heightDao().deleteAll();
        ehrMobileDatabase.visitDao().deleteAll();
        ehrMobileDatabase.personDao().deleteAll();
        ehrMobileDatabase.countryDao().deleteCountries();
        ehrMobileDatabase.maritalStateDao().deleteMaritalStatuses();
        ehrMobileDatabase.facilityDao().deleteAllFacilities();
        ehrMobileDatabase.townsDao().deleteAllTowns();
        ehrMobileDatabase.religionDao().deleteReligions();
        ehrMobileDatabase.occupationDao().deleteOccupations();
        ehrMobileDatabase.nationalityDao().deleteNationalities();
        ehrMobileDatabase.educationLevelDao().deleteEducationLevels();
        ehrMobileDatabase.entryPointDao().deleteEntryPoints();
        ehrMobileDatabase.htsModelDao().deleteHtsModels();
        ehrMobileDatabase.purposeOfTestDao().deletePurposeOfTests();
        ehrMobileDatabase.reasonForNotIssuingResultDao().deleteReasonForNotIssuingResults();
        ehrMobileDatabase.userDao().deleteUsers();
        ehrMobileDatabase.testKitDao().deleteTestKits();
        ehrMobileDatabase.investigationDao().deleteInvestigations();
        ehrMobileDatabase.sampleDao().deleteSamples();
        ehrMobileDatabase.resultDao().deleteResults();
        ehrMobileDatabase.laboratoryTestDao().deleteLaboratoryTests();
        ehrMobileDatabase.artRegistrationDao().deleteAll();
        ehrMobileDatabase.artInitiationDao().deleteAll();
        ehrMobileDatabase.investigationResultDao().delete();
    }


    private void saveTestKitsToDB
            (List<TestKit> testKits) {
        ehrMobileDatabase.testKitDao().insertTestKits(testKits);
        int testKitsCount = ehrMobileDatabase.testKitDao().getAllTestKits().size();
        System.out.println("Test Kits *****" + testKitsCount);

    }

    public void getSample(Token token, String baseUrl) {

        DataSyncService service = RetrofitClient.getRetrofitInstance(baseUrl).create(DataSyncService.class);
        Call<TerminologyModel> call = service.getSamples("Bearer " + token.getId_token());
        call.enqueue(new Callback<TerminologyModel>() {
            @Override
            public void onResponse(Call<TerminologyModel> call, Response<TerminologyModel> response) {
                List<Sample> sampleList = new ArrayList<Sample>();
                for (BaseNameModel item : response.body().getContent()) {
                    sampleList.add(new Sample(String.valueOf(item.getCode()), item.getName()));
                }
                if (sampleList != null && !sampleList.isEmpty()) {
                    terminologyService.saveSample(sampleList);
                }
            }

            @Override
            public void onFailure(Call<TerminologyModel> call, Throwable t) {

                System.out.println("tttttttttttttttttttttttt" + t);
            }
        });
    }

    public void getLaboratoryTest(Token token, String
            baseUrl) {

        DataSyncService service = RetrofitClient.getRetrofitInstance(baseUrl).create(DataSyncService.class);
        Call<TerminologyModel> call = service.getLaboratoryTests("Bearer " + token.getId_token());
        call.enqueue(new Callback<TerminologyModel>() {
            @Override
            public void onResponse(Call<TerminologyModel> call, Response<TerminologyModel> response) {
                List<LaboratoryTest> laboratoryTestList = new ArrayList<LaboratoryTest>();
                for (BaseNameModel item : response.body().getContent()) {
                    laboratoryTestList.add(new LaboratoryTest(String.valueOf(item.getCode()), item.getName()));
                }
                if (laboratoryTestList != null && !laboratoryTestList.isEmpty()) {
                    terminologyService.saveLaboratoryTests(laboratoryTestList);
                }
            }

            @Override
            public void onFailure(Call<TerminologyModel> call, Throwable t) {

                System.out.println("tttttttttttttttttttttttt" + t);
            }
        });
    }

    public void getInvestigations(Token token, String
            baseUrl) {

        DataSyncService service = RetrofitClient.getRetrofitInstance(baseUrl).create(DataSyncService.class);
        Call<InvestigationModel> call = service.getInvestigations("Bearer " + token.getId_token());
        call.enqueue(new Callback<InvestigationModel>() {
            @Override
            public void onResponse(Call<InvestigationModel> call, Response<InvestigationModel> response) {
                List<Investigation> investigations = new ArrayList<Investigation>();
                for (InvestigationEhr item : response.body().getContent()) {
                    investigations.add(new Investigation(item.getInvestigationId(), item.getLaboratoryTestId(), item.getSampleId()));
                }
                Log.i(TAG, ";;;;;;;;;;;;;; investigations from ehr : " + investigations);
                System.out.println(TAG + ";;;;;;;;;;;;;; investigations from ehr : " + investigations);
                if (investigations != null && !investigations.isEmpty()) {
                    terminologyService.saveInvestigations(investigations);
                }
            }

            @Override
            public void onFailure(Call<InvestigationModel> call, Throwable t) {

                System.out.println("tttttttttttttttttttttttt" + t);
            }
        });
    }

    void saveLaboratoryTests(List<LaboratoryTest> tests) {


        System.out.println("^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^    " + ehrMobileDatabase);

        ehrMobileDatabase.laboratoryTestDao().insertLaboratoryTests(tests);

        System.out.println("samples from db #################" + ehrMobileDatabase.laboratoryTestDao().getLaboratoryTests());
    }

    void saveInvestigations
            (List<Investigation> investigations) {


        System.out.println("^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^    " + ehrMobileDatabase);

        ehrMobileDatabase.investigationDao().insertInvestigations(investigations);

        System.out.println("samples from db #################" + ehrMobileDatabase.investigationDao().getInvestigations());
    }

    /*@Transaction
    void htsRegistration(HtsRegistration htsRegistration) {
        saveHtsRegistration(htsRegistration);

    }

    void saveHtsRegistration(HtsRegistration htsRegistration) {
        try {
            ehrMobileDatabase.htsRegistrationDao().createHtsRegistration(htsRegistration);
            System.out.println("List of htsregistration" + ehrMobileDatabase.htsRegistrationDao().listHtsRegistration());

        } catch (Exception e) {

        }
    }*/

    void saveLaboratoryInvestigation(int personInvestigationId, LaboratoryInvestigationDTO laboratoryInvestigationDTO) {
        LaboratoryInvestigation laboratoryInvestigation = new LaboratoryInvestigation();
        //laboratoryInvestigation.setFacilityId(laboratoryInvestigationDTO.getFacilityId());
        laboratoryInvestigation.setResultDate(laboratoryInvestigationDTO.getResultDate());
        //laboratoryInvestigation.setPersonInvestigationId(personInvestigationId);
        ehrMobileDatabase.laboratoryInvestigationDao().createLaboratoryInvestigation(laboratoryInvestigation);
    }
}