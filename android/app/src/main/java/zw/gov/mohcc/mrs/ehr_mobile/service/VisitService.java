package zw.gov.mohcc.mrs.ehr_mobile.service;


import android.util.Log;

import java.util.Date;
import java.util.UUID;

import zw.gov.mohcc.mrs.ehr_mobile.model.vitals.Visit;
import zw.gov.mohcc.mrs.ehr_mobile.persistance.database.EhrMobileDatabase;
import zw.gov.mohcc.mrs.ehr_mobile.util.DateUtil;

public class VisitService {

    private final String TAG = "Visit Service";
    private EhrMobileDatabase ehrMobileDatabase;

    public VisitService(EhrMobileDatabase ehrMobileDatabase) {
        this.ehrMobileDatabase = ehrMobileDatabase;
    }

    public String getCurrentVisit(String personId) {

        Visit visit = ehrMobileDatabase.visitDao().findByPersonVisit(personId, DateUtil.getStartOfDay(new Date()).getTime());
        Log.d(TAG, "Visit retrieved " + visit);
        if (visit != null) {
            return visit.getId();
        }
        String visitId = UUID.randomUUID().toString();
        visit = new Visit(visitId, personId, new Date(), DateUtil.getEndOfDay(new Date()));
        ehrMobileDatabase.visitDao().insert(visit);
        return visitId;
    }
}
