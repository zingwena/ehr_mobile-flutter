package zw.gov.mohcc.mrs.ehr_mobile.service;


import zw.gov.mohcc.mrs.ehr_mobile.persistance.database.EhrMobileDatabase;

public class PersonService {

    private final String TAG = "Visit Service";
    private EhrMobileDatabase ehrMobileDatabase;

    public PersonService(EhrMobileDatabase ehrMobileDatabase) {
        this.ehrMobileDatabase = ehrMobileDatabase;
    }
}
