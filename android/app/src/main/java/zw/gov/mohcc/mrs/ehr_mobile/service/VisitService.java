package zw.gov.mohcc.mrs.ehr_mobile.service;


import android.util.Log;

import androidx.room.Transaction;

import java.util.Date;
import java.util.List;
import java.util.UUID;

import zw.gov.mohcc.mrs.ehr_mobile.dto.InPatientDTO;
import zw.gov.mohcc.mrs.ehr_mobile.dto.OutPatientDTO;
import zw.gov.mohcc.mrs.ehr_mobile.enumeration.PatientType;
import zw.gov.mohcc.mrs.ehr_mobile.model.FacilityWard;
import zw.gov.mohcc.mrs.ehr_mobile.model.PatientQueue;
import zw.gov.mohcc.mrs.ehr_mobile.model.vitals.FacilityQueue;
import zw.gov.mohcc.mrs.ehr_mobile.model.vitals.Visit;
import zw.gov.mohcc.mrs.ehr_mobile.persistance.database.EhrMobileDatabase;
import zw.gov.mohcc.mrs.ehr_mobile.util.DateUtil;

public class VisitService {

    private final String TAG = "Visit Service";
    private EhrMobileDatabase ehrMobileDatabase;
    private SiteService siteService;

    public VisitService(EhrMobileDatabase ehrMobileDatabase, SiteService siteService) {
        this.ehrMobileDatabase = ehrMobileDatabase;
        this.siteService = siteService;
    }

    public List<FacilityQueue> getFacilityQueues() {

        return ehrMobileDatabase.facilityQueueDao().findAll();
    }

    public List<FacilityWard> getFacilityWards() {

        return ehrMobileDatabase.facilityWardDao().findAll();
    }

    public PatientQueue getPatientQueue(String personId) {
        Visit visit = getVisit(personId);
        if (visit == null) {
            return null;
        }
        return ehrMobileDatabase.patientQueueDao().findByVisitId(visit.getId());
    }

    public Visit getVisit(String personId) {

        return ehrMobileDatabase.visitDao().findByPersonIdAndTypeAndDischargedIsNull(
                personId, PatientType.OUTPATIENT);
    }

    public String getCurrentVisit(String personId) {

        Visit visit = getVisit(personId);
        if (visit != null) {
            return visit.getId();
        }
        return null;
    }

    private void dischargePatient(String visitId, Date dischargedDate) {

        Log.d(TAG, "Discharging patient process");
        Visit visit = ehrMobileDatabase.visitDao().findById(visitId);
        Log.d(TAG, "Retrived currently active visit : " + visit);
        visit.setDischarged(dischargedDate);

        ehrMobileDatabase.visitDao().update(visit);
        Log.d(TAG, "Updated patient visit, visit now dicharged : " + visit);

        if (ehrMobileDatabase.patientQueueDao().existsByVisitId(visitId) >= 1) {

            ehrMobileDatabase.patientQueueDao().deleteByVisitid(visitId);
            Log.d(TAG, "Removed patient from out patient queue : " + visit);
        }

        if (ehrMobileDatabase.patientWardDao().existsByVisitId(visitId) >= 1) {

            ehrMobileDatabase.patientWardDao().deleteByVisitid(visitId);
            Log.d(TAG, "Removed patient from in patient queue : " + visit);
        }

    }

    @Transaction
    public String onOutPatientAdmitted(OutPatientDTO dto) {
        Log.d(TAG, "Admitted out patient");

        Visit inPatientRecord = ehrMobileDatabase.visitDao().findByPersonIdAndTypeAndDischargedIsNull(
                dto.getPersonId(), PatientType.INPATIENT);

        Log.d(TAG, "In patient record retrieved : " + inPatientRecord);

        if (inPatientRecord != null) {
            dischargePatient(inPatientRecord.getId(), new Date());
        }

        Visit visit = new Visit(UUID.randomUUID().toString(), dto.getPersonId(), PatientType.OUTPATIENT, new Date());

        visit.setFacility(siteService.getFacilityDetails());
        Log.d(TAG, "Visit after visit has been constructed : " + visit);

        ehrMobileDatabase.visitDao().insert(visit);
        return visit.getId();
    }

    /*@EventHandler
    public void onInPatientAdmitted(InPatientAdmitted event) {

        if (event.getOutPatientId() != null) {
            dischargePatient(event.getOutPatientId().toString(), event.getTime().toLocalDate());
        }

        Patient patient = patientMapper.inPatientAdmittedToEntity(event);

        patient.setType(PatientType.INPATIENT);

        Facility facility = null;

        if (event.getFacilityId() != null) {
            facility = facilityRepository.findOne(event.getFacilityId());
        }

        if (facility != null) {
            patient.setFacility(new Identifiable(facility.getFacilityId(), facility.getName()));
        } else {
            patient.setFacility(null);
        }

        patientRepository.save(patient);

    }

    @EventHandler
    public void onOutPatientRegistered(OutPatientRegistered event) {
        Patient patient = patientRepository.findOne(event.getPatientId().toString());

        if (patient != null) {
            patient.setHospitalNumber(event.getHospitalNumber());

            patientRepository.save(patient);

        }
    }



@EventHandler
    @Transactional
    public void onPatientDischarged(PatientDischarged event, @MetaDataValue("time") String timestamp) {
        log.debug("Discharge patient");

        LocalDateTime time = Utils.toLocalDateTime(timestamp);

        Patient patient = patientRepository.findOne(event.getPatientId().toString());

        if (patient == null) {
            return;
        }

        if (patient != null && patient.getDischarged() != null) {
            if (patientQueueRepository.existsByPatientPatientId(event.getPatientId().toString())) {
                patientQueueRepository.delete(event.getPatientId().toString());
            }
            if (patientWardRepository.existsByPatientPatientId(event.getPatientId().toString())) {
                patientWardRepository.delete(event.getPatientId().toString());
            }
        }

        dischargePatient(event.getPatientId().toString(),
                time != null ? time.toLocalDate() : patient.getTime().toLocalDate());

    }

    @EventHandler
    @Transactional
    public void onPatientQueueChanged(PatientQueueChanged event) {

        String queue = queueRepository.findOne(event.getQueueId()).getName();

        if (!patientRepository.exists(event.getPatientId().toString())) {
            return;
        }

        PatientQueue patientQueue = new PatientQueue(event.getPatientId().toString(),
                new Patient(event.getPatientId().toString()), new Identifiable(event.getQueueId(), queue));

        patientQueueRepository.save(patientQueue);

    }

    @EventHandler
    @Transactional
    public void onPatientWardChanged(PatientWardChanged event) {

        String ward = wardRepository.findOne(event.getWardId()).getName();

        if (!patientRepository.exists(event.getPatientId().toString())) {
            return;
        }

        PatientWard patientWard = new PatientWard(event.getPatientId().toString(),
                new Patient(event.getPatientId().toString()), new Identifiable(event.getWardId(), ward));

        patientWardRepository.save(patientWard);

    }
     */
}
