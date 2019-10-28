package zw.gov.mohcc.mrs.ehr_mobile.service;

import android.util.Log;

import androidx.room.Transaction;

import org.apache.commons.lang3.StringUtils;

import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;
import java.util.UUID;

import zw.gov.mohcc.mrs.ehr_mobile.dto.HtsRegDTO;
import zw.gov.mohcc.mrs.ehr_mobile.model.Hts;
import zw.gov.mohcc.mrs.ehr_mobile.model.LaboratoryInvestigation;
import zw.gov.mohcc.mrs.ehr_mobile.model.LaboratoryInvestigationTest;
import zw.gov.mohcc.mrs.ehr_mobile.model.PersonInvestigation;
import zw.gov.mohcc.mrs.ehr_mobile.model.Result;
import zw.gov.mohcc.mrs.ehr_mobile.model.TestKit;
import zw.gov.mohcc.mrs.ehr_mobile.model.vitals.Visit;
import zw.gov.mohcc.mrs.ehr_mobile.persistance.database.EhrMobileDatabase;
import zw.gov.mohcc.mrs.ehr_mobile.util.DateUtil;

public class HtsService {

    private final String TAG = "Hts Service";
    private EhrMobileDatabase ehrMobileDatabase;
    private VisitService visitService;

    public HtsService(EhrMobileDatabase ehrMobileDatabase, VisitService visitService) {
        this.ehrMobileDatabase = ehrMobileDatabase;
        this.visitService = visitService;
    }

    @Transaction
    public String createHts(HtsRegDTO dto) {

        String visitId = visitService.getCurrentVisit(dto.getPersonId());
        Log.i(TAG, "Retrieving or creating current visit : "+ visitId);

        Log.i(TAG, "Creating HTS record");
        Hts hts = HtsRegDTO.getInstance(dto, visitId);
        ehrMobileDatabase.htsDao().createHts(hts);
        Log.i(TAG, "Created hts record : " + ehrMobileDatabase.htsDao().findHtsById(hts.getId()));
        Log.i(TAG, "Creating Person Investigation record");
        String personInvestigationId = UUID.randomUUID().toString();
        PersonInvestigation personInvestigation = new PersonInvestigation(personInvestigationId, dto.getPersonId(),
                "36069471-adee-11e7-b30f-3372a2d8551e", dto.getDateOfHivTest());
        ehrMobileDatabase.personInvestigationDao().insertPersonInvestigation(personInvestigation);
        Log.i(TAG, "Saved person investigation record : " + ehrMobileDatabase.personInvestigationDao().findPersonInvestigationById(personInvestigationId));
        Log.i(TAG, "Creating laboratory investigation record");
        String laboratoryInvestigationId = UUID.randomUUID().toString();
        LaboratoryInvestigation laboratoryInvestigation = new LaboratoryInvestigation(laboratoryInvestigationId, "ZW000A01", personInvestigationId);
        ehrMobileDatabase.laboratoryInvestigationDao().createLaboratoryInvestigation(laboratoryInvestigation);
        Log.d(TAG, "Created laboratory investigation : " + ehrMobileDatabase.laboratoryInvestigationDao().findLaboratoryInvestigationById(laboratoryInvestigationId));
        return hts.getId();
    }
    /**
     * @param investigationId
     * @return list of results
     */
    public List<Result> getInvestigationResults(String investigationId) {
        return ehrMobileDatabase.resultDao().findByResultId(
                ehrMobileDatabase.investigationResultDao().findByInvestigationId(investigationId)
        );
    }

    public Hts getCurrentHts(String personId) {
        Visit visit = visitService.getVisit(personId);
        // check if patient has current hts record
        if (visit != null) {
            return ehrMobileDatabase.htsDao().findCurrentHts(visit.getId());
        }
        return null;
    }

    private int getTestCount(String laboratoryInvestigationId) {
        return ehrMobileDatabase.labInvestTestdao().countByLaboratoryInvestigation(laboratoryInvestigationId);
    }

    private String getTestLevel(int count) {
        switch (count) {
            case 0:
                return "FIRST";
            case 1:
                return "SECOND";
            case 2:
                return "PARALLEL_ONE";
            case 3:
                return "PARALLEL_TWO";
            case 4:
                return "THIRD";
            default:
                throw new IllegalStateException("Illegal parameter passed to method : "+ count);
        }
    }

    private List<String> getFirstTwoTestKits(String laboratoryInvestigationId, int maxCount) {
        List<String> testKitIds = new ArrayList<>();
        Log.i(TAG, "Current investigation tests : "+ ehrMobileDatabase.labInvestTestdao().findEarliestTests(laboratoryInvestigationId).toString());
        for (LaboratoryInvestigationTest item : ehrMobileDatabase.labInvestTestdao().findEarliestTests(laboratoryInvestigationId)) {
            if (maxCount > 0) {
                // get testkit ID using name
                TestKit testKit = ehrMobileDatabase.testKitDao().findTestKitByName(item.getTestkitId());
                Log.i(TAG, "Test kit retreived : "+ testKit + " testkit name :"+ item.getTestkitId());
                testKitIds.add(testKit.getCode());
            } else {
                break;
            }
            maxCount--;
        }
        Log.i(TAG, "Retrieved test kit ids : %%%%%%%%%%%%%%%%%%%%%%%%%%%%% : "+ testKitIds.toString());
        return testKitIds;
    }

    public String getTestName(String laboratoryInvestigationId) {
        int count = getTestCount(laboratoryInvestigationId);
        switch (count) {
            case 0:
                return "Screening Test";
            case 1:
                return "Confirmatory Test";
            case 2:
                return "Parallel Test 1";
            case 3:
                return "Parallel Test 2";
            case 4:
                return "Third Test";
            default:
                throw new IllegalStateException("Illegal parameter passed to method : "+ count);
        }
    }

    public LaboratoryInvestigation getLaboratoryInvestigation(String personId) {

        PersonInvestigation personInvestigation = ehrMobileDatabase.personInvestigationDao().findByPersonId(personId);
        return ehrMobileDatabase.laboratoryInvestigationDao().findByPersonInvestigationId(personInvestigation.getId());
    }

    public Set<TestKit> getTestKitByTestLevel(String laboratoryInvestigationId) {
        int count = getTestCount(laboratoryInvestigationId);
        String level = getTestLevel(count);
        Log.i(TAG, "Laboratory Investigation ID : " + laboratoryInvestigationId);
        Log.i(TAG, "All laboratory investigations : ");
        Log.i(TAG, ehrMobileDatabase.laboratoryInvestigationDao().getAllLaboratoryInvestigations().toString());
        Log.i(TAG, "Retrieving test kits count is at : "+ count +" Using level : "+ level);
        Log.i(TAG, "All laboratory investigation tests : ");
        Log.i(TAG, ehrMobileDatabase.labInvestTestdao().findAll().toString());
        if (count == 0 || count == 1 || count == 4) {
            return new HashSet<>(ehrMobileDatabase.testKitDao().findTestKitsByLevel(level));
        } else if (count == 2) {
            return new HashSet<>(ehrMobileDatabase.testKitDao().findTestKitIdsIn(getFirstTwoTestKits(laboratoryInvestigationId, 2)));
        } else if (count == 3) {
            return new HashSet<>(ehrMobileDatabase.testKitDao().findTestKitIdsIn(getFirstTwoTestKits(laboratoryInvestigationId, 2)));
        }
        return null;
    }

    public String getFinalResult(String laboratoryInvestigationId) {

        LaboratoryInvestigation laboratoryInvestigation =
                ehrMobileDatabase.laboratoryInvestigationDao().findLaboratoryInvestigationById(laboratoryInvestigationId);

        PersonInvestigation personInvestigation = ehrMobileDatabase.personInvestigationDao()
                .findPersonInvestigationById(laboratoryInvestigation.getPersonInvestigationId());

        return  personInvestigation.getResultId();
    }

    @Transaction
    public String processTestResults(LaboratoryInvestigationTest test) {

        int count = getTestCount(test.getLaboratoryInvestigationId());
        String labInvestigationTestId = UUID.randomUUID().toString();
        test.setId(labInvestigationTestId);
        test.setStartTime(DateUtil.getDateDiff());
        test.setEndTime(DateUtil.getDateDiff());
        // check current count
        if (count == 0) {
            // if result is negative set final result
            if (test.getResult().getName().equalsIgnoreCase("Negative")) {
                setFinalResult(test);
            }
        } else if (count == 1) {
            // if result is positive set final result
            if (test.getResult().getName().equalsIgnoreCase("Positive")) {
                setFinalResult(test);
            }
        } // coming to this point means we are now in a parallel test ignore first parallel test and jump to second parallel test
        else if(count == 3) {
            // retrieve last test before this one
            List<LaboratoryInvestigationTest>laboratoryInvestigationTestList =  ehrMobileDatabase.labInvestTestdao().findEarliestTests(test.getLaboratoryInvestigationId());
            LaboratoryInvestigationTest lastTest =
                    ehrMobileDatabase.labInvestTestdao().findEarliestTests(test.getLaboratoryInvestigationId()).get(2);
            if (lastTest.getResult().getName().equalsIgnoreCase(test.getResult().getName())) {
                
                setFinalResult(test);
            }

        } else if (count == 4) {
            setFinalResult(test);
        }
        ehrMobileDatabase.labInvestTestdao().insertLaboratoryInvestTest(test);
        return labInvestigationTestId;
    }

    @Transaction
    private void setFinalResult(LaboratoryInvestigationTest test) {
        // retrieve investigation and update
        Log.d(TAG, "Retrieving laboratory investigation record");
        LaboratoryInvestigation laboratoryInvestigation =
                ehrMobileDatabase.laboratoryInvestigationDao().findLaboratoryInvestigationById(test.getLaboratoryInvestigationId());
        Log.d(TAG, "Retrieved laboratory investigation record : "+ laboratoryInvestigation);
        laboratoryInvestigation.setResultDate(test.getEndTime());
        ehrMobileDatabase.laboratoryInvestigationDao().update(laboratoryInvestigation);
        Log.d(TAG, "Updated laboratory investigation record : "+ laboratoryInvestigation);
        // retrieve person investigation and update
        PersonInvestigation personInvestigation = ehrMobileDatabase.personInvestigationDao().findPersonInvestigationById(
                laboratoryInvestigation.getPersonInvestigationId());
        personInvestigation.setResultId(test.getResult().getCode());
        Log.d(TAG, "Retrieved person investigation record : "+ personInvestigation);
        ehrMobileDatabase.personInvestigationDao().update(personInvestigation);
    }

}
