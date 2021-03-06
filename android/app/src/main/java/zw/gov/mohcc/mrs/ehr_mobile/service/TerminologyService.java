package zw.gov.mohcc.mrs.ehr_mobile.service;

import android.util.Log;

import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

import zw.gov.mohcc.mrs.ehr_mobile.model.terminology.ArtReason;
import zw.gov.mohcc.mrs.ehr_mobile.model.terminology.ArtStatus;
import zw.gov.mohcc.mrs.ehr_mobile.model.terminology.ArvCombinationRegimen;
import zw.gov.mohcc.mrs.ehr_mobile.model.terminology.Country;
import zw.gov.mohcc.mrs.ehr_mobile.model.terminology.Diagnosis;
import zw.gov.mohcc.mrs.ehr_mobile.model.terminology.DisclosureMethod;
import zw.gov.mohcc.mrs.ehr_mobile.model.terminology.EducationLevel;
import zw.gov.mohcc.mrs.ehr_mobile.model.terminology.EntryPoint;
import zw.gov.mohcc.mrs.ehr_mobile.model.terminology.Facility;
import zw.gov.mohcc.mrs.ehr_mobile.model.terminology.HtsModel;
import zw.gov.mohcc.mrs.ehr_mobile.model.terminology.Investigation;
import zw.gov.mohcc.mrs.ehr_mobile.model.terminology.InvestigationResult;
import zw.gov.mohcc.mrs.ehr_mobile.model.terminology.InvestigationTestkit;
import zw.gov.mohcc.mrs.ehr_mobile.model.terminology.LaboratoryTest;
import zw.gov.mohcc.mrs.ehr_mobile.model.terminology.MaritalStatus;
import zw.gov.mohcc.mrs.ehr_mobile.model.terminology.Nationality;
import zw.gov.mohcc.mrs.ehr_mobile.model.terminology.Occupation;
import zw.gov.mohcc.mrs.ehr_mobile.model.terminology.PurposeOfTest;
import zw.gov.mohcc.mrs.ehr_mobile.model.terminology.Question;
import zw.gov.mohcc.mrs.ehr_mobile.model.terminology.QuestionCategory;
import zw.gov.mohcc.mrs.ehr_mobile.model.terminology.ReasonForNotIssuingResult;
import zw.gov.mohcc.mrs.ehr_mobile.model.terminology.Religion;
import zw.gov.mohcc.mrs.ehr_mobile.model.terminology.Result;
import zw.gov.mohcc.mrs.ehr_mobile.model.terminology.Sample;
import zw.gov.mohcc.mrs.ehr_mobile.model.terminology.TestKitTestLevel;
import zw.gov.mohcc.mrs.ehr_mobile.model.terminology.TestingPlan;
import zw.gov.mohcc.mrs.ehr_mobile.model.terminology.Town;
import zw.gov.mohcc.mrs.ehr_mobile.persistance.database.EhrMobileDatabase;

public class TerminologyService {

    private final String TAG = "Terminology Service";
    private EhrMobileDatabase ehrMobileDatabase;
    private static TerminologyService INSTANCE;

    private TerminologyService(EhrMobileDatabase ehrMobileDatabase) {
        this.ehrMobileDatabase = ehrMobileDatabase;
    }

    public static synchronized TerminologyService getInstance(EhrMobileDatabase ehrMobileDatabase) {

        if (INSTANCE == null) {
            return new TerminologyService(ehrMobileDatabase);
        }
        return INSTANCE;
    }

    public void saveSample(List<Sample> samples) {

        ehrMobileDatabase.sampleDao().saveAll(samples);
        Log.d(TAG, "Saved samples : " + ehrMobileDatabase.sampleDao().findAll());
    }

    public void saveDiagnosis(List<Diagnosis> diagnoses) {

        ehrMobileDatabase.diagnosisDao().saveAll(diagnoses);
        Log.d(TAG, "Saved samples : " + ehrMobileDatabase.diagnosisDao().findAll());
    }

    public void saveLaboratoryTests(List<LaboratoryTest> tests) {

        ehrMobileDatabase.laboratoryTestDao().saveAll(tests);
        Log.d(TAG, "Saved laboratory tests : " + ehrMobileDatabase.laboratoryTestDao().findAll());
    }

    public void saveInvestigations(List<Investigation> investigations) {

        ehrMobileDatabase.investigationDao().insertInvestigations(investigations);
        Log.d(TAG, "Saved investigations : " + ehrMobileDatabase.investigationDao().getInvestigations());
    }

    public void saveInvestigationTestKits(List<InvestigationTestkit> investigationTestkits) {

        ehrMobileDatabase.investigationTestkitDao().saveAll(investigationTestkits);
        Log.d(TAG, "Saved investigation test kits : " + ehrMobileDatabase.investigationTestkitDao().findAll());
    }

    public void saveTownToDB(List<Town> towns) {

        ehrMobileDatabase.townsDao().saveAll(towns);
        Log.d(TAG, "Saved towns : " + ehrMobileDatabase.townsDao().findAll());
    }

    public void saveReligionToDB(List<Religion> religions) {

        ehrMobileDatabase.religionDao().saveAll(religions);
        Log.d(TAG, "Saved religions : " + ehrMobileDatabase.religionDao().getAllReligions());
    }


    public void saveOccupationsToDB(List<Occupation> occupations) {

        ehrMobileDatabase.occupationDao().saveAll(occupations);
        Log.d(TAG, "Saved occupations : " + ehrMobileDatabase.occupationDao().findAll());
    }

    public void saveNationalityToDB(List<Nationality> nationalityList) {

        Log.d(TAG, "########################################################");
        Log.d(TAG, nationalityList.toString());

        ehrMobileDatabase.nationalityDao().saveAll(nationalityList);
        Log.d(TAG, "Saved nationalities : " + ehrMobileDatabase.nationalityDao().findAll());
    }


    public void saveEducationLevelToDB(List<EducationLevel> educationLevels) {

        ehrMobileDatabase.educationLevelDao().saveAll(educationLevels);
        Log.d(TAG, "Saved education levels : " + ehrMobileDatabase.educationLevelDao().findAll());
    }

    public void saveEntryPointsToDB(List<EntryPoint> entryPoints) {

        ehrMobileDatabase.entryPointDao().saveAll(entryPoints);
        Log.d(TAG, "Saved entry points : " + ehrMobileDatabase.entryPointDao().findAll());
    }

    public void saveHtsModelToDB(List<HtsModel> htsModels) {

        ehrMobileDatabase.htsModelDao().saveAll(htsModels);
        Log.d(TAG, "Saved hts models : " + ehrMobileDatabase.htsModelDao().findAll());
    }

    public void savePurposeOfTestToDB(List<PurposeOfTest> purposeOfTestList) {

        ehrMobileDatabase.purposeOfTestDao().saveAll(purposeOfTestList);
        Log.d(TAG, "Saved purpose of test : " + ehrMobileDatabase.purposeOfTestDao().findAll());
    }

    public void saveReasonForNotIssuingResultToDB(List<ReasonForNotIssuingResult> reasonForNotIssuingResults) {

        ehrMobileDatabase.reasonForNotIssuingResultDao().saveAll(reasonForNotIssuingResults);
        Log.d(TAG, "Saved reason for not issuing results : " + ehrMobileDatabase.reasonForNotIssuingResultDao().findAll());
    }

    public void saveInvestigationResultsToDB(List<InvestigationResult> investigationResults) {

        ehrMobileDatabase.investigationResultDao().insertAll(investigationResults);
        Log.d(TAG, "Saved investigation results : " + ehrMobileDatabase.investigationResultDao().getInvestigationResults());
    }

    public void saveLaboratoryResults(List<Result> results) {

        ehrMobileDatabase.resultDao().saveAll(results);
        Log.d(TAG, "Saved laboratory results : " + ehrMobileDatabase.resultDao().findAll());
    }

    public void saveArtStatus(List<ArtStatus> artStatuses) {

        ehrMobileDatabase.artStatusDao().insertAll(artStatuses);
        Log.d(TAG, "Saved art status : " + ehrMobileDatabase.artStatusDao().findAll());
    }

    public void saveArtReason(List<ArtReason> artReasons) {

        Log.d(TAG, "Before ::::::: " + artReasons.size());

        Set<ArtReason> dummy = new HashSet<>(artReasons);

        Log.d(TAG, "After ::::::: " + dummy.size());

        ehrMobileDatabase.artReasonDao().saveAll(new ArrayList<>(dummy));
        Log.d(TAG, "Saved art reasons : " + ehrMobileDatabase.artReasonDao().findAll());
    }

    public void saveArvCombinationRegimen(List<ArvCombinationRegimen> arvCombinationRegimens) {

        ehrMobileDatabase.arvCombinationRegimenDao().insertAll(arvCombinationRegimens);
        Log.d(TAG, "Saved arv combination regimen : " + ehrMobileDatabase.arvCombinationRegimenDao().findAll());
    }

    public void saveDisclosureMethod(List<DisclosureMethod> disclosureMethods) {

        ehrMobileDatabase.disclosureMethodDao().saveAll(disclosureMethods);
        Log.d(TAG, "Saved disclosure method : " + ehrMobileDatabase.disclosureMethodDao().findAll());
    }

    public void saveTestingPlan(List<TestingPlan> testingPlans) {

        ehrMobileDatabase.testingPlanDao().saveAll(testingPlans);
        Log.d(TAG, "Saved testing plan : " + ehrMobileDatabase.testingPlanDao().findAll());
    }

    public void saveCountriesToDB(List<Country> countries) {

        Log.d(TAG, "!!!!!!!!!!!!!!!!!!!!!!! " + countries.size());
        Log.d(TAG, "########################### : " + countries);
        ehrMobileDatabase.countryDao().saveAll(countries);
        Log.d(TAG, "Saved countries : " + ehrMobileDatabase.testingPlanDao().findAll());
    }

    public void saveMaritalStatesToDB(List<MaritalStatus> maritalStatuses) {


        ehrMobileDatabase.maritalStateDao().saveAll(maritalStatuses);
        Log.d(TAG, "Saved marital state : " + ehrMobileDatabase.testingPlanDao().findAll());
    }

    public void saveFacilityToDB(List<Facility> facilities) {

        ehrMobileDatabase.facilityDao().saveAll(facilities);
        Log.d(TAG, "Saved facility : " + ehrMobileDatabase.testingPlanDao().findAll());
    }

    public void saveTestkitTestLevels(List<TestKitTestLevel> testKitTestLevels) {

        ehrMobileDatabase.testKitTestLevelDao().saveAll(testKitTestLevels);
        Log.d(TAG, "Saved testkit test levels : " + ehrMobileDatabase.testKitTestLevelDao().findAll());
    }

    public void saveQuestionCategory(List<QuestionCategory> questionCategories) {

        ehrMobileDatabase.questionCategoryDao().saveAll(questionCategories);
        Log.d(TAG, "Saved question categories : " + ehrMobileDatabase.questionCategoryDao().findAll());
    }

    public void saveQuestions(List<Question> questions) {

        ehrMobileDatabase.questionDao().saveAll(questions);
        Log.d(TAG, "Saved questions : " + ehrMobileDatabase.questionDao().findAll());
    }
}
