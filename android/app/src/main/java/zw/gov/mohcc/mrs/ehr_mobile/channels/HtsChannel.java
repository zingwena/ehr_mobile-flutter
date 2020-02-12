package zw.gov.mohcc.mrs.ehr_mobile.channels;

import android.util.Log;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.view.FlutterView;
import zw.gov.mohcc.mrs.ehr_mobile.dto.ArtRegimenDto;
import zw.gov.mohcc.mrs.ehr_mobile.dto.HtsRegDTO;
import zw.gov.mohcc.mrs.ehr_mobile.dto.HtsScreeningDTO;
import zw.gov.mohcc.mrs.ehr_mobile.dto.LaboratoryInvestigationTestDTO;
import zw.gov.mohcc.mrs.ehr_mobile.dto.PostTestDTO;
import zw.gov.mohcc.mrs.ehr_mobile.dto.PreTestDTO;
import zw.gov.mohcc.mrs.ehr_mobile.dto.SexualHistoryDTO;
import zw.gov.mohcc.mrs.ehr_mobile.dto.SexualHistoryQuestionDTO;
import zw.gov.mohcc.mrs.ehr_mobile.dto.SexualHistoryQuestionView;
import zw.gov.mohcc.mrs.ehr_mobile.dto.TestKitBatchDto;
import zw.gov.mohcc.mrs.ehr_mobile.enumeration.RegimenType;
import zw.gov.mohcc.mrs.ehr_mobile.model.PatientQueue;
import zw.gov.mohcc.mrs.ehr_mobile.model.art.Art;
import zw.gov.mohcc.mrs.ehr_mobile.model.art.ArtCurrentStatus;
import zw.gov.mohcc.mrs.ehr_mobile.model.hts.Hts;
import zw.gov.mohcc.mrs.ehr_mobile.model.hts.IndexContact;
import zw.gov.mohcc.mrs.ehr_mobile.model.hts.IndexTest;
import zw.gov.mohcc.mrs.ehr_mobile.model.laboratory.LaboratoryInvestigation;
import zw.gov.mohcc.mrs.ehr_mobile.model.laboratory.LaboratoryInvestigationTest;
import zw.gov.mohcc.mrs.ehr_mobile.model.laboratory.PersonInvestigation;
import zw.gov.mohcc.mrs.ehr_mobile.model.person.Person;
import zw.gov.mohcc.mrs.ehr_mobile.model.terminology.ArvCombinationRegimen;
import zw.gov.mohcc.mrs.ehr_mobile.model.terminology.EntryPoint;
import zw.gov.mohcc.mrs.ehr_mobile.model.terminology.HtsModel;
import zw.gov.mohcc.mrs.ehr_mobile.model.terminology.Investigation;
import zw.gov.mohcc.mrs.ehr_mobile.model.terminology.InvestigationEhr;
import zw.gov.mohcc.mrs.ehr_mobile.model.terminology.LaboratoryTest;
import zw.gov.mohcc.mrs.ehr_mobile.model.terminology.PurposeOfTest;
import zw.gov.mohcc.mrs.ehr_mobile.model.terminology.ReasonForNotIssuingResult;
import zw.gov.mohcc.mrs.ehr_mobile.model.terminology.Result;
import zw.gov.mohcc.mrs.ehr_mobile.model.terminology.Sample;
import zw.gov.mohcc.mrs.ehr_mobile.model.warehouse.TestKitBatchIssue;
import zw.gov.mohcc.mrs.ehr_mobile.persistance.database.EhrMobileDatabase;
import zw.gov.mohcc.mrs.ehr_mobile.service.AppWideService;
import zw.gov.mohcc.mrs.ehr_mobile.service.ArtService;
import zw.gov.mohcc.mrs.ehr_mobile.service.HistoryService;
import zw.gov.mohcc.mrs.ehr_mobile.service.HtsService;
import zw.gov.mohcc.mrs.ehr_mobile.service.IndexTestingService;
import zw.gov.mohcc.mrs.ehr_mobile.util.DateDeserializer;
import zw.gov.mohcc.mrs.ehr_mobile.util.DateUtil;


public class HtsChannel {

    private final String TAG = "HTS Channel";

    public HtsChannel(FlutterView flutterView, String channelName, EhrMobileDatabase ehrMobileDatabase, HtsService htsService,
                      LaboratoryInvestigation laboratoryInvestigation, HistoryService historyService,
                      IndexTestingService indexTestingService, AppWideService appWideService, ArtService artService) {
        final String index_id;
        new MethodChannel(flutterView, channelName).setMethodCallHandler(
                new MethodChannel.MethodCallHandler() {
                    @Override
                    public void onMethodCall(MethodCall methodCall, MethodChannel.Result result) {
                        String arguments = methodCall.arguments();
                        Gson gson = new GsonBuilder().registerTypeAdapter(Date.class, new DateDeserializer()).create();
                        String indexTest_Id;

                        if (methodCall.method.equals("getLabInvestigation")) {
                            try {
                                LaboratoryInvestigation laboratoryInvestigation = htsService.getLaboratoryInvestigation(arguments);
                                String labINvestId = laboratoryInvestigation.getId();
                                result.success(labINvestId);
                            } catch (Exception e) {
                                System.out.println("Failed to get LaboratoryInvestigation" + e.getMessage());
                            }

                        }
                        if (methodCall.method.equals("getcurrenthts")) {

                            try {
                                Hts hts = htsService.getCurrentHts(arguments);
                                String htsjson = gson.toJson(hts);
                                Log.i(TAG, "HTS SCREENING MODEL" + htsjson);
                                result.success(htsjson);
                            } catch (Exception e) {
                                System.out.println("something went wrong " + e.getMessage());
                            }
                        }
                        if (methodCall.method.equals("getHtsId")) {
                            try {
                                Hts hts = ehrMobileDatabase.htsDao().findHtsByPersonId(arguments);
                                String hts_id = hts.getId();
                                result.success(hts_id);
                            } catch (Exception e) {
                                System.out.println("something went wrong " + e.getMessage());
                            }
                        }
                        if (methodCall.method.equals("htsModelOptions")) {
                            try {
                                List<HtsModel> htsModels = ehrMobileDatabase.htsModelDao().findAll();

                                String htsModelList = gson.toJson(htsModels);
                                result.success(htsModelList);
                            } catch (Exception e) {
                                System.out.println("something went wrong " + e.getMessage());
                            }
                        }
                        if (methodCall.method.equals("entrypointOptions")) {
                            try {
                                List<EntryPoint> entryPoints = ehrMobileDatabase.entryPointDao().findAll();
                                String entrypointList = gson.toJson(entryPoints);
                                result.success(entrypointList);
                            } catch (Exception e) {
                                System.out.println("something went wrong " + e.getMessage());
                            }
                        }
                        if (methodCall.method.equals("htsRegistration")) {
                            try {
                                Log.i(TAG, "HTS RECORD FROM FLUTTER" + arguments);
                                HtsRegDTO htsRegDTO = gson.fromJson(arguments, HtsRegDTO.class);
                                String htsId = htsService.createHts(htsRegDTO);
                                result.success(htsId);
                                Log.i(TAG, "HTS id to be sent back >>>>>>>>>" + htsId);

                            } catch (Exception e) {
                                System.out.println("something went wrong " + e.getMessage());

                            }

                        }
                        if (methodCall.method.equals("getHtsRegDetails")) {
                            try {
                                System.out.println("HTS HERE HERE HERE" + arguments);
                                Hts hts = ehrMobileDatabase.htsDao().findHtsById(arguments);
                                String htsjson = gson.toJson(hts);
                                result.success(htsjson);

                            } catch (Exception e) {
                                System.out.println("something went wrong " + e.getMessage());

                            }

                        }
                        if (methodCall.method.equals("getEntrypoint")) {
                            try {
                                EntryPoint entryPoint = ehrMobileDatabase.entryPointDao().findById(arguments);
                                String entrypoint_name = entryPoint.getName();
                                result.success(entrypoint_name);

                            } catch (Exception e) {
                                System.out.println("something went wrong " + e.getMessage());

                            }

                        }
                        if (methodCall.method.equals("getHtsModel")) {
                            try {
                                Log.i(TAG, "HTS MODEL ID HERE HERE HERE" + arguments);
                                HtsModel htsModel = ehrMobileDatabase.htsModelDao().findById(arguments);
                                String htsModelName = htsModel.getName();
                                result.success(htsModelName);

                            } catch (Exception e) {
                                System.out.println("something went wrong " + e.getMessage());

                            }

                        }


                        if (methodCall.method.equals("purposeOfTestsOptions")) {
                            try {
                                List<PurposeOfTest> purpose_of_tests = ehrMobileDatabase.purposeOfTestDao().findAll();
                                String purposeOfTestsList = gson.toJson(purpose_of_tests);
                                result.success(purposeOfTestsList);
                            } catch (Exception e) {
                                System.out.println("something went wrong " + e.getMessage());
                            }
                        }

                        if (methodCall.method.equals("reasonForNotIssuingResultOptions")) {

                            try {
                                List<ReasonForNotIssuingResult> reasonForNotIssuingResults = ehrMobileDatabase.reasonForNotIssuingResultDao().findAll();
                                String reasonForNotIssuingResultList = gson.toJson(reasonForNotIssuingResults);
                                result.success(reasonForNotIssuingResultList);
                            } catch (Exception e) {
                                System.out.println("something went wrong" + e.getMessage());
                            }
                        }

                        if (methodCall.method.equals("savePreTest")) {

                            try {

                                PreTestDTO preTestDTO = gson.fromJson(arguments, PreTestDTO.class);
                                Log.i(TAG, "PRETEST SENT FROM FLUTTER" + arguments);

                                Hts hts = htsService.savePreTestCounselling(preTestDTO);
                                Log.i(TAG, "PRETEST SENT TO AFTER SAVING FLUTTER" + hts);


                                result.success(gson.toJson(hts));

                            } catch (Exception e) {
                                System.out.println("something went wrong " + e.getMessage());

                            }
                        }
                        if (methodCall.method.equals("getHtsModel")) {
                            try {
                                HtsModel htsModel = ehrMobileDatabase.htsModelDao().findById(arguments);
                                Log.i(TAG, "HTS MODEL retrieved in android "+ htsModel.toString());


                                result.success(htsModel);
                            } catch (Exception e) {

                                System.out.println("something went wrong " + e.getMessage());
                            }
                        }
                        if (methodCall.method.equals("getPurposeofTest")) {
                            try {
                                PurposeOfTest purposeOfTest = ehrMobileDatabase.purposeOfTestDao().findById(arguments);
                                Log.i(TAG, "PUrpose retrieved in android "+ purposeOfTest.toString());

                                result.success(gson.toJson(purposeOfTest));
                            } catch (Exception e) {
                                System.out.println("something went wrong " + e.getMessage());
                            }
                        }
                        if (methodCall.method.equals("saveLabInvestTest")) {

                            try {
                                LaboratoryInvestigationTest labInvestTest = gson.fromJson(arguments, LaboratoryInvestigationTest.class);
                                Log.d(TAG, "Lab invest test passed to android ######### : " + labInvestTest.toString());
                                String labInvestigationTestId = htsService.processTestResults(labInvestTest);
                                result.success(labInvestigationTestId);
                            } catch (Exception e) {
                                System.out.println("something went wrong " + e.getMessage());
                            }
                        }
                        if (methodCall.method.equals("getLabInvestigations")) {
                            try {
                                Log.d(TAG, "Calling laboratory investigations with : &&&&&&&&&&&&&&&& : " + arguments);
                                List<LaboratoryInvestigationTest> laboratoryInvestigationTests = ehrMobileDatabase.labInvestTestdao().findAllByVisitId(arguments);
                                String list = gson.toJson(laboratoryInvestigationTests);
                                Log.d(TAG, "Laboratory investigations retrieved from sqlite : " + list);
                                result.success(list);
                            } catch (Exception e) {
                                System.out.println("something went wrong " + e.getMessage());

                            }
                        }

                        if (methodCall.method.equals("saveResult")) {
                            try {
                                // get variables
                                Result result1 = gson.fromJson(arguments, Result.class);
                                LaboratoryInvestigationTest laboratoryInvestigationTest = new LaboratoryInvestigationTest();
                                //
                                //  laboratoryInvestigationTest.setResultId(result1.getId());


                            } catch (Exception e) {
                            }
                        }
                        if (methodCall.method.equals("getFinalResult")) {
                            System.out.println("HERE IS THE FINAL RESULT METHOD and the arguments " + arguments);

                            try {
                                Log.i(TAG, "*************************** reching this point");
                                String resultId = htsService.getFinalResult(arguments);
                                Result result1 = ehrMobileDatabase.resultDao().findByName(resultId);
                                Log.i(TAG, "*************************** after first call : " + result1);
                                String result_name = result1 != null ? result1.getName() : "";
                                Log.d(TAG, "GGGGGGGGGGGGGGGGGGGGGGG FINAL RESULT + " + result_name);
                                result.success(result_name);


                            } catch (Exception e) {
                            }
                        }
                        if (methodCall.method.equals("savePostTest")) {

                            try {
                                PostTestDTO postTest = gson.fromJson(arguments, PostTestDTO.class);
                                Hts hts = htsService.savePostTestCounselling(postTest);

                                result.success(gson.toJson(hts));
                            } catch (Exception e) {
                                System.out.println("something went wrong " + e.getMessage());
                            }
                        }


                        /* */

                        if (methodCall.method.equals("getSample")) {

                            try {
                                System.out.println("HERE ARE THE ARGUMENTS FROM FLUTTER " + arguments);
                                Hts hts = ehrMobileDatabase.htsDao().findHtsByPersonId(arguments);
                                Date htsregdate = hts.getDateOfHivTest();
                                PersonInvestigation personInvestigation = ehrMobileDatabase.personInvestigationDao().findByPersonIdAndDate(arguments, htsregdate.getTime(), DateUtil.getEndOfDay(new Date()).getTime());
                                Log.i(TAG, "Investigations : " + ehrMobileDatabase.investigationDao().getInvestigations());
                                Investigation investigation = ehrMobileDatabase.investigationDao().findByInvestigationId(personInvestigation.getInvestigationId());
                                Sample sample = ehrMobileDatabase.sampleDao().findById(investigation.getSampleId());
                                String sample_name = sample.getName();
                                Log.i(TAG, "Here is the sample name to be returned >>>>>>>>>>>>>" + sample_name);
                                result.success(sample_name);
                            } catch (Exception e) {
                                System.out.println("something went wrong " + e.getMessage());
                            }
                        }
                        if (methodCall.method.equals("getRecencySample")) {

                            try {
                                Investigation investigation = ehrMobileDatabase.investigationDao().findByInvestigationId("ee7d91fc-b27f-11e8-b121-c48e8faf035b");
                                Sample sample = ehrMobileDatabase.sampleDao().findById(investigation.getSampleId());
                                String sample_name = sample.getName();
                                Log.i(TAG, "Recency sample name from android");
                                result.success(sample_name);
                            } catch (Exception e) {
                                System.out.println("something went wrong " + e.getMessage());
                            }
                        }
                        if (methodCall.method.equals("getRecencyInvestigation")) {

                            try {
                                System.out.println("HERE ARE THE ARGUMENTS FROM FLUTTER " + arguments);
                                Investigation investigation = ehrMobileDatabase.investigationDao().findByInvestigationId("ee7d91fc-b27f-11e8-b121-c48e8faf035b");
                                LaboratoryTest laboratoryTest = ehrMobileDatabase.laboratoryTestDao().findById(investigation.getLaboratoryTestId());
                                Log.i(TAG, "Laboratory test from android" + laboratoryTest.getName());
                                String investigation_name = laboratoryTest.getName();
                                result.success(investigation_name);
                            } catch (Exception e) {
                                System.out.println("something went wrong " + e.getMessage());
                            }
                        }

                        if (methodCall.method.equals("getTestResults")) {

                            try {
                                Hts hts = ehrMobileDatabase.htsDao().findHtsByPersonId(arguments);
                                Date htsregdate = hts.getDateOfHivTest();
                                PersonInvestigation personInvestigation = ehrMobileDatabase.personInvestigationDao().findByPersonIdAndDate(arguments, htsregdate.getTime(), DateUtil.getEndOfDay(new Date()).getTime());
                                List<Result> results = htsService.getInvestigationResults(personInvestigation.getInvestigationId());
                                String results_list = gson.toJson(results);
                                result.success(results_list);
                            } catch (Exception e) {
                                System.out.println("something went wrong " + e.getMessage());
                            }
                        }

                        if (methodCall.method.equals("getLabTest")) {

                            try {
                                Hts hts = ehrMobileDatabase.htsDao().findHtsByPersonId(arguments);
                                Date htsregdate = hts.getDateOfHivTest();
                                PersonInvestigation personInvestigation = ehrMobileDatabase.personInvestigationDao().findByPersonIdAndDate(arguments, htsregdate.getTime(), DateUtil.getEndOfDay(new Date()).getTime());
                                Investigation investigation = ehrMobileDatabase.investigationDao().findByInvestigationId(personInvestigation.getInvestigationId());
                                LaboratoryTest laboratoryTest = ehrMobileDatabase.laboratoryTestDao().findById(investigation.getLaboratoryTestId());
                                String labtest_name = laboratoryTest.getName();
                                result.success(labtest_name);
                            } catch (Exception e) {
                                System.out.println("something went wrong " + e.getMessage());
                            }

                        }
                        if (methodCall.method.equals("getPatientQueueOrWard")) {

                            try {
                                PatientQueue patientQueue = appWideService.getPatientQueue(arguments);
                                String binId = patientQueue.getQueue().getCode();
                                result.success(binId);

                            } catch (Exception e) {
                                System.out.println("something went wrong " + e.getMessage());
                            }

                        }
                        if (methodCall.method.equals("getTestKitBatches")) {

                            try {
                                TestKitBatchDto testKitBatchDto = gson.fromJson(arguments, TestKitBatchDto.class);
                                Log.d(TAG, "Entering method for retrieving testkit batches : " + testKitBatchDto);
                                List<TestKitBatchIssue> testKitBatchIssueList = htsService.getQueueOrWardTestKits(testKitBatchDto.getBinType(), testKitBatchDto.getBinId(), testKitBatchDto.getTestKitId());
                                Log.d(TAG, "Testkit batches retrieved : " + testKitBatchIssueList);
                                String testkitsbatchissues_string = gson.toJson(testKitBatchIssueList);
                                result.success(testkitsbatchissues_string);

                            } catch (Exception e) {
                                System.out.println("something went wrong " + e.getMessage());
                            }

                        }
                        if (methodCall.method.equals("getLabInvestigation")) {

                            try {

                                String labId = laboratoryInvestigation.getId();
                                Map<String, String> map = new HashMap<>();
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
                        if (methodCall.method.equals("getLabInvestigationTest")) {

                            try {

                                LaboratoryInvestigationTest laboratoryInvestigationTest = ehrMobileDatabase.labInvestTestdao().findByLaboratoryInvestId(arguments);
                                String labInvestTestId = laboratoryInvestigationTest.getId();
                                result.success(labInvestTestId);
                            } catch (Exception e) {
                                System.out.println("something went wrong " + e.getMessage());
                            }
                        }

                        if (methodCall.method.equals("getTestKitsByLevel")) {
                            try {
                                Log.d(TAG, "Arguments passed to get testkit : " + arguments);
                                String testkitlist = gson.toJson(htsService.getTestKitByTestLevel(arguments));
                                Log.d(TAG, "Testkits returned : " + testkitlist);
                                result.success(testkitlist);

                            } catch (Exception e) {
                                Log.d(TAG, "Exception thrown");
                            }

                        }
                        if (methodCall.method.equals("getRecencyTestkits")) {
                            try {
                                Log.d(TAG, "Arguments passed to get  Recency testkit : " + arguments);
                                String testkitlist = gson.toJson(htsService.getInvestigationTestKit("ee7d91fc-b27f-11e8-b121-c48e8faf035b"));
                                Log.d(TAG, "Testkits returned : " + testkitlist);
                                result.success(testkitlist);
                            } catch (Exception e) {
                                Log.d(TAG, "Exception thrown in getRecencyTestkits method");

                            }
                        }
                        if (methodCall.method.equals("getRecencySampleName")) {
                            try {
                                Log.d(TAG, "Arguments passed to get  Recency testkit : " + arguments);
                                String testkitlist = gson.toJson(htsService.getInvestigationTestKit("ee7d91fc-b27f-11e8-b121-c48e8faf035b"));
                                Log.d(TAG, "Testkits returned : " + testkitlist);
                                result.success(testkitlist);
                            } catch (Exception e) {
                                Log.d(TAG, "Exception thrown in getRecencyTestkits method");

                            }
                        }
                        if (methodCall.method.equals("getRecencyInvestigation")) {
                            try {
                                Log.d(TAG, "Arguments passed to get  Recency name : " + arguments);
                                String testkitlist = gson.toJson(htsService.getInvestigationTestKit("ee7d91fc-b27f-11e8-b121-c48e8faf035b"));
                                Log.d(TAG, "Testkits returned : " + testkitlist);
                                result.success(testkitlist);
                            } catch (Exception e) {
                                Log.d(TAG, "Exception thrown in getRecencyTestkits method");

                            }
                        }
                        if (methodCall.method.equals("getRecencyResults")) {
                            try {
                                Log.d(TAG, "Arguments passed to get testkit : " + arguments);
                                String resultsList = gson.toJson(htsService.getInvestigationResults("ee7d91fc-b27f-11e8-b121-c48e8faf035b"));
                                Log.d(TAG, "Results from recency returned : " + resultsList);
                                result.success(resultsList);
                            } catch (Exception e) {
                                Log.d(TAG, "Exception thrown in getRecencyResults method");

                            }
                        }
                        if (methodCall.method.equals("saveRecency")) {
                            try {
                                Log.d(TAG, "Agi HERE IS THE RECENCY LAB INVESTIGATION $$$$$$$$$$$$$$$$$ >>>>>>" + arguments);
                                LaboratoryInvestigationTestDTO laboratoryInvestigationTestDTO = gson.fromJson(arguments, LaboratoryInvestigationTestDTO.class);
                                Log.d(TAG, " RECENCY OBJECT AFTER ASSIGNMENT $$$$$$$$$$$$$$$$$ >>>>>> VISIT ID AND INVESTIGATION ID >>>>>>>>>>" + laboratoryInvestigationTestDTO.getInvestigationId() + ">>>>>>>>>>> VISIT ID >>>" + laboratoryInvestigationTestDTO.getVisitId());
                                String labinvestTestId = htsService.processOtherInvestigationResults(laboratoryInvestigationTestDTO);
                                result.success(labinvestTestId);

                            } catch (Exception e) {
                                Log.d(TAG, "Exception thrown in saveRecencyResults method " + e.getMessage());

                            }
                        }
                        if (methodCall.method.equals("getTestkitbycode")) {

                            try {
                                String testkit_name = ehrMobileDatabase.testKitDao().findById(arguments).getName();
                                result.success(testkit_name);

                            } catch (Exception e) {
                            }

                        }
                        if (methodCall.method.equals("getTestName")) {
                            try {
                                String name = htsService.getTestName(arguments);
                                result.success(name);

                            } catch (Exception e) {

                            }
                        }
                        if (methodCall.method.equals("getSample")) {

                            try {
                                Investigation investigation = ehrMobileDatabase.investigationDao().findByInvestigationId("36069471-adee-11e7-b30f-3372a2d8551e");
                                System.out.println("arguments = " + arguments);
                                InvestigationEhr investigationEhr = new InvestigationEhr("36069471-adee-11e7-b30f-3372a2d8551e", "Blood", "HIV");
                                Sample sample = ehrMobileDatabase.sampleDao().findById(investigation.getSampleId());
                                String investigationString = gson.toJson(investigationEhr);
                                result.success(investigationString);
                            } catch (Exception e) {
                                System.out.println("something went wrong " + e.getMessage());
                            }
                        }
                        if (methodCall.method.equals("getPatientStatus")) {
                            try {
                                boolean is_positive = htsService.getPersonHivStatus(arguments);
                                String status = gson.toJson(is_positive);
                                result.success(status);

                            } catch (Exception e) {

                            }
                        }
                        if (methodCall.method.equals("saveHtsScreening")) {
                            Log.i(TAG, "Save hts method in Android" + arguments);
                            try {
                                HtsScreeningDTO htsScreeningDTO = gson.fromJson(arguments, HtsScreeningDTO.class);
                                historyService.saveHtsScreening(htsScreeningDTO, appWideService.getCurrentVisit(htsScreeningDTO.getPersonId()));
                                result.success(1);
                            } catch (Exception e) {
                                Log.i(TAG, "Error occurred : " + e.getMessage());
                            }
                        }
                        if (methodCall.method.equals("getHtsScreening")) {
                            try {
                                String personId = arguments;
                                Log.d(TAG, "Person ID : " + personId);
                                String htsscreeningdto = gson.toJson(historyService.getHtsScreening(appWideService.getVisit(personId).getId()));
                                Log.i(TAG, "Retrieve Htsscreening from Android" + htsscreeningdto);
                                result.success(htsscreeningdto);
                            } catch (Exception e) {
                                Log.i(TAG, "Error occurred : " + e.getMessage());
                                e.printStackTrace();
                            }
                        }
                        if (methodCall.method.equals("saveSexualHistory")) {
                            try {
                                Log.i(TAG, "Sexual history dto from flutter" + arguments);
                                SexualHistoryDTO sexualHistoryDTO = gson.fromJson(arguments, SexualHistoryDTO.class);
                                String sexualHistoryId = historyService.saveSexualHistory(sexualHistoryDTO);
                                // SexualHistory sexualHistory = historyService.getSexualHistory(sexualHistoryDTO.getPersonId());
                                result.success(sexualHistoryId);

                            } catch (Exception e) {
                                Log.i(TAG, "Error occurred : " + e.getMessage());
                            }
                        }
                        if (methodCall.method.equals("getSexualHistory")) {
                            try {
                                String personId = arguments;
                                result.success(historyService.getSexualHistory(personId));

                            } catch (Exception e) {
                                Log.i(TAG, "Error occurred : " + e.getMessage());
                            }
                        }
                        if (methodCall.method.equals("getSexualHistoryViews")) {
                            try {
                                List<SexualHistoryQuestionView> sexualHistoryQuestionViews = historyService.getPatientSexualHistQuestions(arguments);
                                Log.i(TAG, "List of sexual history view returned" + sexualHistoryQuestionViews);
                                result.success(gson.toJson(sexualHistoryQuestionViews));
                            } catch (Exception e) {
                                Log.i(TAG, "Error occurred :" + e.getMessage());

                            }
                        }
                        if (methodCall.method.equals("saveIndexTest")) {
                            try {
                                IndexTest indexTest = gson.fromJson(arguments, IndexTest.class);
                                String indexTestId = indexTestingService.createIndexTest(indexTest);
                                result.success(indexTestId);

                            } catch (Exception e) {
                                Log.i(TAG, "Error occurred : " + e.getMessage());
                            }
                        }
                        if (methodCall.method.equals("getIndexTestByPersonId")) {
                            try {
                                Log.i(TAG, "Index argumets sent from flutter" + arguments);
                                IndexTest indexTest = indexTestingService.getIndexTestByPresonId(arguments);
                                String indexTestId = indexTest.getId();
                                result.success(indexTestId);

                            } catch (Exception e) {
                                Log.i(TAG, "Error occurred : " + e.getMessage());
                            }
                        }
                        if (methodCall.method.equals("getIndexContactList")) {

                            try {
                                List<IndexContact> indexContactList = indexTestingService.findIndexContactsByIndexTestId(arguments);
                                List<Person> contactlist = new ArrayList<>();
                                for (IndexContact indexContact : indexContactList) {
                                    Person person = ehrMobileDatabase.personDao().findPatientById(indexContact.getPersonId());
                                    contactlist.add(person);
                                }
                                String indexContacts = gson.toJson(contactlist);

                                result.success(indexContacts);

                            } catch (Exception e) {
                                Log.i(TAG, "Error occurred : " + e.getMessage());
                            }
                        }
                        if (methodCall.method.equals("saveSexualHistoryDto")) {
                            Log.i(TAG, " SEXUAL HISTORY DTO FROM FLUTTER" + arguments);
                            try {
                                SexualHistoryQuestionDTO sexualHistoryDTO = gson.fromJson(arguments, SexualHistoryQuestionDTO.class);
                                String sexualHistoryId = historyService.createSexualHistoryQuestion(sexualHistoryDTO);
                                result.success(sexualHistoryId);

                            } catch (Exception e) {
                                Log.i(TAG, "Error occurred : " + e.getMessage());

                            }
                        }
                        if (methodCall.method.equals("saveIndexContact")) {

                            try {
                                IndexContact indexContact = gson.fromJson(arguments, IndexContact.class);
                                Log.d(TAG, "@@@@@@@@@@@@@ Index contact sent from flutter " + arguments);
                               /* IndexContact indexContact = new IndexContact();
                                indexContact.setPersonId(indexContactDto.getPersonId());
                                indexContact.setDateOfHivStatus(indexContactDto.getDateOfHivStatus());
                                indexContact.setDisclosureMethodId(indexContactDto.getDisclosureMethodId());
                                indexContact.setDisclosureMethodPlanId(indexContactDto.getDisclosureMethodPlanId());
                                indexContact.setIndexTestId(indexContactDto.getIndexTestId());
                                indexContact.setFearOfIpv(indexContactDto.isFearOfIpv());
                                indexContact.setTestingPlanId(indexContact.getTestingPlanId());
                                indexContact.setRelation(indexContactDto.getRelation());
                                indexContact.setHivStatus(indexContactDto.getHivStatus());
                                System.out.println("PPPPPPPPPPPPPPPPPPPPPPPPPPPPP" + indexContact.toString());*/
                                String indexTestId = indexTestingService.createIndexContact(indexContact);
                                result.success(indexTestId);
                            } catch (Exception e) {
                                Log.i(TAG, "Error occurred : " + e.getMessage());
                            }
                        }
                        if (methodCall.method.equals("getArtRecord")) {

                            try {
                                Art art = ehrMobileDatabase.artDao().findByPersonId(arguments);
                                Log.i(TAG, "ART MODEL RETURNED FROM ANDROID" + art);
                                String artjson = gson.toJson(art);
                                Log.i(TAG, "ART REGISTRATION MODEL >>>>>>>>>>" + artjson);
                                result.success(artjson);
                            } catch (Exception e) {
                                System.out.println("something went wrong " + e.getMessage());
                            }
                        }
                        if (methodCall.method.equals("getArtInitiationRecord")) {

                            try {
                                ArtCurrentStatus artCurrentStatus = ehrMobileDatabase.artCurrentStatusDao().findByVisitId(arguments);
                                Log.i(TAG, "Art Initiation MODEL RETURNED FROM ANDROID" + artCurrentStatus);
                                String artjson = gson.toJson(artCurrentStatus);
                                Log.i(TAG, "ART INITIATION MODEL #################" + artjson);
                                result.success(artjson);
                            } catch (Exception e) {
                                System.out.println("something went wrong " + e.getMessage());
                            }
                        }
                        if (methodCall.method.equals("getPersonArvCombinationRegimens")) {
                            Log.i(TAG, "ARGUMENTS SENT FROM FLUTTER TO GET ART REGIMEN >>>>>" + arguments);

                            try {
                                ArtRegimenDto artRegimenDto = gson.fromJson(arguments, ArtRegimenDto.class);
                                String personId = artRegimenDto.getPersonId();
                                RegimenType regimenType = artRegimenDto.getLine();
                                List<ArvCombinationRegimen> arvCombinationRegimenList = artService.getPersonArvCombinationRegimens(personId, regimenType);
                                Log.i(TAG, "ARV COMB LIST RETURNED MODEL RETURNED FROM ANDROID" + arvCombinationRegimenList);
                                String artjson = gson.toJson(arvCombinationRegimenList);
                                result.success(artjson);
                            } catch (Exception e) {
                                System.out.println("something went wrong " + e.getMessage());
                            }
                        }
                        if (methodCall.method.equals("getArvCombinationRegimens")) {
                            Log.i(TAG, "ARGUMENTS SENT FROM FLUTTER TO GET ART REGIMEN >>>>>"+ arguments);

                            try {
                                List<ArvCombinationRegimen> arvCombinationRegimenList = artService.getArvCombinationRegimens(arguments);
                                Log.i(TAG, "ARV COMB LIST RETURNED MODEL RETURNED FROM ANDROID"+ arvCombinationRegimenList);
                                String artjson = gson.toJson(arvCombinationRegimenList);
                                result.success(artjson);
                            } catch (Exception e) {
                                System.out.println("something went wrong " + e.getMessage());
                            }
                        }

                    }
                });
    }
}
