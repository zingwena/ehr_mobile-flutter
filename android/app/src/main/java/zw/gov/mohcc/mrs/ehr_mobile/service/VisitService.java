package zw.gov.mohcc.mrs.ehr_mobile.service;


import android.util.Log;

import java.util.Date;
import java.util.UUID;

import zw.gov.mohcc.mrs.ehr_mobile.model.vitals.Visit;
import zw.gov.mohcc.mrs.ehr_mobile.persistance.database.EhrMobileDatabase;
import zw.gov.mohcc.mrs.ehr_mobile.util.DateUtil;

public class VisitService {

    private EhrMobileDatabase ehrMobileDatabase;
    private final String TAG = "Visit Service";

    public VisitService(EhrMobileDatabase ehrMobileDatabase) {
        this.ehrMobileDatabase = ehrMobileDatabase;
    }

    public String getCurrentVisit(String personId) {

        Visit visit = ehrMobileDatabase.visitDao().findByPersonVisit(personId, DateUtil.getStartOfDay(new Date()),
                DateUtil.getEndOfDay(new Date()));
        Log.d(TAG, "Visit retrieved " + visit);
        if (visit == null) {
            visit = new Visit(UUID.randomUUID().toString(), personId, new Date());
            return ehrMobileDatabase.visitDao().insert(visit);
        }
        return visit.getVisitId();
    }
}
