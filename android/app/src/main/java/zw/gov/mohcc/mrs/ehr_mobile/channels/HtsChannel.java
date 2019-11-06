package zw.gov.mohcc.mrs.ehr_mobile.channels;

import android.util.Log;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.view.FlutterView;
import zw.gov.mohcc.mrs.ehr_mobile.dto.HtsRegDTO;
import zw.gov.mohcc.mrs.ehr_mobile.dto.PreTestDTO;
import zw.gov.mohcc.mrs.ehr_mobile.model.EntryPoint;
import zw.gov.mohcc.mrs.ehr_mobile.model.Hts;
import zw.gov.mohcc.mrs.ehr_mobile.model.HtsModel;
import zw.gov.mohcc.mrs.ehr_mobile.model.Investigation;
import zw.gov.mohcc.mrs.ehr_mobile.model.InvestigationEhr;
import zw.gov.mohcc.mrs.ehr_mobile.model.LaboratoryInvestigation;
import zw.gov.mohcc.mrs.ehr_mobile.model.LaboratoryInvestigationTest;
import zw.gov.mohcc.mrs.ehr_mobile.model.LaboratoryTest;
import zw.gov.mohcc.mrs.ehr_mobile.model.PersonInvestigation;
import zw.gov.mohcc.mrs.ehr_mobile.model.PurposeOfTest;
import zw.gov.mohcc.mrs.ehr_mobile.model.ReasonForNotIssuingResult;
import zw.gov.mohcc.mrs.ehr_mobile.model.Result;
import zw.gov.mohcc.mrs.ehr_mobile.model.Sample;
import zw.gov.mohcc.mrs.ehr_mobile.model.TestKit;
import zw.gov.mohcc.mrs.ehr_mobile.persistance.database.EhrMobileDatabase;
import zw.gov.mohcc.mrs.ehr_mobile.service.HtsService;
import zw.gov.mohcc.mrs.ehr_mobile.util.DateDeserializer;

import static com.tekartik.sqflite.Constant.TAG;

public class HtsChannel {

    public HtsChannel(FlutterView flutterView, String channelName, EhrMobileDatabase ehrMobileDatabase, HtsService htsService,LaboratoryInvestigation laboratoryInvestigation){
        new MethodChannel(flutterView, channelName).setMethodCallHandler(
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
                        if (methodCall.method.equals("getcurrenthts")) {
                            Log.i(TAG, " CURRENT HTS MODEL : " );

                            try {
                                Hts hts = htsService.getCurrentHts(arguments);
                                System.out.println(">>>>>>>>>>>>>>>>>>>> HTS FROM ANDROID"+ hts);
                                result.success(hts);
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
                                List<HtsModel> htsModels = ehrMobileDatabase.htsModelDao().getAllHtsModels();

                                String htsModelList = gson.toJson(htsModels);
                                result.success(htsModelList);
                            } catch (Exception e) {
                                System.out.println("something went wrong " + e.getMessage());
                            }
                        }
                        if (methodCall.method.equals("entrypointOptions")) {
                            try {
                                List<EntryPoint> entryPoints = ehrMobileDatabase.entryPointDao().getAllEntryPoints();
                                String entrypointList = gson.toJson(entryPoints);
                                result.success(entrypointList);
                            } catch (Exception e) {
                                System.out.println("something went wrong " + e.getMessage());
                            }
                        }
                        if (methodCall.method.equals("htsRegistration")) {
                            try {
                                HtsRegDTO htsRegDTO = gson.fromJson(arguments, HtsRegDTO.class);
                                result.success(htsService.createHts(htsRegDTO));

                            } catch (Exception e) {
                                System.out.println("something went wrong " + e.getMessage());

                            }

                        }
                        if (methodCall.method.equals("getHtsRegDetails")) {
                            try {
                                System.out.println("HTS HERE HERE HERE" + arguments);
                                Hts hts = ehrMobileDatabase.htsDao().findHtsById(arguments);
                                String htsjson = gson.toJson(hts);
                                System.out.println("HTS REGISTRATION TO JSON >>>>>>>>"+ htsjson);
                                result.success(htsjson);

                            } catch (Exception e) {
                                System.out.println("something went wrong " + e.getMessage());

                            }

                        }
                        if (methodCall.method.equals("getEntrypoint")) {
                            try {
                                System.out.println("HTS HERE HERE HERE" + arguments);
                                EntryPoint entryPoint = ehrMobileDatabase.entryPointDao().findEntryPointById(arguments);
                                String entrypoint_name = entryPoint.getName();
                                result.success(entrypoint_name);

                            } catch (Exception e) {
                                System.out.println("something went wrong " + e.getMessage());

                            }

                        }
                        if (methodCall.method.equals("getHtsModel")) {
                            try {
                                System.out.println("HTS MODEL ID HERE HERE HERE" + arguments);
                                HtsModel htsModel = ehrMobileDatabase.htsModelDao().findHtsModelById(arguments);
                                String htsModelName = htsModel.getName();
                                System.out.print("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"+ htsModelName);
                                result.success(htsModelName);

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
                                Hts hts1 = ehrMobileDatabase.htsDao().findHtsById(hts.getId());
                                String htsjson = gson.toJson(hts1);
                                result.success(htsjson);


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
                                String labInvetTestId = laboratoryInvestigationTest.getId();
                                result.success(labInvetTestId);
                            } catch (Exception e) {
                                System.out.println("something went wrong " + e.getMessage());
                            }
                        }
                        if (methodCall.method.equals("getLabInvestigations")) {
                            try {
                                System.out.println("GGGGGGGGGGGGG" +arguments);
                                List<LaboratoryInvestigationTest> laboratoryInvestigationTests = ehrMobileDatabase.labInvestTestdao().findAllByVisitId(arguments);
                                String list = gson.toJson(laboratoryInvestigationTests);
                                result.success(list);
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
                                Date htsregdate = hts.getDateOfHivTest();
                                PersonInvestigation personInvestigation = ehrMobileDatabase.personInvestigationDao().findByPersonIdAndDate(arguments, htsregdate.getTime());
                                Log.i(TAG, "Investigations : " + ehrMobileDatabase.investigationDao().getInvestigations());
                                Investigation investigation = ehrMobileDatabase.investigationDao().findByInvestigationId(personInvestigation.getInvestigationId());
                                Sample sample = ehrMobileDatabase.sampleDao().findBySampleId(investigation.getSampleId());
                                String sample_name = sample.getName();

                                result.success(sample_name);
                            } catch (Exception e) {
                                System.out.println("something went wrong " + e.getMessage());
                            }
                        }

                        if (methodCall.method.equals("getTestResults")) {

                            try {
                                Hts hts = ehrMobileDatabase.htsDao().findHtsByPersonId(arguments);
                                Date htsregdate = hts.getDateOfHivTest();
                                PersonInvestigation personInvestigation = ehrMobileDatabase.personInvestigationDao().findByPersonIdAndDate(arguments, htsregdate.getTime());
                                List<Result>results = htsService.getInvestigationResults(personInvestigation.getInvestigationId());
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
                                PersonInvestigation personInvestigation = ehrMobileDatabase.personInvestigationDao().findByPersonIdAndDate(arguments, htsregdate.getTime());
                                Investigation investigation = ehrMobileDatabase.investigationDao().findByInvestigationId(personInvestigation.getInvestigationId());
                                LaboratoryTest laboratoryTest = ehrMobileDatabase.laboratoryTestDao().findByLaboratoryTestId(investigation.getLaboratoryTestId());
                                String labtest_name = laboratoryTest.getName();
                                result.success(labtest_name);
                            } catch (Exception e) {
                                System.out.println("something went wrong " + e.getMessage());
                            }

                        }
                        if (methodCall.method.equals("getLabInvestigation")) {

                            try {
                                //LaboratoryInvestigation laboratoryInvestigation = MainActivity.this.getLabInvestigation();
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
                                result.success(investigationString);
                            } catch (Exception e) {
                                System.out.println("something went wrong " + e.getMessage());
                            }
                        }

                    }
                });
    }
}
