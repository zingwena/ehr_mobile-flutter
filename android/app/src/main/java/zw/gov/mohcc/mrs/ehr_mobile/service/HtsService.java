package zw.gov.mohcc.mrs.ehr_mobile.service;

import android.util.Log;

import androidx.room.Transaction;

import org.apache.commons.lang3.StringUtils;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashSet;
import java.util.List;
import java.util.Set;
import java.util.UUID;

import zw.gov.mohcc.mrs.ehr_mobile.constant.APPLICATION_CONSTANTS;
import zw.gov.mohcc.mrs.ehr_mobile.dto.HtsRegDTO;
import zw.gov.mohcc.mrs.ehr_mobile.dto.InvestigationDTO;
import zw.gov.mohcc.mrs.ehr_mobile.dto.LaboratoryInvestigationTestDTO;
import zw.gov.mohcc.mrs.ehr_mobile.dto.PastDate;
import zw.gov.mohcc.mrs.ehr_mobile.dto.PostTestDTO;
import zw.gov.mohcc.mrs.ehr_mobile.dto.PreTestDTO;
import zw.gov.mohcc.mrs.ehr_mobile.enumeration.BinType;
import zw.gov.mohcc.mrs.ehr_mobile.enumeration.TestLevel;
import zw.gov.mohcc.mrs.ehr_mobile.model.Visit;
import zw.gov.mohcc.mrs.ehr_mobile.model.hts.Hts;
import zw.gov.mohcc.mrs.ehr_mobile.model.laboratory.LaboratoryInvestigation;
import zw.gov.mohcc.mrs.ehr_mobile.model.laboratory.LaboratoryInvestigationTest;
import zw.gov.mohcc.mrs.ehr_mobile.model.laboratory.PersonInvestigation;
import zw.gov.mohcc.mrs.ehr_mobile.model.terminology.Result;
import zw.gov.mohcc.mrs.ehr_mobile.model.terminology.TestKit;
import zw.gov.mohcc.mrs.ehr_mobile.model.warehouse.TestKitBatchIssue;
import zw.gov.mohcc.mrs.ehr_mobile.persistance.database.EhrMobileDatabase;
import zw.gov.mohcc.mrs.ehr_mobile.util.DateUtil;

public class HtsService {

    private static HtsService INSTANCE;
    private final String TAG = "Hts Service";
    private EhrMobileDatabase ehrMobileDatabase;
    private AppWideService appWideService;
    private SiteService siteService;

    private HtsService(EhrMobileDatabase ehrMobileDatabase, AppWideService appWideService) {
        this.ehrMobileDatabase = ehrMobileDatabase;
        this.appWideService = appWideService;
        this.siteService = SiteService.getInstance(ehrMobileDatabase);
    }

    public static synchronized HtsService getInstance(EhrMobileDatabase ehrMobileDatabase, AppWideService appWideService) {

        if (INSTANCE == null) {
            return new HtsService(ehrMobileDatabase, appWideService);
        }
        return INSTANCE;
    }

    @Transaction
    public String createHts(HtsRegDTO dto) {

        String visitId = appWideService.getCurrentVisit(dto.getPersonId());
        Log.i(TAG, "Retrieving or creating current visit : " + visitId);
        Log.i(TAG, "Creating HTS record");
        Hts hts = HtsRegDTO.getInstance(dto, visitId);
        Log.i(TAG, "HTS RECORD CREATED HERE " + hts);
        String laboratoryInvestigationId = createInvestigation(new InvestigationDTO(dto.getPersonId(),
                new PastDate(hts.getDateOfHivTest()),
                visitId, APPLICATION_CONSTANTS.HIV_TESTS[0], null), true);
        hts.setLaboratoryInvestigationId(laboratoryInvestigationId);
        Log.i(TAG, "Created hts record : " + ehrMobileDatabase.htsDao().findHtsById(hts.getId()));
        ehrMobileDatabase.htsDao().save(hts);
        return hts.getId();
    }

    @Transaction
    public String createInvestigation(InvestigationDTO dto, boolean labInvestigation) {

        if (StringUtils.isBlank(dto.getVisitId())) {
            String visitId = appWideService.getCurrentVisit(dto.getPersonId());
            Log.i(TAG, "Retrieving or creating current visit : " + visitId);
        }

        Log.i(TAG, "Creating Person Investigation record from Investigation DTO : " + dto);
        String personInvestigationId = UUID.randomUUID().toString();
        PersonInvestigation personInvestigation = new PersonInvestigation(personInvestigationId, dto.getPersonId(), dto.getInvestigationId().trim(), dto.getDateOfTest());
        if (StringUtils.isNoneBlank(dto.getResult())) {
            personInvestigation.setResult(dto.getResult());
        }

        Log.d(TAG, "Person investigation object : " + personInvestigation);

        ehrMobileDatabase.personInvestigationDao().insertPersonInvestigation(personInvestigation);
        Log.i(TAG, "Saved person investigation record : " + ehrMobileDatabase.personInvestigationDao().findPersonInvestigationById(personInvestigationId));
        if (labInvestigation) {
            Log.i(TAG, "Creating laboratory investigation record");
            String laboratoryInvestigationId = personInvestigationId;
            LaboratoryInvestigation laboratoryInvestigation = new LaboratoryInvestigation(laboratoryInvestigationId, siteService.getFacilityDetails().getCode(), personInvestigationId);
            ehrMobileDatabase.laboratoryInvestigationDao().createLaboratoryInvestigation(laboratoryInvestigation);
            Log.d(TAG, "Created laboratory investigation : " + ehrMobileDatabase.laboratoryInvestigationDao().findLaboratoryInvestigationById(laboratoryInvestigationId));
            return laboratoryInvestigationId;
        }
        return null;
    }

    /**
     * @param investigationId
     * @return list of results
     */
    public List<Result> getInvestigationResults(String investigationId) {
        return ehrMobileDatabase.resultDao().findByIdsIn(
                ehrMobileDatabase.investigationResultDao().findByInvestigationId(investigationId)
        );
    }

    public Hts getCurrentHts(String personId) {
        Visit visit = appWideService.getVisit(personId);
        // check if patient has current hts record
        if (visit != null) {
            return ehrMobileDatabase.htsDao().findCurrentHts(visit.getId());
        }
        return null;
    }

    private int getTestCount(String laboratoryInvestigationId) {
        return ehrMobileDatabase.labInvestTestdao().countByLaboratoryInvestigation(laboratoryInvestigationId);
    }

    private TestLevel getTestLevel(int count) {
        switch (count) {
            case 0:
                return TestLevel.get("FIRST");
            case 1:
                return TestLevel.get("SECOND");
            case 2:
                return TestLevel.get("PARALLEL_ONE");
            case 3:
                return TestLevel.get("PARALLEL_TWO");
            case 4:
                return TestLevel.get("THIRD");
            default:
                throw new IllegalStateException("Illegal parameter passed to method : " + count);
        }
    }

    private List<String> getFirstTwoTestKits(String laboratoryInvestigationId, int maxCount) {
        List<String> testKitIds = new ArrayList<>();
        int retainMaxCount = maxCount;
        String lastParallelTest = "";
        for (LaboratoryInvestigationTest item : ehrMobileDatabase.labInvestTestdao().findEarliestTests(laboratoryInvestigationId)) {
            if (retainMaxCount == 3 && maxCount == 1) {
                Log.d(TAG, "Is this ever executed");
                lastParallelTest = item.getTestkit().getCode();
                continue;
            }
            if (maxCount > 0) {
                // get testkit ID using name
                testKitIds.add(item.getTestkit().getCode());
            } else {
                break;
            }
            maxCount--;
        }
        if (StringUtils.isNoneBlank(lastParallelTest)) {
            Log.i(TAG, "Before removing : " + testKitIds);
            testKitIds.remove(lastParallelTest);
            Log.i(TAG, "After removing : " + testKitIds);
        }
        Log.i(TAG, "Retrieved test kit ids : %%%%%%%%%%%%%%%%%%%%%%%%%%%%% : " + testKitIds.toString());
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
                throw new IllegalStateException("Illegal parameter passed to method : " + count);
        }
    }

    public LaboratoryInvestigation getLaboratoryInvestigation(String personId) {

        PersonInvestigation personInvestigation = getPersonInvestigation(personId);
        return ehrMobileDatabase.laboratoryInvestigationDao().findByPersonInvestigationId(personInvestigation.getId());
    }

    public PersonInvestigation getPersonInvestigation(String personId) {

        return ehrMobileDatabase.personInvestigationDao().findByPersonIdAndDate(personId, new Date().getTime(), DateUtil.getEndOfDay(new Date()).getTime());
    }

    //ee7d91fc-b27f-11e8-b121-c48e8faf035b @Noku this is the recency investigation id use it when calling this method
    public List<TestKit> getInvestigationTestKit(String investigationId) {

        return ehrMobileDatabase.investigationTestkitDao().findByInvestigationId(investigationId);
    }

    public Set<TestKit> getTestKitByTestLevel(String laboratoryInvestigationId) {
        int count = getTestCount(laboratoryInvestigationId);
        TestLevel level = getTestLevel(count);
        Log.i(TAG, "Laboratory Investigation ID : " + laboratoryInvestigationId);
        Log.i(TAG, "Retrieving test kits count is at : " + count + " Using level : " + level);
        if (count == 0 || count == 1 || count == 4) {
            return new HashSet<>(ehrMobileDatabase.testKitDao().findTestKitsByLevel(level));
        } else if (count == 2) {
            return new HashSet<>(ehrMobileDatabase.testKitDao().findTestKitIdsIn(getFirstTwoTestKits(laboratoryInvestigationId, 2)));
        } else if (count == 3) {
            // remove test done on 2
            Log.d(TAG, "We are now on second parallel test : " + count);
            return new HashSet<>(ehrMobileDatabase.testKitDao().findTestKitIdsIn(getFirstTwoTestKits(laboratoryInvestigationId, 3)));
        }
        return null;
    }

    public String getFinalResult(String laboratoryInvestigationId) {

        LaboratoryInvestigation laboratoryInvestigation =
                ehrMobileDatabase.laboratoryInvestigationDao().findLaboratoryInvestigationById(laboratoryInvestigationId);

        PersonInvestigation personInvestigation = ehrMobileDatabase.personInvestigationDao()
                .findPersonInvestigationById(laboratoryInvestigation.getPersonInvestigationId());

        return personInvestigation.getResult();
    }

    @Transaction
    public String processOtherInvestigationResults(LaboratoryInvestigationTestDTO testDTO) {
        String laboratoryInvestigationId = createInvestigation(testDTO.get(testDTO), true);
        Log.d(TAG, "Entering try method");
        LaboratoryInvestigationTest test = new LaboratoryInvestigationTest();
        String labInvestigationTestId = UUID.randomUUID().toString();
        test.setId(labInvestigationTestId);
        test.setLaboratoryInvestigationId(laboratoryInvestigationId);
        test.setVisitId(testDTO.getVisitId());
        test.setTestkit(testDTO.getTestkit());
        test.setResult(testDTO.getResult().getName());
        test.setStartTime(DateUtil.getDateDiff(true));
        test.setEndTime(DateUtil.getDateDiff(false));
        test.setBatchIssueId(testDTO.getBatchIssueId());
        Log.d(TAG, "Saving laboratory investigation test item : " + test);
        ehrMobileDatabase.labInvestTestdao().save(test);
        TestKitBatchIssue testKitBatchIssue = ehrMobileDatabase.testKitBatchIssueDao().findById(testDTO.getBatchIssueId());
        Log.d(TAG, "Removing item from batchIssue : " + testKitBatchIssue);
        testKitBatchIssue.setRemaining(testKitBatchIssue.getRemaining() - 1);
        ehrMobileDatabase.testKitBatchIssueDao().update(testKitBatchIssue);
        Log.d(TAG, "Testkit batch issue updated : " + ehrMobileDatabase.testKitBatchIssueDao().findById(testDTO.getBatchIssueId()));
        setFinalResult(test);
        return labInvestigationTestId;
    }


    @Transaction
    public String processTestResults(LaboratoryInvestigationTest test) {

        int count = getTestCount(test.getLaboratoryInvestigationId());
        String labInvestigationTestId = UUID.randomUUID().toString();
        Log.d(TAG, "Laboratory investigation test object : " + test);
        test.setId(labInvestigationTestId);
        test.setStartTime(DateUtil.getDateDiff(true));
        test.setEndTime(DateUtil.getDateDiff(false));
        // check current count
        if (count == 0) {
            // if result is negative set final result
            if (test.getResult().equalsIgnoreCase("Negative")) {
                setFinalResult(test);
            }
        } else if (count == 1) {
            // if result is positive set final result
            if (test.getResult().equalsIgnoreCase("Positive")) {
                setFinalResult(test);
            }
        } // coming to this point means we are now in a parallel test ignore first parallel test and jump to second parallel test
        else if (count == 3) {
            // retrieve last test before this one
            LaboratoryInvestigationTest lastTest =
                    ehrMobileDatabase.labInvestTestdao().findEarliestTests(test.getLaboratoryInvestigationId()).get(2);
            if (lastTest.getResult().equalsIgnoreCase(test.getResult())) {

                setFinalResult(test);
            }

        } else if (count == 4) {
            // if result is positive set result to be inconclusive
            if (test.getResult().equalsIgnoreCase("Positive")) {
                test.setResult("INCONCLUSIVE");
            }
            setFinalResult(test);
        }
        ehrMobileDatabase.labInvestTestdao().save(test);
        Log.d(TAG, "batch Issue ID : " + test.getBatchIssueId());
        TestKitBatchIssue testKitBatchIssue = ehrMobileDatabase.testKitBatchIssueDao().findById(test.getBatchIssueId());
        Log.d(TAG, "Removing item from batchIssue : " + testKitBatchIssue);
        testKitBatchIssue.setRemaining(testKitBatchIssue.getRemaining() - 1);
        ehrMobileDatabase.testKitBatchIssueDao().update(testKitBatchIssue);
        Log.d(TAG, "Testkit batch issue updated : " + ehrMobileDatabase.testKitBatchIssueDao().findById(test.getBatchIssueId()));
        return labInvestigationTestId;
    }

    @Transaction
    private void setFinalResult(LaboratoryInvestigationTest test) {
        // retrieve investigation and update
        Log.d(TAG, "Laboratory Investigation Test Object : " + test);
        Log.d(TAG, "Retrieving laboratory investigation record");
        LaboratoryInvestigation laboratoryInvestigation =
                ehrMobileDatabase.laboratoryInvestigationDao().findLaboratoryInvestigationById(test.getLaboratoryInvestigationId());
        Log.d(TAG, "Retrieved laboratory investigation record : " + laboratoryInvestigation);
        laboratoryInvestigation.setResultDate(test.getEndTime());
        ehrMobileDatabase.laboratoryInvestigationDao().update(laboratoryInvestigation);
        Log.d(TAG, "Updated laboratory investigation record : " + laboratoryInvestigation);
        // retrieve person investigation and update
        PersonInvestigation personInvestigation = ehrMobileDatabase.personInvestigationDao().findPersonInvestigationById(
                laboratoryInvestigation.getPersonInvestigationId());
        personInvestigation.setResult(test.getResult());
        Log.d(TAG, "Retrieved person investigation record : " + personInvestigation);
        ehrMobileDatabase.personInvestigationDao().update(personInvestigation);
    }

    public boolean getPersonHivStatus(String personId) {
        String hivBloodInvestigationId = APPLICATION_CONSTANTS.HIV_TESTS[0];
        String hivPositiveResultId = APPLICATION_CONSTANTS.POSITIVE_HIV_RESULT_LITERAL;
        return ehrMobileDatabase.personInvestigationDao().findByPersonIdAndInvestigationIdAndResultId(personId, hivBloodInvestigationId, hivPositiveResultId) != null;
    }

    public List<TestKitBatchIssue> getQueueOrWardTestKits(BinType binType, String binId, String testKitId) {

        Log.d(TAG, "Retrieving testkit batches for : " + binType + "Bin ID : " + binId + " with testkit id : " + testKitId);

        List<TestKitBatchIssue> binTestKitBatches = ehrMobileDatabase.testKitBatchIssueDao().findByQueueOrWardAndTestKit(binType, binId, testKitId);

        Log.d(TAG, "BIN Testkits HHHH : " + binTestKitBatches);

        return binTestKitBatches;
    }

    public Hts savePreTestCounselling(PreTestDTO preTestDTO) {

        Log.d(TAG, "Saving pretest counselling record");
        Hts hts = ehrMobileDatabase.htsDao().findHtsById(preTestDTO.getHtsId());
        ehrMobileDatabase.htsDao().updateHts(preTestDTO.getInstance(preTestDTO, hts));

        return ehrMobileDatabase.htsDao().findHtsById(hts.getId());
    }

    public Hts savePostTestCounselling(PostTestDTO postTestDTO) {

        Log.d(TAG, "Saving posttest counselling record");
        Hts hts = ehrMobileDatabase.htsDao().findHtsById(postTestDTO.getHtsId());
        ehrMobileDatabase.htsDao().updateHts(postTestDTO.getInstance(postTestDTO, hts));

        return ehrMobileDatabase.htsDao().findHtsById(hts.getId());
    }

}
