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

        Log.i(TAG, "Person ID used in HTS : " + personId);

        Visit visit = getVisit(personId);
        if (visit != null) {
            return visit.getId();
        }
        String visitId = UUID.randomUUID().toString();
        visit = new Visit(visitId, personId, DateUtil.getStartOfDay(new Date()), DateUtil.getEndOfDay(new Date()));
        ehrMobileDatabase.visitDao().insert(visit);
        return visitId;
    }

    public Visit getVisit(String personId) {

        Visit visit = ehrMobileDatabase.visitDao().findByPersonVisit(personId, new Date().getTime());

        Log.d(TAG, "All visits in database : "+ ehrMobileDatabase.visitDao().getAll().toString());

        Log.d(TAG, "Visit retrieved " + visit);
        return visit;
    }
}
