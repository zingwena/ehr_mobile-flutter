package zw.gov.mohcc.mrs.ehr_mobile.service;


import android.util.Log;

import androidx.room.Transaction;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.UUID;

import zw.gov.mohcc.mrs.ehr_mobile.dto.ArtDTO;
import zw.gov.mohcc.mrs.ehr_mobile.dto.InPatientDTO;
import zw.gov.mohcc.mrs.ehr_mobile.dto.OutPatientDTO;
import zw.gov.mohcc.mrs.ehr_mobile.dto.PatientSummaryDTO;
import zw.gov.mohcc.mrs.ehr_mobile.enumeration.PatientType;
import zw.gov.mohcc.mrs.ehr_mobile.model.FacilityWard;
import zw.gov.mohcc.mrs.ehr_mobile.model.PatientQueue;
import zw.gov.mohcc.mrs.ehr_mobile.model.PatientWard;
import zw.gov.mohcc.mrs.ehr_mobile.model.art.ArtCurrentStatus;
import zw.gov.mohcc.mrs.ehr_mobile.model.laboratory.PersonInvestigation;
import zw.gov.mohcc.mrs.ehr_mobile.model.terminology.Investigation;
import zw.gov.mohcc.mrs.ehr_mobile.model.vitals.BloodPressure;
import zw.gov.mohcc.mrs.ehr_mobile.model.FacilityQueue;
import zw.gov.mohcc.mrs.ehr_mobile.model.vitals.Height;
import zw.gov.mohcc.mrs.ehr_mobile.model.vitals.Pulse;
import zw.gov.mohcc.mrs.ehr_mobile.model.vitals.RespiratoryRate;
import zw.gov.mohcc.mrs.ehr_mobile.model.vitals.Temperature;
import zw.gov.mohcc.mrs.ehr_mobile.model.Visit;
import zw.gov.mohcc.mrs.ehr_mobile.model.vitals.Weight;
import zw.gov.mohcc.mrs.ehr_mobile.persistance.database.EhrMobileDatabase;

public class VisitService {

    private static VisitService INSTANCE;
    private final String TAG = "Visit Service";
    private EhrMobileDatabase ehrMobileDatabase;
    private SiteService siteService;
    private ArtService artService;
    private AppWideService appWideService;

    private VisitService(EhrMobileDatabase ehrMobileDatabase, SiteService siteService, ArtService artService, AppWideService appWideService) {
        this.ehrMobileDatabase = ehrMobileDatabase;
        this.siteService = siteService;
        this.artService = artService;
        this.appWideService = appWideService;
    }

    public static synchronized VisitService getInstance(EhrMobileDatabase ehrMobileDatabase, SiteService siteService, ArtService artService, AppWideService appWideService) {

        if (INSTANCE == null) {
            return new VisitService(ehrMobileDatabase, siteService, artService, appWideService);
        }
        return INSTANCE;
    }

    public List<FacilityQueue> getFacilityQueues() {

        return ehrMobileDatabase.facilityQueueDao().findAll();
    }

    public List<FacilityWard> getFacilityWards() {

        return ehrMobileDatabase.facilityWardDao().findAll();
    }

    public void dischargePatient(String visitId, Date dischargedDate) {

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
        // add patient to queue
        Log.d(TAG, "Adding current patient to queue");
        PatientQueue patientQueue = new PatientQueue(UUID.randomUUID().toString(), visit.getId(), dto.getQueue());
        ehrMobileDatabase.patientQueueDao().saveOne(patientQueue);
        Log.d(TAG, "Patient queue record saved");
        return visit.getId();
    }

    @Transaction
    public String onInPatientAdmitted(InPatientDTO dto) {
        Log.d(TAG, "Admitted in patient");

        Visit outPatientRecord = ehrMobileDatabase.visitDao().findByPersonIdAndTypeAndDischargedIsNull(
                dto.getPersonId(), PatientType.OUTPATIENT);

        Log.d(TAG, "In patient record retrieved : " + outPatientRecord);

        if (outPatientRecord != null) {
            dischargePatient(outPatientRecord.getId(), new Date());
        }

        Visit visit = new Visit(UUID.randomUUID().toString(), dto.getPersonId(), PatientType.INPATIENT, new Date());

        visit.setFacility(siteService.getFacilityDetails());

        ehrMobileDatabase.visitDao().insert(visit);
        // add patient to queue
        Log.d(TAG, "Adding current patient to ward");
        PatientWard patientWard = new PatientWard(UUID.randomUUID().toString(), visit.getId(), dto.getWard());
        ehrMobileDatabase.patientWardDao().saveOne(patientWard);
        Log.d(TAG, "Patient ward record saved");
        return visit.getId();
    }

    public String onPatientQueueChanged(OutPatientDTO dto) {

        Log.d(TAG, "Changing patient queue " + dto);
        // just go ahead and update current patient queue
        Visit visit = appWideService.getVisit(dto.getPersonId());
        if (visit == null) {
            Log.d(TAG, "Patient must have an active visit at this stage");
            throw new IllegalStateException("Patient is expected to have an active visit at this stage : " + visit);
        }
        PatientQueue patientQueue = ehrMobileDatabase.patientQueueDao().findByVisitId(visit.getId());
        Log.d(TAG, "Retrieved patient queue record : " + patientQueue);
        patientQueue.setQueue(dto.getQueue());

        ehrMobileDatabase.patientQueueDao().update(patientQueue);
        Log.d(TAG, "Patient queue successifuly changed");

        return patientQueue.getId();
    }

    public String onPatientWardChanged(InPatientDTO dto) {

        Log.d(TAG, "Changing patient ward " + dto);
        // just go ahead and update current patient ward
        Visit visit = appWideService.getVisit(dto.getPersonId());
        if (visit == null) {
            Log.d(TAG, "Patient must have an active visit at this stage");
            throw new IllegalStateException("Patient is expected to have an active visit at this stage : " + visit);
        }
        PatientWard patientWard = ehrMobileDatabase.patientWardDao().findByVisitId(visit.getId());
        Log.d(TAG, "Retrieved patient ward record : " + patientWard);
        patientWard.setWard(dto.getWard());

        ehrMobileDatabase.patientWardDao().update(patientWard);
        Log.d(TAG, "Patient ward successifuly changed");

        return patientWard.getId();
    }

    public PatientSummaryDTO getPatientSummary(String personId) {

        Log.d(TAG, "Creating patient summary object");
        PatientSummaryDTO summary = new PatientSummaryDTO();
        Temperature temperature = ehrMobileDatabase.temperatureDao().findLatestRecordByPersonId(personId);
        Log.d(TAG, "Retrieved latest patient temperature record : " + temperature);
        if (temperature != null) {
            summary.setTemperature(new PatientSummaryDTO.ValueDate(temperature.getValue(), temperature.getDateTime()));
        }
        Pulse pulse = ehrMobileDatabase.pulseDao().findLatestRecordByPersonId(personId);
        Log.d(TAG, "Retrieved latest patient pulse record : " + pulse);
        if (pulse != null) {
            summary.setPulse(new PatientSummaryDTO.ValueDate(pulse.getValue(), pulse.getDateTime()));
        }
        BloodPressure bloodPressure = ehrMobileDatabase.bloodPressureDao().findLatestRecordByPersonId(personId);
        Log.d(TAG, "Retrieved latest patient bloodPressure record : " + bloodPressure);
        if (bloodPressure != null) {
            summary.setBloodPressure(new PatientSummaryDTO.ValueDate(
                    bloodPressure.getSystolic(), bloodPressure.getDiastolic(), bloodPressure.getDateTime()));
        }
        Weight weight = ehrMobileDatabase.weightDao().findLatestRecordByPersonId(personId);
        Log.d(TAG, "Retrieved latest patient weight record : " + weight);
        if (weight != null) {
            summary.setWeight(new PatientSummaryDTO.ValueDate(weight.getValue(), weight.getDateTime()));
        }
        Height height = ehrMobileDatabase.heightDao().findLatestRecordByPersonId(personId);
        Log.d(TAG, "Retrieved latest patient height record : " + height);
        if (height != null) {
            summary.setHeight(new PatientSummaryDTO.ValueDate(height.getValue(), height.getDateTime()));
        }
        RespiratoryRate respiratoryRate = ehrMobileDatabase.respiratoryRateDao().findLatestRecordByPersonId(personId);
        Log.d(TAG, "Retrieved latest patient respiratoryRate record : " + respiratoryRate);
        if (respiratoryRate != null) {
            summary.setRespiratoryRate(new PatientSummaryDTO.ValueDate(respiratoryRate.getValue(), respiratoryRate.getDateTime()));
        }
        ArtDTO art = artService.getArt(personId);
        Log.d(TAG, "Retrieved patient art record : " + art);
        if (art != null) {
            ArtCurrentStatus artCurrentStatus = ehrMobileDatabase.artCurrentStatusDao().findByVisitId(personId);
            String arvRegimen = "";
            if (artCurrentStatus != null) {
                arvRegimen = ehrMobileDatabase.arvCombinationRegimenDao().findById(artCurrentStatus.getRegimen().getCode()).getName();
            }
            Log.d(TAG, "Art Initiation object : " + artCurrentStatus);
            summary.setArtDetails(new PatientSummaryDTO.ArtDetailsDTO(art.getDateOfHivTest(), art.getArtNumber(), null,
                    arvRegimen));
        }
        List<PersonInvestigation> investigations = ehrMobileDatabase.personInvestigationDao().findLatestThreeTestsByPersonId(personId);
        if (investigations != null && !investigations.isEmpty()) {
            Log.d(TAG, "Retrieved person investigations : " + investigations);

            List<PatientSummaryDTO.InvestigationSummaryDTO> investigationSummaryDTOS = new ArrayList<>();
            for (PersonInvestigation personInvestigation : investigations) {

                // String testName, Date testDate, String result
                Investigation investigation = ehrMobileDatabase.investigationDao().findByInvestigationId(personInvestigation.getInvestigationId());

                PatientSummaryDTO.InvestigationSummaryDTO investigationSummaryDTO =
                        new PatientSummaryDTO.InvestigationSummaryDTO(
                                ehrMobileDatabase.laboratoryTestDao().findById(investigation.getLaboratoryTestId()).getName(),
                                personInvestigation.getDate(),
                                ehrMobileDatabase.resultDao().findById(personInvestigation.getResultId()).getName());
                investigationSummaryDTOS.add(investigationSummaryDTO);
            }
            summary.setInvestigations(investigationSummaryDTOS);
        }

        return summary;
    }
}
