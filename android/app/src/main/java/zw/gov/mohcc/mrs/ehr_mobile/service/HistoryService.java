package zw.gov.mohcc.mrs.ehr_mobile.service;


import android.util.Log;

import androidx.annotation.NonNull;
import androidx.room.Transaction;

import org.apache.commons.lang3.StringUtils;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

import zw.gov.mohcc.mrs.ehr_mobile.constant.APPLICATION_CONSTANTS;
import zw.gov.mohcc.mrs.ehr_mobile.dto.HtsScreeningDTO;
import zw.gov.mohcc.mrs.ehr_mobile.dto.InvestigationDTO;
import zw.gov.mohcc.mrs.ehr_mobile.dto.NameCodeResponse;
import zw.gov.mohcc.mrs.ehr_mobile.dto.SexualHistoryDTO;
import zw.gov.mohcc.mrs.ehr_mobile.dto.SexualHistoryQuestionDTO;
import zw.gov.mohcc.mrs.ehr_mobile.dto.SexualHistoryQuestionView;
import zw.gov.mohcc.mrs.ehr_mobile.enumeration.ActivityStatus;
import zw.gov.mohcc.mrs.ehr_mobile.enumeration.WorkArea;
import zw.gov.mohcc.mrs.ehr_mobile.model.art.Art;
import zw.gov.mohcc.mrs.ehr_mobile.model.hts.Hts;
import zw.gov.mohcc.mrs.ehr_mobile.model.hts.HtsScreening;
import zw.gov.mohcc.mrs.ehr_mobile.model.hts.SexualHistory;
import zw.gov.mohcc.mrs.ehr_mobile.model.hts.SexualHistoryQuestion;
import zw.gov.mohcc.mrs.ehr_mobile.model.laboratory.LaboratoryInvestigation;
import zw.gov.mohcc.mrs.ehr_mobile.model.laboratory.PersonInvestigation;
import zw.gov.mohcc.mrs.ehr_mobile.model.terminology.Question;
import zw.gov.mohcc.mrs.ehr_mobile.model.vitals.Visit;
import zw.gov.mohcc.mrs.ehr_mobile.persistance.database.EhrMobileDatabase;

public class HistoryService {
    private static HistoryService INSTANCE;
    private final String TAG = "History Service";
    private EhrMobileDatabase ehrMobileDatabase;
    private HtsService htsService;

    private HistoryService(EhrMobileDatabase ehrMobileDatabase, HtsService htsService) {
        this.ehrMobileDatabase = ehrMobileDatabase;
        this.htsService = htsService;
    }

    public static synchronized HistoryService getInstance(EhrMobileDatabase ehrMobileDatabase, HtsService htsService) {

        if (INSTANCE == null) {
            return new HistoryService(ehrMobileDatabase, htsService);
        }
        return INSTANCE;
    }

    public SexualHistory getSexualHistory(String personId) {

        return ehrMobileDatabase.sexualHistoryDao().findByPersonId(personId);
    }

    public boolean existsByPersonId(String personId) {
        return ehrMobileDatabase.htsDao().countByPersonId(personId) >= 1;
    }

    public String createSexualHistoryQuestion(SexualHistoryQuestionDTO dto) {

        SexualHistoryQuestion item = dto.getInstance(dto);
        item.setSexualHistoryId(getSexualHistory(dto.getPersonId()).getId());
        Log.d(TAG, "State of sexual history question : " + item);

        ehrMobileDatabase.sexualHistoryQuestionDao().save(item);
        Log.i(TAG, "Sexual history dto saved");
        return item.getId();
    }

    public List<SexualHistoryQuestionView> getPatientSexualHistQuestions(String personId) {
        SexualHistory sexualHistory = getSexualHistory(personId);
        if (sexualHistory == null) {
            return null;
        }
        Log.d(TAG, "Retrieving all sexual history questions in system ");
        List<Question> sexualHistoryQuestions = ehrMobileDatabase.questionDao().findByWorkArea(WorkArea.SEXUAL_HISTORY);
        //Log.d(TAG, )
        List<SexualHistoryQuestionView> views = new ArrayList<>();
        for (Question question : sexualHistoryQuestions) {

            NameCodeResponse nameCode = new NameCodeResponse(question.getCode(), question.getName());

            SexualHistoryQuestion sexualHistoryQuestion =
                    ehrMobileDatabase.sexualHistoryQuestionDao().findBySexualHistoryIdAndQuestionId(sexualHistory.getId(), question.getCode());
            Log.d(TAG, "Retrieved sexual history question object : " + sexualHistoryQuestion);
            String sexualHistoryQuestionId = null;
            if (sexualHistoryQuestion != null) {
                nameCode.setResponseType(sexualHistoryQuestion.getQuestion().getResponseType());
                sexualHistoryQuestionId = sexualHistoryQuestion != null ? sexualHistoryQuestion.getId() : null;
            }

            SexualHistoryQuestionView view = new SexualHistoryQuestionView(sexualHistoryQuestionId, nameCode);
            views.add(view);
        }

        Log.d(TAG, "Retrieved sexual history questions and their states : " + views);
        return views;
    }

    public HtsScreeningDTO getHtsScreening(String currentVisitId) {

        Log.d(TAG, "Current visit ID : " + currentVisitId);

        // check in system if patient has ever been tested if yes return @false check in
        // screening
        boolean testingCompletedInCurrentRun = false;
        final String personId = ehrMobileDatabase.visitDao().findById(currentVisitId).getPersonId();
        if (existsByPersonId(personId)) {
            // testing has been initiated in current run so hts is never going to be null
            Hts hts = ehrMobileDatabase.htsDao().findLatestHts(personId);
            Log.i(TAG, "Find latest hts" + hts.toString());
            PersonInvestigation personInvestigation = htsService.getPersonInvestigation(personId);
            LaboratoryInvestigation laboratoryInvestigation = htsService.getLaboratoryInvestigation(personId);
            if (StringUtils.isNoneBlank(hts.getLaboratoryInvestigationId()) && laboratoryInvestigation != null
                    && personInvestigation != null) {
                testingCompletedInCurrentRun = true;
            }
        }
        HtsScreeningDTO dto = null;
        // retrieve person last negative result this applies to both test in ehr and
        // outside it
        final String negativeHivResult = APPLICATION_CONSTANTS.NEGATIVE_HIV_RESULT;
        final Set<String> hivTests = new HashSet<>(Arrays.asList(APPLICATION_CONSTANTS.HIV_TESTS));

        PersonInvestigation personInvestigation = ehrMobileDatabase.personInvestigationDao()
                .findTopByPersonIdAndResultNameAndInvestigationIdInOrderByDateDesc(personId, negativeHivResult, hivTests);


        if (testingCompletedInCurrentRun) {
            dto = new HtsScreeningDTO();
            dto.setTestedBefore(true);
            dto.setPersonId(personId);
            // retrieve last HTS record
            Hts hts = ehrMobileDatabase.htsDao().findLatestHts(personId);
            dto.setDateLastTested(hts.getDateOfHivTest());
            // retrieve the result of this test
            LaboratoryInvestigation laboratoryInvestigation = ehrMobileDatabase.laboratoryInvestigationDao()
                    .findLaboratoryInvestigationById(hts.getLaboratoryInvestigationId());
            personInvestigation = ehrMobileDatabase.personInvestigationDao().findPersonInvestigationById(laboratoryInvestigation.getPersonInvestigationId());

            dto.setResult(ehrMobileDatabase.resultDao().findById(personInvestigation.getResultId()).getName());

        }
        // patient has already done hts screening previously and has no test in EHR &lt
        // important buggy section
        HtsScreening htsScreening = ehrMobileDatabase.htsScreeningDao().findByVisitId(currentVisitId);
        if (htsScreening != null && !testingCompletedInCurrentRun) {
            if (dto == null) {
                dto = new HtsScreeningDTO();
            }
            dto.setPersonId(personId);
            dto.setArt(htsScreening.getArt());
            dto.setArtNumber(htsScreening.getArtNumber());
            dto.setDateLastTested(htsScreening.getDateLastTested());
            dto.setTestedBefore(htsScreening.isTestedBefore());
            dto.setResult(htsScreening.getResult());
            dto.setViralLoadDone(htsScreening.getViralLoadDone());
            dto.setCd4Done(htsScreening.getCd4Done());
            Log.i(TAG, "Setting date last negative" + htsScreening.getDateLastNegative());
            dto.setDateLastNegative(htsScreening.getDateLastNegative());
            Log.i(TAG, "Date last negative set successfully");
        }

        // check art details it must also work if patient is on art while not having
        // been tested in EHR
        Art art = ehrMobileDatabase.artDao().findByPersonId(personId);
        if (art != null) {
            if (dto == null) {
                dto = new HtsScreeningDTO();
            }
            dto.setPersonId(personId);
            dto.setArt(true);
            dto.setArtNumber(art.getArtNumber());
            dto.setDateEnrolled(art.getDateEnrolled());
        }
        // retrieve tests for viral load and cd4 count
        final Set<String> viralLoadTests = new HashSet<>(Arrays.asList(APPLICATION_CONSTANTS.VIRAL_LOAD_TESTS));

        PersonInvestigation viralLoadInvestigation = ehrMobileDatabase.personInvestigationDao()
                .findTopByPersonIdAndInvestigationIdInOrderByDateDesc(personId, viralLoadTests);

        if (viralLoadInvestigation != null) {
            if (dto == null) {
                dto = new HtsScreeningDTO();
            }
            dto.setPersonId(personId);
            dto.setViralLoadDone(ActivityStatus.DONE);
            dto.setViralLoad(StringUtils.isNoneBlank(viralLoadInvestigation.getResultId())
                    ? Integer.valueOf(viralLoadInvestigation.getResultId())
                    : null);
            dto.setViralLoadDate(viralLoadInvestigation.getDate());
        }

        final Set<String> cd4CountTests = new HashSet<>(
                Arrays.asList(APPLICATION_CONSTANTS.CD4_COUNT_TESTS));

        PersonInvestigation cd4CountInvestigation = ehrMobileDatabase.personInvestigationDao()
                .findTopByPersonIdAndInvestigationIdInOrderByDateDesc(personId, cd4CountTests);

        if (cd4CountInvestigation != null) {
            if (dto == null) {
                dto = new HtsScreeningDTO();
            }
            dto.setPersonId(personId);
            dto.setCd4Done(ActivityStatus.DONE);
            dto.setCd4Count(StringUtils.isNoneBlank(cd4CountInvestigation.getResultId())
                    ? Integer.valueOf(cd4CountInvestigation.getResultId())
                    : null);
            dto.setCd4CountDate(cd4CountInvestigation.getDate());
        }
        if (personInvestigation != null) {
            if (dto == null) {
                dto = new HtsScreeningDTO();
            }
            dto.setPersonId(personId);
            dto.setDateLastNegative(personInvestigation.getDate());
        }
        Log.d(TAG, "Hts Screening for current patient : " + dto);
        return dto;
    }

    @Transaction
    public String saveSexualHistory(SexualHistoryDTO dto) {
        Log.i(TAG, "Saving sexual history object : " + dto);
        ehrMobileDatabase.sexualHistoryDao().save(dto.getInstance(dto));
        SexualHistory sexualHistory = getSexualHistory(dto.getPersonId());
        Log.i(TAG, "Sexual history record saved for : " + dto.getPersonId() + " " + ehrMobileDatabase.sexualHistoryDao().findByPersonId(dto.getPersonId()));
        return sexualHistory.getId();
    }

    @Transaction
    public void saveHtsScreening(HtsScreeningDTO dto, @NonNull String visitId) {

        Log.i(TAG, "State of screening DTO : " + dto);
        Log.i(TAG, "Current visit ID : " + visitId);

        // check if screening exists for this visit otherwise update it
        HtsScreening htsScreening = ehrMobileDatabase.htsScreeningDao().findByVisitId(visitId);


        if (htsScreening == null) {
            Log.i(TAG, "Saving hts screening record");
            ehrMobileDatabase.htsScreeningDao().save(dto.getHtsScreeningInstance(dto, visitId));

            // check patient art record
            if (dto.getArt() != null && dto.getArt()) {

                Visit visit = ehrMobileDatabase.visitDao().findById(visitId);
                Art art = ehrMobileDatabase.artDao().findByPersonId(visit.getPersonId());
                if (art == null) {
                    // create art record
                    Log.i(TAG, "Creating art record");
                    ehrMobileDatabase.artDao().save(dto.getArtInstance(dto, visit.getPersonId()));
                    Log.i(TAG, "Saved art record : " + ehrMobileDatabase.artDao().findByPersonId(visit.getPersonId()));
                }
            }

            // create history items
            Log.i(TAG, "Now creating history records if any");
            final String personId = ehrMobileDatabase.visitDao().findById(visitId).getPersonId();
            // hiv
            if (dto.isTestedBefore()) {
                Log.i(TAG, "Hiv results here");
                Log.d(TAG, "Retrieve either positive or negative HIV results : " + dto.getResult());
                String resultId = "";
                if (dto.getResult().equalsIgnoreCase("POSITIVE")) {
                    resultId = APPLICATION_CONSTANTS.POSITIVE_HIV_RESULT;
                } else if (dto.getResult().equalsIgnoreCase("NEGATIVE")) {
                    resultId = APPLICATION_CONSTANTS.NEGATIVE_HIV_RESULT;
                }

                InvestigationDTO investigationDTO = new InvestigationDTO(personId, dto.getDateLastTested(), visitId,
                        APPLICATION_CONSTANTS.HIV_TESTS[0], resultId);
                Log.i(TAG, "Saving investigation record ");
                htsService.createInvestigation(investigationDTO, false);
            }
            // viral load
            if (dto.getViralLoad() != null && dto.getViralLoadDate() != null) {
                Log.i(TAG, "Viral load tests");
                InvestigationDTO investigationDTO = new InvestigationDTO(personId, dto.getViralLoadDate(), visitId,
                        APPLICATION_CONSTANTS.VIRAL_LOAD_TESTS[0], dto.getViralLoad().toString());
                Log.i(TAG, "Saved viral load investigation record");
                htsService.createInvestigation(investigationDTO, false);
            }

            // cd4 count
            if (dto.getCd4Count() != null && dto.getCd4CountDate() != null) {
                Log.i(TAG, "Cd4 count tests");
                InvestigationDTO investigationDTO = new InvestigationDTO(personId, dto.getCd4CountDate(), visitId,
                        APPLICATION_CONSTANTS.CD4_COUNT_TESTS[0], dto.getCd4Count().toString());
                Log.i(TAG, "Saved cd4 count investigation record");
                htsService.createInvestigation(investigationDTO, false);
            }

        }
        // patient has already been screened in this visit so @return
    }
}
