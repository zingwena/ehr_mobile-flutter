package zw.gov.mohcc.mrs.ehr_mobile.service;


import android.util.Log;

import androidx.annotation.NonNull;
import androidx.room.Transaction;

import org.apache.commons.lang3.StringUtils;

import java.util.Arrays;
import java.util.HashSet;
import java.util.Set;
import java.util.UUID;

import zw.gov.mohcc.mrs.ehr_mobile.model.HtsScreening;
import zw.gov.mohcc.mrs.ehr_mobile.dto.HtsScreeningDTO;
import zw.gov.mohcc.mrs.ehr_mobile.dto.InvestigationDTO;
import zw.gov.mohcc.mrs.ehr_mobile.dto.SexualHistoryDTO;
import zw.gov.mohcc.mrs.ehr_mobile.model.ActivityStatus;
import zw.gov.mohcc.mrs.ehr_mobile.model.Art;
import zw.gov.mohcc.mrs.ehr_mobile.model.Hts;
import zw.gov.mohcc.mrs.ehr_mobile.model.LaboratoryInvestigation;
import zw.gov.mohcc.mrs.ehr_mobile.model.PersonInvestigation;
import zw.gov.mohcc.mrs.ehr_mobile.model.SexualHistory;
import zw.gov.mohcc.mrs.ehr_mobile.model.vitals.Visit;
import zw.gov.mohcc.mrs.ehr_mobile.persistance.database.EhrMobileDatabase;

public class HistoryService {

    private final String TAG = "History Service";
    private EhrMobileDatabase ehrMobileDatabase;
    private HtsService htsService;

    public HistoryService(EhrMobileDatabase ehrMobileDatabase, HtsService htsService) {
        this.ehrMobileDatabase = ehrMobileDatabase;
        this.htsService = htsService;
    }

    public SexualHistory getSexualHistory(String personId) {

        return ehrMobileDatabase.sexualHistoryDao().findByPersonId(personId);
    }

    public boolean existsByPersonId(String personId) {
        return ehrMobileDatabase.htsDao().countByPersonId(personId) >=1;
    }

    public HtsScreeningDTO getHtsScreening(String currentVisitId) {

        // check in system if patient has ever been tested if yes return @false check in
        // screening
        boolean testingCompletedInCurrentRun = false;
        final String personId = ehrMobileDatabase.visitDao().findById(currentVisitId).getPersonId();
        if (existsByPersonId(personId)) {
            // testing has been initiated in current run so hts is never going to be null
            Hts hts = ehrMobileDatabase.htsDao().findLatestHts(personId);
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
        final String negativeHivResult = "41d3c273-fd7d-11e6-9840-000c29c7ff5e";
        final Set<String> hivTests = new HashSet<>(Arrays.asList(
                new String[]{"36069471-adee-11e7-b30f-3372a2d8551e", "ee7d91fc-b27f-11e8-b121-c48e8faf029b"}));

        PersonInvestigation personInvestigation = ehrMobileDatabase.personInvestigationDao()
                .findTopByPersonIdAndResultNameAndInvestigationIdInOrderByDateDesc(personId, negativeHivResult, hivTests);


        if (testingCompletedInCurrentRun) {
            dto = new HtsScreeningDTO();
            dto.setTestedBefore(true);
            // retrieve last HTS record
            Hts hts = ehrMobileDatabase.htsDao().findLatestHts(personId);
            dto.setDateLastTested(hts.getDateOfHivTest());
            // retrieve the result of this test
            LaboratoryInvestigation laboratoryInvestigation = ehrMobileDatabase.laboratoryInvestigationDao()
                    .findLaboratoryInvestigationById(hts.getLaboratoryInvestigationId());
            personInvestigation = ehrMobileDatabase.personInvestigationDao().findPersonInvestigationById(laboratoryInvestigation.getPersonInvestigationId());
            dto.setResult(personInvestigation.getResultId());

        }
        // patient has already done hts screening previously and has no test in EHR &lt
        // important buggy section
        HtsScreening htsScreening = ehrMobileDatabase.htsScreeningDao().findByVisitId(currentVisitId);
        if (htsScreening != null && !testingCompletedInCurrentRun) {
            if (dto == null) {
                dto = new HtsScreeningDTO();
            }
            dto.setArt(htsScreening.getArt());
            dto.setArtNumber(htsScreening.getArtNumber());
            dto.setDateLastTested(htsScreening.getDateLastTested());
            dto.setTestedBefore(htsScreening.isTestedBefore());
            dto.setResult(htsScreening.getResult());
            dto.setViralLoadDone(htsScreening.getViralLoadDone());
            dto.setCd4Done(htsScreening.getCd4Done());
        }

        // check art details it must also work if patient is on art while not having
        // been tested in EHR
        Art art = ehrMobileDatabase.artRegistrationDao().findByPersonId(personId);
        if (art != null) {
            if (dto == null) {
                dto = new HtsScreeningDTO();
            }
            dto.setArt(true);
            dto.setArtNumber(art.getOiArtNumber());
            dto.setDateEnrolled(art.getDateOfEnrolmentIntoCare());
        }
        // retrieve tests for viral load and cd4 count
        final Set<String> viralLoadTests = new HashSet<>(Arrays.asList(
                new String[]{"36069624-adee-11e7-b30f-3372a2d8551e", "360696a5-adee-11e7-b30f-3372a2d8551e"}));

        PersonInvestigation viralLoadInvestigation = ehrMobileDatabase.personInvestigationDao()
                .findTopByPersonIdAndInvestigationIdInOrderByDateDesc(personId, viralLoadTests);

        if (viralLoadInvestigation != null) {
            if (dto == null) {
                dto = new HtsScreeningDTO();
            }
            dto.setViralLoadDone(ActivityStatus.DONE);
            dto.setViralLoad(StringUtils.isNoneBlank(viralLoadInvestigation.getResultId())
                    ? Integer.valueOf(viralLoadInvestigation.getResultId())
                    : null);
            dto.setViralLoadDate(viralLoadInvestigation.getDate());
        }

        final Set<String> cd4CountTests = new HashSet<>(
                Arrays.asList(new String[]{"36069a11-adee-11e7-b30f-3372a2d8551e"}));

        PersonInvestigation cd4CountInvestigation = ehrMobileDatabase.personInvestigationDao()
                .findTopByPersonIdAndInvestigationIdInOrderByDateDesc(personId, cd4CountTests);

        if (cd4CountInvestigation != null) {
            if (dto == null) {
                dto = new HtsScreeningDTO();
            }
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
            dto.setDateLastNegative(personInvestigation.getDate());
        }

        return dto;
    }

    @Transaction
    public void saveSexualHistory(SexualHistoryDTO dto) {
        Log.i(TAG, "Saving sexual history object : " + dto);
        ehrMobileDatabase.sexualHistoryDao().save(dto.getInstance(dto));
        Log.i(TAG, "Sexual history record saved for : "+ dto.getPersonId() + " " + ehrMobileDatabase.sexualHistoryDao().findByPersonId(dto.getPersonId()));
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
                Art art = ehrMobileDatabase.artRegistrationDao().findByPersonId(visit.getPersonId());
                if (art == null) {
                    // create art record
                    Log.i(TAG, "Creating art record");
                    ehrMobileDatabase.artRegistrationDao().createArtRegistration(dto.getArtInstance(dto, visit.getPersonId()));
                    Log.i(TAG, "Saved art record : " + ehrMobileDatabase.artRegistrationDao().findByPersonId(visit.getPersonId()));
                }
            }

            // create history items
            Log.i(TAG, "Now creating history records if any");
            final String personId = ehrMobileDatabase.visitDao().findById(visitId).getPersonId();
            // hiv
            if (dto.isTestedBefore()) {
                Log.i(TAG, "Positive HIV tests");
                //String personId, Date dateOfTest, String visitId, String investigationId, String result
                InvestigationDTO investigationDTO = new InvestigationDTO(personId, dto.getDateLastTested(), visitId,
                        "36069471-adee-11e7-b30f-3372a2d8551e", dto.getResult());
                Log.i(TAG, "Saving investigation record ");
                htsService.createInvestigation(investigationDTO);
            }
            // if date last negative is completed
            if (dto.isTestedBefore() && dto.getDateLastNegative() != null) {
                Log.i(TAG, "Negative HIV tests");
                InvestigationDTO investigationDTO = new InvestigationDTO(personId, dto.getDateLastTested(), visitId,
                        "36069471-adee-11e7-b30f-3372a2d8551e", "41d3c273-fd7d-11e6-9840-000c29c7ff5e");
                Log.i(TAG, "Saving negative hiv test investigation record ");
            }
            // viral load
            if (dto.getViralLoad() != null && dto.getViralLoadDate() != null) {
                Log.i(TAG, "Viral load tests");
                InvestigationDTO investigationDTO = new InvestigationDTO(personId, dto.getViralLoadDate(), visitId,
                        "36069624-adee-11e7-b30f-3372a2d8551e", dto.getViralLoad().toString());
                Log.i(TAG, "Saved viral load investigation record");
            }

            // cd4 count
            if (dto.getCd4Count() != null && dto.getCd4CountDate() != null) {
                Log.i(TAG, "Cd4 count tests");
                InvestigationDTO investigationDTO = new InvestigationDTO(personId, dto.getCd4CountDate(), visitId,
                        "36069a11-adee-11e7-b30f-3372a2d8551e", dto.getCd4Count().toString());
                Log.i(TAG, "Saved cd4 count investigation record");
            };

        }
        // patient has already been screened in this visit so @return
    }
}
