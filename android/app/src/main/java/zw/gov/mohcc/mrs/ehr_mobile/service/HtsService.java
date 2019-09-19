package zw.gov.mohcc.mrs.ehr_mobile.service;

import android.util.Log;

import androidx.room.Transaction;

import java.util.UUID;

import zw.gov.mohcc.mrs.ehr_mobile.dto.HtsRegDTO;
import zw.gov.mohcc.mrs.ehr_mobile.model.Hts;
import zw.gov.mohcc.mrs.ehr_mobile.model.LaboratoryInvestigation;
import zw.gov.mohcc.mrs.ehr_mobile.model.PersonInvestigation;
import zw.gov.mohcc.mrs.ehr_mobile.model.vitals.Visit;
import zw.gov.mohcc.mrs.ehr_mobile.persistance.database.EhrMobileDatabase;

public class HtsService {

    private final String TAG = "Hts Service";
    private EhrMobileDatabase ehrMobileDatabase;

    public HtsService(EhrMobileDatabase ehrMobileDatabase) {
        this.ehrMobileDatabase = ehrMobileDatabase;
    }

    @Transaction
    public String createHts(HtsRegDTO dto) {

        Log.i(TAG, "Creating HTS record");
        Hts hts = HtsRegDTO.getInstance(dto);
        ehrMobileDatabase.htsDao().createHts(hts);
        Log.i(TAG, "Created hts record : "+ ehrMobileDatabase.htsDao().findHtsById(hts.getId()));
        Log.i(TAG, "Creating Person Investigation record");
        String personInvestigationId = UUID.randomUUID().toString();
        PersonInvestigation personInvestigation = new PersonInvestigation(personInvestigationId, dto.getPersonId(),
                "36069471-adee-11e7-b30f-3372a2d8551e", dto.getDateOfHivTest());
        ehrMobileDatabase.personInvestigationDao().insertPersonInvestigation(personInvestigation);
        Log.i(TAG, "Saved person investigation record : "+ ehrMobileDatabase.personInvestigationDao().findPersonInvestigationById(personInvestigationId));
        Log.i(TAG, "Creating loboratory investigation record");
        String laboratoryInvestigationId = UUID.randomUUID().toString();
        LaboratoryInvestigation laboratoryInvestigation = new LaboratoryInvestigation(laboratoryInvestigationId, "ZW000A01", personInvestigationId);
        ehrMobileDatabase.laboratoryInvestigationDao().createLaboratoryInvestigation(laboratoryInvestigation);
        Log.d(TAG, "Created laboratory investigation : "+ ehrMobileDatabase.laboratoryInvestigationDao().findLaboratoryInvestigationById(laboratoryInvestigationId));
        return hts.getId();
    }
}
