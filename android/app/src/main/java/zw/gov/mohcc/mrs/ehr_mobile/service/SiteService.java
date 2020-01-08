package zw.gov.mohcc.mrs.ehr_mobile.service;


import android.util.Log;

import androidx.room.Transaction;

import java.util.List;

import zw.gov.mohcc.mrs.ehr_mobile.model.FacilityWard;
import zw.gov.mohcc.mrs.ehr_mobile.model.terminology.NameCode;
import zw.gov.mohcc.mrs.ehr_mobile.model.terminology.SiteSetting;
import zw.gov.mohcc.mrs.ehr_mobile.model.vitals.FacilityQueue;
import zw.gov.mohcc.mrs.ehr_mobile.model.warehouse.TestKitBatchIssue;
import zw.gov.mohcc.mrs.ehr_mobile.persistance.database.EhrMobileDatabase;

public class SiteService {

    private final String TAG = "Site Service";
    private EhrMobileDatabase ehrMobileDatabase;

    public SiteService(EhrMobileDatabase ehrMobileDatabase) {
        this.ehrMobileDatabase = ehrMobileDatabase;
    }

    public NameCode getFacilityDetails() {

        SiteSetting siteSetting = ehrMobileDatabase.siteSettingDao().findAll().get(0);
        Log.d(TAG,"Site Setting retrieved : " + siteSetting);
        return new NameCode(siteSetting.getId(), siteSetting.getName());
    }

    @Transaction
    public void saveFacilityQueue(FacilityQueue facilityQueue, List<TestKitBatchIssue> testKitBatchIssues) {

        Log.d(TAG, "Entering savefacilityqueue method");
        Log.d(TAG, "Facility Queue State : " + facilityQueue);
        Log.d(TAG, "Testkit Batch Issue State : " + testKitBatchIssues);
        ehrMobileDatabase.facilityQueueDao().saveOne(facilityQueue);
        ehrMobileDatabase.testKitBatchIssueDao().save(testKitBatchIssues.get(0));
        Log.d(TAG,"Facility queue and testkit batch saved successifully");
    }

    @Transaction
    public void saveFacilityWard(FacilityWard facilityWard, List<TestKitBatchIssue> testKitBatchIssues) {

        Log.d(TAG, "Entering save facility ward method");
        Log.d(TAG, "Facility Ward State : " + facilityWard);
        Log.d(TAG, "Testkit Batch Issue State : " + testKitBatchIssues);
        ehrMobileDatabase.facilityWardDao().saveOne(facilityWard);
        //ehrMobileDatabase.testKitBatchIssueDao().saveAll(testKitBatchIssues);
        Log.d(TAG,"Facility ward and testkit batch saved successifully");
    }
}
