package zw.gov.mohcc.mrs.ehr_mobile.service;


import android.util.Log;

import java.util.List;
import java.util.UUID;

import zw.gov.mohcc.mrs.ehr_mobile.model.IndexContact;
import zw.gov.mohcc.mrs.ehr_mobile.model.IndexTest;
import zw.gov.mohcc.mrs.ehr_mobile.persistance.database.EhrMobileDatabase;

public class IndexTestingService {

    private final String TAG = "Index Tracking Service";
    private EhrMobileDatabase ehrMobileDatabase;

    public IndexTestingService(EhrMobileDatabase ehrMobileDatabase) {
        this.ehrMobileDatabase = ehrMobileDatabase;
    }

    public String createIndexTest(IndexTest indexTest) {
        String indexTestId = UUID.randomUUID().toString();
        indexTest.setId(indexTestId);
        Log.i(TAG, "Index Test record : " + indexTest);
        ehrMobileDatabase.indexTestDao().saveOne(indexTest);
        Log.i(TAG, "Saved index test record : " + ehrMobileDatabase.indexTestDao().findByPersonId(indexTest.getPersonId()));
        return indexTestId;
    }

    public IndexTest getIndexTestByPresonId(String personId) {

        return ehrMobileDatabase.indexTestDao().findByPersonId(personId);
    }

    public List<IndexContact> findIndexContactsByPersonId(String personId) {

        return null;
    }

    public List<IndexContact> findIndexContactsByIndexTestId(String indexTestId) {

        return null;
    }

    public String createIndexContact(IndexContact indexContact) {

        return null;
    }

    public IndexContact getIndexContactByPersonId(String personId) {

        return null;
    }
}
