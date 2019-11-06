package zw.gov.mohcc.mrs.ehr_mobile.service;


import android.util.Log;

import androidx.room.Transaction;

import java.util.Date;
import java.util.UUID;

import zw.gov.mohcc.mrs.ehr_mobile.dto.HtsScreeningDTO;
import zw.gov.mohcc.mrs.ehr_mobile.dto.SexualHistoryDTO;
import zw.gov.mohcc.mrs.ehr_mobile.model.SexualHistory;
import zw.gov.mohcc.mrs.ehr_mobile.model.vitals.Visit;
import zw.gov.mohcc.mrs.ehr_mobile.persistance.database.EhrMobileDatabase;
import zw.gov.mohcc.mrs.ehr_mobile.util.DateUtil;

public class HistoryService {

    private final String TAG = "History Service";
    private EhrMobileDatabase ehrMobileDatabase;

    public HistoryService(EhrMobileDatabase ehrMobileDatabase) {
        this.ehrMobileDatabase = ehrMobileDatabase;
    }

    public SexualHistory getSexualHistory(String personId) {

        return ehrMobileDatabase.sexualHistoryDao().findByPersonId(personId);
    }

    public HtsScreeningDTO getHtsScreening() {

        return null;
    }

    @Transaction
    public void saveSexualHistory(SexualHistoryDTO dto) {
        Log.i(TAG, "Saving sexual history object : " + dto);
        ehrMobileDatabase.sexualHistoryDao().save(dto.getInstance(dto));
        Log.i(TAG, "Sexual history record saved for : "+ dto.getPersonId() + " " + ehrMobileDatabase.sexualHistoryDao().findByPersonId(dto.getPersonId()));
    }

    @Transaction
    public void saveHtsScreening(HtsScreeningDTO dto) {

    }
}
