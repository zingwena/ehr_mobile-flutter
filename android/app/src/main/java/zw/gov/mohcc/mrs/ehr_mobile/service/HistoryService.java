package zw.gov.mohcc.mrs.ehr_mobile.service;


import android.util.Log;

import androidx.annotation.NonNull;
import androidx.room.Transaction;

import org.apache.commons.lang3.StringUtils;

import java.util.Arrays;
import java.util.HashSet;
import java.util.Set;
import java.util.UUID;

import zw.gov.mohcc.mrs.ehr_mobile.HtsScreening;
import zw.gov.mohcc.mrs.ehr_mobile.dto.HtsScreeningDTO;
import zw.gov.mohcc.mrs.ehr_mobile.dto.InvestigationDTO;
import zw.gov.mohcc.mrs.ehr_mobile.dto.SexualHistoryDTO;
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

        return null;
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
