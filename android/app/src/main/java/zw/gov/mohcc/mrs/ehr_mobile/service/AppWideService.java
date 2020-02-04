package zw.gov.mohcc.mrs.ehr_mobile.service;

import zw.gov.mohcc.mrs.ehr_mobile.model.vitals.Visit;
import zw.gov.mohcc.mrs.ehr_mobile.persistance.database.EhrMobileDatabase;

/**
 * class only meant to disengage dependencies for critical
 * application dependencies
 */
public class AppWideService {

    private EhrMobileDatabase ehrMobileDatabase;

    public AppWideService(EhrMobileDatabase ehrMobileDatabase) {
        this.ehrMobileDatabase = ehrMobileDatabase;
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
}
