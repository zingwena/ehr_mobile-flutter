package zw.gov.mohcc.mrs.ehr_mobile.service;


import android.util.Log;

import androidx.annotation.NonNull;

import java.util.List;
import java.util.UUID;

import zw.gov.mohcc.mrs.ehr_mobile.model.hts.IndexContact;
import zw.gov.mohcc.mrs.ehr_mobile.model.hts.IndexTest;
import zw.gov.mohcc.mrs.ehr_mobile.persistance.database.EhrMobileDatabase;

public class IndexTestingService {

    private final String TAG = "Index Tracking Service";
    private EhrMobileDatabase ehrMobileDatabase;
    private static IndexTestingService INSTANCE;

    private IndexTestingService(EhrMobileDatabase ehrMobileDatabase) {
        this.ehrMobileDatabase = ehrMobileDatabase;
    }

    public static synchronized IndexTestingService getInstance(EhrMobileDatabase ehrMobileDatabase) {

        if (INSTANCE == null) {
            return new IndexTestingService(ehrMobileDatabase);
        }
        return INSTANCE;
    }

    public String createIndexTest(IndexTest indexTest) {
        String indexTestId = UUID.randomUUID().toString();
        indexTest.setId(indexTestId);
        System.out.println("KKKKKKKKKKKKKKKKKKKKK"+ indexTest.getPersonId());
        Log.i(TAG, "Index Test record : " + indexTest);
        ehrMobileDatabase.indexTestDao().saveOne(indexTest);
        Log.i(TAG, "Saved index test record : " + ehrMobileDatabase.indexTestDao().findByPersonId(indexTest.getPersonId()));
        return indexTestId;
    }

    public IndexTest getIndexTestByPresonId(@NonNull String personId) {

        IndexTest indexTest = ehrMobileDatabase.indexTestDao().findByPersonId(personId);
        Log.i(TAG, "Retrieved index test using person id : " + personId + " And index test record : " + indexTest);
        return indexTest;
    }

    public List<IndexContact> findIndexContactsByPersonId(String personId) {

        List<IndexContact> indexContacts = ehrMobileDatabase.indexContactDao().findByPersonId(personId);
        Log.i(TAG, "Retrieved index contacts using person id : " + personId + " And index contacts records : " + indexContacts);
        return indexContacts;
    }

    public List<IndexContact> findIndexContactsByIndexTestId(String indexTestId) {
        List<IndexContact> indexContacts = ehrMobileDatabase.indexContactDao().findByIndexTestId(indexTestId);
        Log.i(TAG, "Retrieved index contacts using index test id : " + indexTestId + " And index contacts records : " + indexContacts);
        return indexContacts;
    }

    public String createIndexContact(IndexContact indexContact) {
        String indexTestContactId = UUID.randomUUID().toString();
        indexContact.setId(indexTestContactId);
        System.out.println("GGGGGGGGGGGGGGGGGGGGGGGGG INDEX CONTACT PERSON ID "+ indexContact.toString());
        Log.i(TAG, "Index contact record : " + indexTestContactId);
        ehrMobileDatabase.indexContactDao().saveOne(indexContact);
        Log.i(TAG, "Saved index contact record : " + ehrMobileDatabase.indexContactDao().findById(indexContact.getId()));
        return indexTestContactId;
    }

    public IndexContact getIndexContactByPersonId(String personId) {

        return null;
    }
}
