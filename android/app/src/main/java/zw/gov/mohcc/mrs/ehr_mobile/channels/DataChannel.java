package zw.gov.mohcc.mrs.ehr_mobile.channels;

import com.google.gson.Gson;

import java.util.List;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.view.FlutterView;
import zw.gov.mohcc.mrs.ehr_mobile.model.terminology.ArtReason;
import zw.gov.mohcc.mrs.ehr_mobile.model.terminology.ArtStatus;
import zw.gov.mohcc.mrs.ehr_mobile.model.terminology.ArvCombinationRegimen;
import zw.gov.mohcc.mrs.ehr_mobile.model.terminology.Country;
import zw.gov.mohcc.mrs.ehr_mobile.model.terminology.DisclosureMethod;
import zw.gov.mohcc.mrs.ehr_mobile.model.terminology.EducationLevel;
import zw.gov.mohcc.mrs.ehr_mobile.model.terminology.EntryPoint;
import zw.gov.mohcc.mrs.ehr_mobile.model.terminology.MaritalStatus;
import zw.gov.mohcc.mrs.ehr_mobile.model.terminology.Nationality;
import zw.gov.mohcc.mrs.ehr_mobile.model.terminology.Occupation;
import zw.gov.mohcc.mrs.ehr_mobile.model.terminology.ReasonForNotIssuingResult;
import zw.gov.mohcc.mrs.ehr_mobile.model.terminology.Religion;
import zw.gov.mohcc.mrs.ehr_mobile.model.terminology.TestingPlan;
import zw.gov.mohcc.mrs.ehr_mobile.model.terminology.Town;
import zw.gov.mohcc.mrs.ehr_mobile.persistance.database.EhrMobileDatabase;

public class DataChannel {

    public DataChannel(FlutterView flutterView, String channelName, EhrMobileDatabase ehrMobileDatabase){
        new MethodChannel(flutterView, channelName).setMethodCallHandler(
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

                        if (methodCall1.method.equals("getArtReasonOptions")) {
                            try {
                                List<ArtReason> artReasons = ehrMobileDatabase.artReasonDao().findAll();
                                String list = gson.toJson(artReasons);
                                result1.success(list);
                            } catch (Exception e) {
                                System.out.println("something went wrong " + e.getMessage());

                            }
                        }

                        if (methodCall1.method.equals("getArtStatusOptions")) {
                            try {
                                List<ArtStatus> artStatuses = ehrMobileDatabase.artStatusDao().findAll();
                                String list = gson.toJson(artStatuses);
                                result1.success(list);
                            } catch (Exception e) {
                                System.out.println("something went wrong " + e.getMessage());

                            }
                        }

                        if (methodCall1.method.equals("getArvCombinationRegimenOptions")) {
                            try {
                                List<ArvCombinationRegimen> arvCombinationRegimens = ehrMobileDatabase.arvCombinationRegimenDao().findAll();
                                String list = gson.toJson(arvCombinationRegimens);
                                result1.success(list);
                            } catch (Exception e) {
                                System.out.println("something went wrong " + e.getMessage());

                            }
                        }
                        if (methodCall1.method.equals("getTestingPlan")) {
                            try {
                                List<TestingPlan> testingPlans = ehrMobileDatabase.testingPlanDao().findAll();
                                String list = gson.toJson(testingPlans);
                                result1.success(list);
                            } catch (Exception e) {
                                System.out.println("something went wrong " + e.getMessage());

                            }
                        }
                        if (methodCall1.method.equals("getdisclosuremethods")) {
                            try {
                                List<DisclosureMethod> disclosureMethods = ehrMobileDatabase.disclosureMethodDao().findAll();
                                String list = gson.toJson(disclosureMethods);
                                result1.success(list);
                            } catch (Exception e) {
                                System.out.println("something went wrong " + e.getMessage());

                            }
                        }
                        if(methodCall1.method.equals("getReasonForNotIssueingReasons")){
                            try{
                                List<ReasonForNotIssuingResult>reasonForNotIssuingResults = ehrMobileDatabase.reasonForNotIssuingResultDao().findAll();
                                String reasonslist = gson.toJson(reasonForNotIssuingResults);
                                result1.success(reasonslist);
                            }catch (Exception e){

                            }
                        }

                        if (methodCall1.method.equals("saveHtsRegistration")) {
                            // TODO judge to add code here useless comment
                            /*try {
                                HtsRegistration htsRegistration = gson.fromJson(arguments, HtsRegistration.class);
//                                ehrMobileDatabase.htsRegistrationDao().createHtsRegistration()
                            } catch (Exception e) {
                                System.out.println("something went wrong " + e.getMessage());

                            }*/
                        }

                    }
                });
    }
}
