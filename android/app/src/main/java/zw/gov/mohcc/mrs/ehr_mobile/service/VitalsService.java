package zw.gov.mohcc.mrs.ehr_mobile.service;


import zw.gov.mohcc.mrs.ehr_mobile.persistance.database.EhrMobileDatabase;

public class VitalsService {

    private final String TAG = "Visit Service";
    private EhrMobileDatabase ehrMobileDatabase;

    public VitalsService(EhrMobileDatabase ehrMobileDatabase) {
        this.ehrMobileDatabase = ehrMobileDatabase;
    }


}