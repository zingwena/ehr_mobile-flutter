package zw.gov.mohcc.mrs.ehr_mobile.service;


import android.util.Log;

import zw.gov.mohcc.mrs.ehr_mobile.model.terminology.NameCode;
import zw.gov.mohcc.mrs.ehr_mobile.model.terminology.SiteSetting;
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
}
