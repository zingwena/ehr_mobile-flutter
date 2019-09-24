package zw.gov.mohcc.mrs.ehr_mobile.service;

import android.util.Log;

import java.util.ArrayList;
import java.util.List;

import zw.gov.mohcc.mrs.ehr_mobile.model.ArtReason;
import zw.gov.mohcc.mrs.ehr_mobile.model.ArtStatus;
import zw.gov.mohcc.mrs.ehr_mobile.model.ArvCombinationRegimen;
import zw.gov.mohcc.mrs.ehr_mobile.model.EducationLevel;
import zw.gov.mohcc.mrs.ehr_mobile.model.EntryPoint;
import zw.gov.mohcc.mrs.ehr_mobile.model.HtsModel;
import zw.gov.mohcc.mrs.ehr_mobile.model.Investigation;
import zw.gov.mohcc.mrs.ehr_mobile.model.InvestigationResult;
import zw.gov.mohcc.mrs.ehr_mobile.model.LaboratoryTest;
import zw.gov.mohcc.mrs.ehr_mobile.model.Nationality;
import zw.gov.mohcc.mrs.ehr_mobile.model.Occupation;
import zw.gov.mohcc.mrs.ehr_mobile.model.PurposeOfTest;
import zw.gov.mohcc.mrs.ehr_mobile.model.ReasonForNotIssuingResult;
import zw.gov.mohcc.mrs.ehr_mobile.model.Religion;
import zw.gov.mohcc.mrs.ehr_mobile.model.Result;
import zw.gov.mohcc.mrs.ehr_mobile.model.Sample;
import zw.gov.mohcc.mrs.ehr_mobile.model.Town;
import zw.gov.mohcc.mrs.ehr_mobile.persistance.database.EhrMobileDatabase;

public class TerminologyService {

    private final String TAG = "Terminology Service";
    private EhrMobileDatabase ehrMobileDatabase;

    public TerminologyService(EhrMobileDatabase ehrMobileDatabase) {
        this.ehrMobileDatabase = ehrMobileDatabase;
    }

    public void saveSample(List<Sample> samples) {

        ehrMobileDatabase.sampleDao().insertSamples(samples);
        Log.d(TAG, "Saved samples : " + ehrMobileDatabase.sampleDao().getSamples());
    }

    public void saveLaboratoryTests(List<LaboratoryTest> tests) {

        ehrMobileDatabase.laboratoryTestDao().insertLaboratoryTests(tests);
        Log.d(TAG, "Saved laboratory tests : " + ehrMobileDatabase.laboratoryTestDao().getLaboratoryTests());
    }

    public void saveInvestigations (List<Investigation> investigations) {

        ehrMobileDatabase.investigationDao().insertInvestigations(investigations);
        Log.d(TAG, "Saved investigations : " + ehrMobileDatabase.investigationDao().getInvestigations());
    }

    public void saveTownToDB(List<Town> towns) {

        ehrMobileDatabase.townsDao().createTowns(towns);
        Log.d(TAG, "Saved towns : " + ehrMobileDatabase.townsDao().getAllTowns());
    }

    public void saveReligionToDB(List<Religion> religions) {

        ehrMobileDatabase.religionDao().insertReligions(religions);
        Log.d(TAG, "Saved religions : " + ehrMobileDatabase.religionDao().getAllReligions());
    }


    public void saveOccupationsToDB(List<Occupation> occupations) {

        ehrMobileDatabase.occupationDao().insertOccupations(occupations);
        Log.d(TAG, "Saved occupations : " + ehrMobileDatabase.occupationDao().getAllOccupations());
    }

    public void saveNationalityToDB (List<Nationality> nationalityList) {

        ehrMobileDatabase.nationalityDao().insertNationalities(nationalityList);
        Log.d(TAG, "Saved nationalities : " + ehrMobileDatabase.nationalityDao().selectAllNationalities());
    }


    public void saveEducationLevelToDB (List<EducationLevel> educationLevels) {

        ehrMobileDatabase.educationLevelDao().insertEducationLevels(educationLevels);
        Log.d(TAG, "Saved education levels : " + ehrMobileDatabase.educationLevelDao().getEducationLevels());
    }

    public void saveEntryPointsToDB(List<EntryPoint> entryPoints) {

        ehrMobileDatabase.entryPointDao().insertEntryPoints(entryPoints);
        Log.d(TAG, "Saved entry points : " + ehrMobileDatabase.entryPointDao().getAllEntryPoints());
    }

    public void saveHtsModelToDB(List<HtsModel> htsModels) {

        ehrMobileDatabase.htsModelDao().insertHtsModels(htsModels);
        Log.d(TAG, "Saved hts models : " + ehrMobileDatabase.htsModelDao().getAllHtsModels());
    }

    public void savePurposeOfTestToDB(List<PurposeOfTest> purposeOfTestList) {

        ehrMobileDatabase.purposeOfTestDao().insertPurposeOfTest(purposeOfTestList);
        Log.d(TAG, "Saved purpose of test : " + ehrMobileDatabase.purposeOfTestDao().getAllPurposeOfTest());
    }

    public void saveReasonForNotIssuingResultToDB(List<ReasonForNotIssuingResult> reasonForNotIssuingResults) {

        ehrMobileDatabase.reasonForNotIssuingResultDao().insertReasonForNotIssuingResults(reasonForNotIssuingResults);
        Log.d(TAG, "Saved reason for not issuing results : " + ehrMobileDatabase.reasonForNotIssuingResultDao().getAllReasonForNotIssuingResults());
    }

    public void saveInvestiogationResultsToDB(List<InvestigationResult> investigationResults) {

        ehrMobileDatabase.investigationResultDao().insertAll(investigationResults);
        Log.d(TAG, "Saved investigation results : " + ehrMobileDatabase.investigationResultDao().getInvestigationResults());
    }

    public void saveLaboratoryResults(List<Result> results) {

        ehrMobileDatabase.resultDao().insertResult(results);
        Log.d(TAG, "Saved laboratory results : " + ehrMobileDatabase.resultDao().getAllResults());
    }

    public void saveArtStatus(List<ArtStatus> artStatuses) {

        ehrMobileDatabase.artStatusDao().insertAll(artStatuses);
        Log.d(TAG, "Saved art status : " + ehrMobileDatabase.artStatusDao().findAll());
    }

    public void saveArtReason(List<ArtReason> artReasons) {

        ehrMobileDatabase.artReasonDao().insertAll(artReasons);
        Log.d(TAG, "Saved art reasons : " + ehrMobileDatabase.artReasonDao().findAll());
    }

    public void saveArvCombinationRegimen(List<ArvCombinationRegimen> arvCombinationRegimens) {

        ehrMobileDatabase.arvCombinationRegimenDao().insertAll(arvCombinationRegimens);
        Log.d(TAG, "Saved arv combination regimen : " + ehrMobileDatabase.arvCombinationRegimenDao().findAll());
    }
}
