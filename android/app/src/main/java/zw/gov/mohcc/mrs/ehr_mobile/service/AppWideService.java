package zw.gov.mohcc.mrs.ehr_mobile.service;

import zw.gov.mohcc.mrs.ehr_mobile.model.PatientQueue;
import zw.gov.mohcc.mrs.ehr_mobile.model.PatientWard;
import zw.gov.mohcc.mrs.ehr_mobile.model.vitals.Visit;
import zw.gov.mohcc.mrs.ehr_mobile.persistance.database.EhrMobileDatabase;

/**
 * class only meant to disengage dependencies for critical
 * application dependencies
 */
public class AppWideService {

    private EhrMobileDatabase ehrMobileDatabase;
    private static AppWideService INSTANCE;

    private AppWideService(EhrMobileDatabase ehrMobileDatabase) {
        this.ehrMobileDatabase = ehrMobileDatabase;
    }

    public static synchronized AppWideService getInstance(EhrMobileDatabase ehrMobileDatabase) {

        if (INSTANCE == null) {
            return new AppWideService(ehrMobileDatabase);
        }
        return INSTANCE;
    }

    public Visit getVisit(String personId) {

        return ehrMobileDatabase.visitDao().findByPersonIdAndDischargedIsNull(personId);
    }

    public String getCurrentVisit(String personId) {

        Visit visit = getVisit(personId);
        if (visit != null) {
            return visit.getId();
        }
        return null;
    }

    public PatientQueue getPatientQueue(String personId) {
        Visit visit = getVisit(personId);
        if (visit == null) {
            return null;
        }
        return ehrMobileDatabase.patientQueueDao().findByVisitId(visit.getId());
    }

    public PatientWard getPatientWard(String personId) {
        Visit visit = getVisit(personId);
        if (visit == null) {
            return null;
        }
        return ehrMobileDatabase.patientWardDao().findByVisitId(visit.getId());
    }
}
