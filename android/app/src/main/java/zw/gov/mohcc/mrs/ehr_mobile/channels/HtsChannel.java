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
import zw.gov.mohcc.mrs.ehr_mobile.dto.HtsRegDTO;
import zw.gov.mohcc.mrs.ehr_mobile.dto.HtsScreeningDTO;
import zw.gov.mohcc.mrs.ehr_mobile.dto.InvestigationDTO;
import zw.gov.mohcc.mrs.ehr_mobile.dto.LaboratoryInvestigationDTO;
import zw.gov.mohcc.mrs.ehr_mobile.dto.LaboratoryInvestigationTestDTO;
import zw.gov.mohcc.mrs.ehr_mobile.dto.PreTestDTO;
import zw.gov.mohcc.mrs.ehr_mobile.dto.SexualHistoryDTO;
import zw.gov.mohcc.mrs.ehr_mobile.model.terminology.EntryPoint;
import zw.gov.mohcc.mrs.ehr_mobile.model.hts.Hts;
import zw.gov.mohcc.mrs.ehr_mobile.model.terminology.HtsModel;
import zw.gov.mohcc.mrs.ehr_mobile.model.hts.IndexContact;
import zw.gov.mohcc.mrs.ehr_mobile.model.hts.IndexTest;
import zw.gov.mohcc.mrs.ehr_mobile.model.terminology.Investigation;
import zw.gov.mohcc.mrs.ehr_mobile.model.terminology.InvestigationEhr;
import zw.gov.mohcc.mrs.ehr_mobile.model.laboratory.LaboratoryInvestigation;
import zw.gov.mohcc.mrs.ehr_mobile.model.laboratory.LaboratoryInvestigationTest;
import zw.gov.mohcc.mrs.ehr_mobile.model.terminology.LaboratoryTest;
import zw.gov.mohcc.mrs.ehr_mobile.model.person.Person;
import zw.gov.mohcc.mrs.ehr_mobile.model.laboratory.PersonInvestigation;
import zw.gov.mohcc.mrs.ehr_mobile.model.terminology.PurposeOfTest;
import zw.gov.mohcc.mrs.ehr_mobile.model.terminology.ReasonForNotIssuingResult;
import zw.gov.mohcc.mrs.ehr_mobile.model.terminology.Result;
import zw.gov.mohcc.mrs.ehr_mobile.model.terminology.Sample;
import zw.gov.mohcc.mrs.ehr_mobile.persistance.database.EhrMobileDatabase;
import zw.gov.mohcc.mrs.ehr_mobile.service.HistoryService;
import zw.gov.mohcc.mrs.ehr_mobile.service.HtsService;
import zw.gov.mohcc.mrs.ehr_mobile.service.IndexTestingService;
import zw.gov.mohcc.mrs.ehr_mobile.service.VisitService;
import zw.gov.mohcc.mrs.ehr_mobile.util.DateDeserializer;
import zw.gov.mohcc.mrs.ehr_mobile.util.DateUtil;


public class HtsChannel {

    private final String TAG = "HTS Channel";

    public HtsChannel(FlutterView flutterView, String channelName, EhrMobileDatabase ehrMobileDatabase, HtsService htsService,
                      LaboratoryInvestigation laboratoryInvestigation, HistoryService historyService,
                      IndexTestingService indexTestingService, VisitService visitService) {
        final String index_id ;
        new MethodChannel(flutterView, channelName).setMethodCallHandler(
                new MethodChannel.MethodCallHandler() {
                    @Override
                    public void onMethodCall(MethodCall methodCall, MethodChannel.Result result) {
                        String arguments = methodCall.arguments();
                        Gson gson = new GsonBuilder().registerTypeAdapter(Date.class, new DateDeserializer()).create();
                        String indexTest_Id ;

                        if (methodCall.method.equals("getLabInvestigation")) {
                            try {
                                LaboratoryInvestigation laboratoryInvestigation = htsService.getLaboratoryInvestigation(arguments);
                                String labINvestId = laboratoryInvestigation.getId();
                                result.success(labINvestId);
                            } catch (Exception e) {
                                System.out.println("something went wrong " + e.getMessage());
                            }

                        }
                        if (methodCall.method.equals("getcurrenthts")) {

                            try {
                                Hts hts = htsService.getCurrentHts(arguments);
                                String htsjson = gson.toJson(hts);
                                Log.i(TAG, "HTS SCREENING MODEL"+ htsjson);
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
                                result.success(htsjson);

                            } catch (Exception e) {
                                System.out.println("something went wrong " + e.getMessage());

                            }

                        }
                        if (methodCall.method.equals("getEntrypoint")) {
                            try {
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
                                Hts hts = ehrMobileDatabase.htsDao().findHtsById(preTestDTO.getHts_id());
                                hts.setHtsApproach(preTestDTO.getHtsApproach());
                                hts.setNewTestInClientLife(preTestDTO.getNewTest());
                                hts.setNewTestPregLact(preTestDTO.getNewTestPregLact());
                                hts.setCoupleCounselling(preTestDTO.getCoupleCounselling());
                                hts.setOptOutOfTest(preTestDTO.getOptOutOfTest());
                                hts.setPreTestInformationGiven(preTestDTO.getPreTestInfoGiven());
                                System.out.println("JJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJ  ISPREFINFO GIVEN" + hts.isPreTestInformationGiven());
                                hts.setHtsModelId(preTestDTO.getHtsModel_id());
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
                                System.out.println("HHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHH LAB INVEST TEST SAVED" + arguments);
                                LaboratoryInvestigationTest labInvestTest = gson.fromJson(arguments, LaboratoryInvestigationTest.class);
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
                                Result result1 = ehrMobileDatabase.resultDao().findByResultId(resultId);
                                Log.i(TAG, "*************************** after first call : " + result1);
                                String result_name = result1 != null ? result1.getName() : "";
                                Log.d(TAG, "GGGGGGGGGGGGGGGGGGGGGGG FINAL RESULT + " + result_name);
                                result.success(result_name);


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
                                PersonInvestigation personInvestigation = ehrMobileDatabase.personInvestigationDao().findByPersonIdAndDate(arguments, htsregdate.getTime(), DateUtil.getEndOfDay(new Date()).getTime());
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
                                LaboratoryTest laboratoryTest = ehrMobileDatabase.laboratoryTestDao().findByLaboratoryTestId(investigation.getLaboratoryTestId());
                                String labtest_name = laboratoryTest.getName();
                                result.success(labtest_name);
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
                        if(methodCall.method.equals("getRecencyTestkits")){
                            try{
                                Log.d(TAG, "Arguments passed to get  Recency testkit : " + arguments);
                                String testkitlist = gson.toJson(htsService.getInvestigationTestKit("ee7d91fc-b27f-11e8-b121-c48e8faf035b"));
                                Log.d(TAG, "Testkits returned : " + testkitlist);
                                result.success(testkitlist);
                            }catch (Exception e){
                                Log.d(TAG, "Exception thrown in getRecencyTestkits method");

                            }
                        }
                        if(methodCall.method.equals("getRecencyResults")){
                            try{
                                Log.d(TAG, "Arguments passed to get testkit : " + arguments);
                                String resultsList = gson.toJson(htsService.getInvestigationResults("ee7d91fc-b27f-11e8-b121-c48e8faf035b"));
                                Log.d(TAG, "Results from recency returned : " + resultsList);
                                result.success(resultsList);
                            }catch (Exception e){
                                Log.d(TAG, "Exception thrown in getRecencyResults method");

                            }
                        }
                        if(methodCall.method.equals("saveRecency")){
                            try{
                                Log.d(TAG, "Agi " + arguments);
                                LaboratoryInvestigationTestDTO laboratoryInvestigationTestDTO = gson.fromJson(arguments, LaboratoryInvestigationTestDTO.class);
                                String labinvestTestId = htsService.processOtherInvestigationResults(laboratoryInvestigationTestDTO);
                                result.success(labinvestTestId);

                            }catch (Exception e){
                                Log.d(TAG, "Exception thrown in getRecencyResults method");

                            }
                        }
                        if (methodCall.method.equals("getTestkitbycode")) {

                            try {
                                String testkit_name = ehrMobileDatabase.testKitDao().findTestKitById(arguments).getName();
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
                                Sample sample = ehrMobileDatabase.sampleDao().findBySampleId(investigation.getSampleId());
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
                                historyService.saveHtsScreening(htsScreeningDTO, visitService.getCurrentVisit(htsScreeningDTO.getPersonId()));
                                result.success(1);
                            } catch (Exception e) {
                                Log.i(TAG, "Error occurred : " + e.getMessage());
                            }
                        }
                        if (methodCall.method.equals("getHtsScreening")) {
                            try {
                                String personId = arguments;
                                String htsscreeningdto = gson.toJson(historyService.getHtsScreening(visitService.getVisit(personId).getId()));
                                Log.i(TAG, "Retrieve Htsscreening from Android" + htsscreeningdto);
                                result.success(htsscreeningdto);
                            } catch (Exception e) {
                                Log.i(TAG, "Error occurred : " + e.getMessage());
                            }
                        }
                        if (methodCall.method.equals("saveSexualHistory")) {
                            try {
                                SexualHistoryDTO sexualHistoryDTO = gson.fromJson(arguments, SexualHistoryDTO.class);
                                historyService.saveSexualHistory(sexualHistoryDTO);
                                // SexualHistory sexualHistory = historyService.getSexualHistory(sexualHistoryDTO.getPersonId());
                                result.success(1);

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
                        if(methodCall.method.equals("saveIndexTest")){
                            try{
                                IndexTest indexTest = gson.fromJson(arguments, IndexTest.class);
                                String indexTestId =  indexTestingService.createIndexTest(indexTest);
                                result.success(indexTestId);

                            }catch (Exception e){
                                Log.i(TAG, "Error occurred : " + e.getMessage());
                            }
                        }
                        if(methodCall.method.equals("getIndexContactList")){
                            System.out.println("UUUUUUUUUUUUUUUUUUUUUUU index id in get contactlist"+ arguments);
                            try{
                                List<IndexContact> indexContactList = indexTestingService.findIndexContactsByIndexTestId(arguments);
                                List<Person>contactlist = new ArrayList<>();
                                for( IndexContact indexContact : indexContactList){
                                    Person person = ehrMobileDatabase.personDao().findPatientById(indexContact.getPersonId());
                                    contactlist.add(person);
                                }
                                String indexContacts = gson.toJson(contactlist);
                                System.out.println("DDDDDDDDDDDDDDDDDDDD INDEX CONTACTS"+ indexContacts);
                                result.success(indexContacts);

                            }catch (Exception e){
                                Log.i(TAG, "Error occurred : " + e.getMessage());
                            }
                        }
                        if(methodCall.method.equals("saveIndexContact")){
                            System.out.println("JJJJJJJJJJJJJJJJJJ INDEX CONTACT FROM FLUTTER "+ arguments );
                            try{
                                IndexContact indexContact = gson.fromJson(arguments, IndexContact.class);
                                System.out.println("KKKKKKKKKKKKKKKKKKKKKKKKKK index contact dto"+ indexContact.toString());
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
                                String indexTestId =  indexTestingService.createIndexContact(indexContact);
                                result.success(indexTestId);
                            }catch (Exception e){
                                Log.i(TAG, "Error occurred : " + e.getMessage());
                            }
                        }

                    }
                });
    }
}
