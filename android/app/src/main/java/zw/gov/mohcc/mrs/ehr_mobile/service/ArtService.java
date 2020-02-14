package zw.gov.mohcc.mrs.ehr_mobile.service;

import android.util.Log;

import androidx.room.Transaction;

import org.apache.commons.lang3.StringUtils;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import java.util.HashSet;
import java.util.List;
import java.util.UUID;

import zw.gov.mohcc.mrs.ehr_mobile.constant.APPLICATION_CONSTANTS;
import zw.gov.mohcc.mrs.ehr_mobile.dto.Age;
import zw.gov.mohcc.mrs.ehr_mobile.dto.ArtAppointmentDTO;
import zw.gov.mohcc.mrs.ehr_mobile.dto.ArtCurrentStatusDTO;
import zw.gov.mohcc.mrs.ehr_mobile.dto.ArtDTO;
import zw.gov.mohcc.mrs.ehr_mobile.dto.ArtFollowUpDTO;
import zw.gov.mohcc.mrs.ehr_mobile.dto.ArtIptDTO;
import zw.gov.mohcc.mrs.ehr_mobile.dto.ArtVisitDTO;
import zw.gov.mohcc.mrs.ehr_mobile.dto.PastDate;
import zw.gov.mohcc.mrs.ehr_mobile.enumeration.AgeGroup;
import zw.gov.mohcc.mrs.ehr_mobile.enumeration.FollowUpType;
import zw.gov.mohcc.mrs.ehr_mobile.enumeration.RegimenType;
import zw.gov.mohcc.mrs.ehr_mobile.enumeration.WorkArea;
import zw.gov.mohcc.mrs.ehr_mobile.model.art.Art;
import zw.gov.mohcc.mrs.ehr_mobile.model.art.ArtAppointment;
import zw.gov.mohcc.mrs.ehr_mobile.model.art.ArtCurrentStatus;
import zw.gov.mohcc.mrs.ehr_mobile.model.art.ArtFollowUp;
import zw.gov.mohcc.mrs.ehr_mobile.model.art.ArtIpt;
import zw.gov.mohcc.mrs.ehr_mobile.model.art.ArtLinkageFrom;
import zw.gov.mohcc.mrs.ehr_mobile.model.art.ArtOi;
import zw.gov.mohcc.mrs.ehr_mobile.model.art.ArtSymptom;
import zw.gov.mohcc.mrs.ehr_mobile.model.art.ArtVisit;
import zw.gov.mohcc.mrs.ehr_mobile.model.art.ArtWhoStage;
import zw.gov.mohcc.mrs.ehr_mobile.model.laboratory.LaboratoryInvestigation;
import zw.gov.mohcc.mrs.ehr_mobile.model.laboratory.PersonInvestigation;
import zw.gov.mohcc.mrs.ehr_mobile.model.person.Person;
import zw.gov.mohcc.mrs.ehr_mobile.model.tb.TbScreening;
import zw.gov.mohcc.mrs.ehr_mobile.model.terminology.ArtReason;
import zw.gov.mohcc.mrs.ehr_mobile.model.terminology.ArtVisitStatus;
import zw.gov.mohcc.mrs.ehr_mobile.model.terminology.ArtVisitType;
import zw.gov.mohcc.mrs.ehr_mobile.model.terminology.ArvCombinationRegimen;
import zw.gov.mohcc.mrs.ehr_mobile.model.terminology.Facility;
import zw.gov.mohcc.mrs.ehr_mobile.model.terminology.FamilyPlanningStatus;
import zw.gov.mohcc.mrs.ehr_mobile.model.terminology.FollowUpReason;
import zw.gov.mohcc.mrs.ehr_mobile.model.terminology.FollowUpStatus;
import zw.gov.mohcc.mrs.ehr_mobile.model.terminology.FunctionalStatus;
import zw.gov.mohcc.mrs.ehr_mobile.model.terminology.IptReason;
import zw.gov.mohcc.mrs.ehr_mobile.model.terminology.IptStatus;
import zw.gov.mohcc.mrs.ehr_mobile.model.terminology.LactatingStatus;
import zw.gov.mohcc.mrs.ehr_mobile.model.terminology.NameCode;
import zw.gov.mohcc.mrs.ehr_mobile.model.terminology.Question;
import zw.gov.mohcc.mrs.ehr_mobile.persistance.database.EhrMobileDatabase;

public class ArtService {

    private static ArtService INSTANCE;
    private final String TAG = "Art Service";
    private EhrMobileDatabase ehrMobileDatabase;
    private AppWideService appWideService;

    private ArtService(EhrMobileDatabase ehrMobileDatabase, AppWideService appWideService) {
        this.ehrMobileDatabase = ehrMobileDatabase;
        this.appWideService = appWideService;
    }

    public static synchronized ArtService getInstance(EhrMobileDatabase ehrMobileDatabase, AppWideService appWideService) {

        if (INSTANCE == null) {
            return new ArtService(ehrMobileDatabase, appWideService);
        }
        return INSTANCE;
    }

    @Transaction
    public ArtDTO createArt(ArtDTO artDTO) {
        Log.i(TAG, "Creating ART record : " + artDTO);
        Art artFromDTO = ArtDTO.getArt(artDTO);
        ehrMobileDatabase.artDao().save(artFromDTO);
        Art art = ehrMobileDatabase.artDao().findById(artFromDTO.getId());
        Log.i(TAG, "Created art record : " + art);
        Log.d(TAG, "Creating art linkage record ");
        Question question = ehrMobileDatabase.questionDao().findById(artDTO.getTestReason());
        ArtLinkageFrom artLinkageFrom = ArtDTO.getArtLinkage(artDTO, art.getId());
        if (question != null) {
            artLinkageFrom.setTestReason(new NameCode(question.getCode(), question.getName()));
        }
        if (StringUtils.isNoneBlank(artDTO.getFacility())) {
            Facility facility = ehrMobileDatabase.facilityDao().findByName(artDTO.getFacility());
            artLinkageFrom.setFacility(new NameCode(facility.getCode(), facility.getName()));
        }
        ehrMobileDatabase.artLinkageFromDao().save(artLinkageFrom);

        ArtLinkageFrom savedLinkageFrom = ehrMobileDatabase.artLinkageFromDao().findByArtId(art.getId());

        Log.d(TAG, "Art Linkage record : " + savedLinkageFrom);

        return getArt(artDTO.getPersonId());
    }

    public ArtDTO getArt(String personId) {

        Log.d(TAG, "Retrieving patient art record using art record : " + personId);

        ArtDTO artDTO = null;
        Art art = ehrMobileDatabase.artDao().findByPersonId(personId);
        if (art != null) {
            ArtLinkageFrom linkage = ehrMobileDatabase.artLinkageFromDao().findByArtId(art.getId());
            artDTO = ArtDTO.get(art, linkage);
        } else {
            // set default fields
            artDTO = new ArtDTO();
            artDTO.setPersonId(personId);
            PersonInvestigation personInvestigation = getLatestHivPositiveRecord(personId);
            if (personInvestigation != null) {
                artDTO.setDateOfHivTest(personInvestigation.getDate() != null ? new PastDate(personInvestigation.getDate()) : null);
                LaboratoryInvestigation laboratoryInvestigation = getLaboratoryInvestigationForLatestHivTest(personInvestigation.getId());
                Log.d(TAG, "Laboratory investigation if any for this history record : " + laboratoryInvestigation);

                if (laboratoryInvestigation != null) {
                    Facility facility = ehrMobileDatabase.facilityDao().findById(laboratoryInvestigation.getFacilityId());
                    artDTO.setFacility(facility.getCode());
                }
            }
        }

        Log.d(TAG, "ART and ART Linkage record retrieved : " + artDTO);
        return artDTO;
    }

    public PersonInvestigation getLatestHivPositiveRecord(String personId) {

        PersonInvestigation latestPositiveHivResult = ehrMobileDatabase.personInvestigationDao().
                findTopByPersonIdAndResultNameAndInvestigationIdInOrderByDateDesc(personId, APPLICATION_CONSTANTS.POSITIVE_HIV_RESULT_LITERAL,
                        new HashSet<>(Arrays.asList(APPLICATION_CONSTANTS.HIV_TESTS)));
        Log.d(TAG, "Retrieved latest hiv positive result for this patient : " + latestPositiveHivResult);
        return latestPositiveHivResult;
    }

    public LaboratoryInvestigation getLaboratoryInvestigationForLatestHivTest(String personInvestigationId) {

        Log.d(TAG, "Retrieved laboratory investigation record if test was done in EHR : " + personInvestigationId);

        return ehrMobileDatabase.laboratoryInvestigationDao().findByPersonInvestigationId(personInvestigationId);
    }

    public ArtCurrentStatusDTO initiatePatientOnArt(ArtCurrentStatusDTO artCurrentStatusDTO) {

        Log.d(TAG, "State of art current status : " + artCurrentStatusDTO);
        ArtReason artReason = null;
        if (artCurrentStatusDTO.getReason() != null) {
            artReason = ehrMobileDatabase.artReasonDao().findById(artCurrentStatusDTO.getReason());
        }
        ArvCombinationRegimen arvCombinationRegimen = null;
        if (artCurrentStatusDTO.getRegimen() != null) {
            arvCombinationRegimen = ehrMobileDatabase.arvCombinationRegimenDao().findById(artCurrentStatusDTO.getRegimen());
        }
        ehrMobileDatabase.artCurrentStatusDao().save(ArtCurrentStatusDTO.getInstance(artCurrentStatusDTO, artReason, arvCombinationRegimen));

        ArtCurrentStatus savedArtCurrentStatus = ehrMobileDatabase.artCurrentStatusDao()
                .findLastestPatientStatus(artCurrentStatusDTO.getArtId());

        Log.d(TAG, "Latest saved art current status : " + savedArtCurrentStatus);

        return ArtCurrentStatusDTO.get(savedArtCurrentStatus);
    }

    public ArtCurrentStatusDTO getArtCurrentStatus(String personId) {

        Art art = ehrMobileDatabase.artDao().findByPersonId(personId);

        Log.d(TAG, "Fetching patient art current status using artId : " + art);

        ArtCurrentStatus artCurrentStatus = ehrMobileDatabase.artCurrentStatusDao()
                .findLastestPatientStatus(art.getId());

        Log.d(TAG, "Fetched art current status : " + artCurrentStatus);

        return artCurrentStatus != null ? ArtCurrentStatusDTO.get(artCurrentStatus) :
                ArtCurrentStatusDTO.get(new ArtCurrentStatus(null, art.getId()));
    }

    public ArtWhoStage getCurrentWHoStage(String artId) {

        Log.d(TAG, "Retrieving current who stage using artId : " + artId);

        return ehrMobileDatabase.artWhoStageDao().findLatestWhoStageByArtId(artId);
    }

    public List<ArvCombinationRegimen> getPersonArvCombinationRegimens(String personId, RegimenType regimenType) {

        Person person = ehrMobileDatabase.personDao().findPatientById(personId);
        Age age = Age.getInstance(person);
        List<ArvCombinationRegimen> combinationRegimenList = ehrMobileDatabase.arvCombinationRegimenDao().findByLineAndAgeGroup(regimenType, AgeGroup.getPersonAgeGroup(age.getYears()));

        return combinationRegimenList;
    }

    public List<ArvCombinationRegimen> getArvCombinationRegimens(String personId) {

        Person person = ehrMobileDatabase.personDao().findPatientById(personId);
        Age age = Age.getInstance(person);
        List<ArvCombinationRegimen> combinationRegimenList = ehrMobileDatabase.arvCombinationRegimenDao().findByAgeGroup(AgeGroup.getPersonAgeGroup(age.getYears()));

        return combinationRegimenList;
    }


    public List<Question> findByWorkAreaAndCategoryId(WorkArea workArea, String categoryId) {

        Log.d(TAG, "Calling question dao with workarea : " + workArea + " and category ID : " + categoryId);
        return ehrMobileDatabase.questionDao().findByWorkAreaAndCategoryId(workArea, categoryId);
    }

    public TbScreening getVisitTbScreening(String personId) {

        String visitId = appWideService.getCurrentVisit(personId);
        Log.d(TAG, "Retrieved visitId : " + visitId);

        TbScreening tbScreening = ehrMobileDatabase.tbScreeningDao().findByVisitId(visitId);
        Log.d(TAG, "Current visit TB Screening record : " + tbScreening);

        return tbScreening != null ? tbScreening : new TbScreening(null, visitId);
    }

    @Transaction
    public TbScreening saveTbScreening(TbScreening tbScreening) {

        String id = UUID.randomUUID().toString();
        tbScreening.setId(id);
        Log.d(TAG, "Current state of tb screening record :" + tbScreening);
        ehrMobileDatabase.tbScreeningDao().save(tbScreening);

        return ehrMobileDatabase.tbScreeningDao().findById(id);
    }

    public List<ArtSymptom> getArtSymptoms(String personId) {

        Log.d(TAG, "Fetching art record using person ID : " + personId);

        Art art = ehrMobileDatabase.artDao().findByPersonId(personId);

        Log.d(TAG, "Art record retrieved : " + art);


        List<Question> artSymptomQuestions = ehrMobileDatabase.questionDao().findByWorkArea(WorkArea.ART_SYMPTOM);
        Log.d(TAG, "List of art symptoms : " + artSymptomQuestions);

        List<ArtSymptom> artSymptoms = new ArrayList<>();
        for (Question question : artSymptomQuestions) {

            ArtSymptom artSymptom = ehrMobileDatabase.artSymptomDao().findByArtIdAndQuestionId(art.getId(), question.getCode());
            if (artSymptom != null) {
                artSymptoms.add(artSymptom);
            } else {
                artSymptoms.add(new ArtSymptom(
                        null, null, art.getId(), new NameCode(question.getCode(), question.getName())));
            }

        }
        return artSymptoms;
    }

    public ArtSymptom saveArtSymptom(ArtSymptom artSymptom) {

        Log.d(TAG, "Art Symptom record : " + artSymptom);
        artSymptom.setId(UUID.randomUUID().toString());

        ehrMobileDatabase.artSymptomDao().save(artSymptom);

        return ehrMobileDatabase.artSymptomDao().findById(artSymptom.getId());
    }

    public void removeArtSymptom(String artSymptomId) {

        Log.d(TAG, "Deleting art symptom record : " + artSymptomId);

        ehrMobileDatabase.artSymptomDao().deleteById(artSymptomId);

        Log.d(TAG, "Deleted ART Symptom : " + ehrMobileDatabase.artSymptomDao().findById(artSymptomId));
    }

    public List<ArtOi> getArtNewOi(String personId) {

        Log.d(TAG, "Fetching art record using person ID : " + personId);

        Art art = ehrMobileDatabase.artDao().findByPersonId(personId);

        Log.d(TAG, "Art record retrieved : " + art);

        List<Question> artOiQuestions = ehrMobileDatabase.questionDao()
                .findByWorkAreaAndCategoryId(WorkArea.ART, APPLICATION_CONSTANTS.ART_NEW_OI_CATEGORY_ID);
        Log.d(TAG, "List of art new oi : " + artOiQuestions);

        List<ArtOi> artOis = new ArrayList<>();
        for (Question question : artOiQuestions) {

            ArtOi artOi = ehrMobileDatabase.artOiDao().findByArtIdAndQuestionId(art.getId(), question.getCode());
            if (artOi != null) {
                artOis.add(artOi);
            } else {
                artOis.add(new ArtOi(
                        null, null, art.getId(), new NameCode(question.getCode(), question.getName())));
            }

        }
        return artOis;
    }

    public ArtOi saveArtNewOi(ArtOi artOi) {

        Log.d(TAG, "Art New OI record : " + artOi);
        artOi.setId(UUID.randomUUID().toString());

        ehrMobileDatabase.artOiDao().save(artOi);
        Log.d(TAG, "Art New OI record to be returned : " + ehrMobileDatabase.artOiDao().findById(artOi.getId()));


        return ehrMobileDatabase.artOiDao().findById(artOi.getId());
    }

    public void removeArtNewOi(String artOiId) {

        Log.d(TAG, "Deleting art new OI record : " + artOiId);

        ehrMobileDatabase.artOiDao().deleteById(artOiId);

        Log.d(TAG, "Deleted ART Symptom : " + ehrMobileDatabase.artOiDao().findById(artOiId));
    }

    public ArtVisitDTO getArtVisit(String personId) {

        String visitId = appWideService.getCurrentVisit(personId);
        Log.d(TAG, "Current visit ID : " + visitId);
        Art art = ehrMobileDatabase.artDao().findByPersonId(personId);

        ArtVisit artVisit = ehrMobileDatabase.artVisitDao().findByVisitId(visitId);

        Log.d(TAG, "Art visit record : " + artVisit);

        return artVisit != null ? ArtVisitDTO.get(artVisit, null) :
                ArtVisitDTO.get(new ArtVisit(null, art.getId(), visitId), null);
    }

    @Transaction
    public ArtVisitDTO saveArtVisit(ArtVisitDTO dto) {

        Log.d(TAG, "Art visit DTO state : " + dto);

        FamilyPlanningStatus familyPlanningStatus = null;
        if (StringUtils.isNoneBlank(dto.getFamilyPlanningStatus())) {

            familyPlanningStatus = ehrMobileDatabase.familyPlanningStatusDao().findById(dto.getFamilyPlanningStatus());
        }
        FunctionalStatus functionalStatus = null;
        if (StringUtils.isNoneBlank(dto.getFunctionalStatus())) {

            functionalStatus = ehrMobileDatabase.functionalStatusDao().findById(dto.getFunctionalStatus());
        }
        LactatingStatus lactatingStatus = null;
        if (StringUtils.isNoneBlank(dto.getLactatingStatus())) {

            lactatingStatus = ehrMobileDatabase.lactatingStatusDao().findById(dto.getLactatingStatus());
        }
        ArtVisitType artVisitType = null;
        if (StringUtils.isNoneBlank(dto.getVisitType())) {

            artVisitType = ehrMobileDatabase.artVisitTypeDao().findById(dto.getVisitType());
        }
        ArtVisitStatus artVisitStatus = null;
        if (StringUtils.isNoneBlank(dto.getVisitStatus())) {

            artVisitStatus = ehrMobileDatabase.artVisitStatusDao().findById(dto.getVisitStatus());
        }
        FollowUpStatus followUpStatus = null;
        if (StringUtils.isNoneBlank(dto.getFollowUpStatus())) {

            followUpStatus = ehrMobileDatabase.followUpStatusDao().findById(dto.getFollowUpStatus());
        }

        ehrMobileDatabase.artVisitDao().save(dto.getArtVisitInstance(dto, familyPlanningStatus, functionalStatus,
                lactatingStatus, artVisitType, artVisitStatus));

        ArtVisit savedArtVisit = ehrMobileDatabase.artVisitDao().findByVisitId(dto.getVisitId());

        Log.d(TAG, "Saved art visit object : " + savedArtVisit);
        ArtWhoStage artWhoStage = dto.getArtWhoStageInstance(dto, followUpStatus);

        if (ehrMobileDatabase.artWhoStageDao().existsByArtIdAndWhoStage(artWhoStage.getArtId(), artWhoStage.getStage()) <= 0) {
            Log.d(TAG, "Patient is still on same stage ignore");
            ehrMobileDatabase.artWhoStageDao().save(artWhoStage);
        }

        ArtWhoStage saveArtWhoStage = ehrMobileDatabase.artWhoStageDao().findByArtIdAndWhoStage(artWhoStage.getArtId(), artWhoStage.getStage());

        Log.d(TAG, "Current latest who stage in db : " + savedArtVisit);

        return ArtVisitDTO.get(savedArtVisit, saveArtWhoStage);
    }

    public ArtIptDTO getArtIpt(String personId) {

        Log.d(TAG, "Retrieving visitId using personId : " + personId);

        String visitId = appWideService.getCurrentVisit(personId);

        Art art = ehrMobileDatabase.artDao().findByPersonId(personId);

        ArtIpt artIpt = ehrMobileDatabase.artIptDao().findByVisitId(visitId);
        Log.d(TAG, "Current IPT record for this visit : " + artIpt);
        if (artIpt != null) {
            return ArtIptDTO.get(artIpt);
        }

        Log.d(TAG, "ART DTO TO BE RETURNED IN ANDROID >>>>>>" + ArtIptDTO.get(new ArtIpt(null, art.getId(), visitId, null, null)));

        return ArtIptDTO.get(new ArtIpt(null, art.getId(), visitId, null, null));
    }

    public ArtIptDTO saveArtIpt(ArtIptDTO artIptDTO) {

        Log.d(TAG, "Current state of IPT DTO : " + artIptDTO);

        IptReason iptReason = null;
        if (artIptDTO.getReason() != null) {
            iptReason = ehrMobileDatabase.iptReasonDao().findById(artIptDTO.getReason());
        }
        IptStatus iptStatus = null;
        if (artIptDTO.getIptStatus() != null) {
            iptStatus = ehrMobileDatabase.iptStatusDao().findById(artIptDTO.getIptStatus());
        }

        ehrMobileDatabase.artIptDao().save(artIptDTO.getInstance(artIptDTO, iptStatus, iptReason));

        return ArtIptDTO.get(ehrMobileDatabase.artIptDao().findByVisitId(artIptDTO.getVisitId()));
    }

    public ArtAppointmentDTO getArtAppointment(String personId) {

        Log.d(TAG, "Retrieving visitId using personId : " + personId);

        Art art = ehrMobileDatabase.artDao().findByPersonId(personId);

        ArtAppointment artAppointment = ehrMobileDatabase.artAppointmentDao().findByArtIdAndDate(art.getId(), new Date().getTime());
        Log.d(TAG, "Current Art appointment record for this day : " + artAppointment);
        if (artAppointment != null) {
            return ArtAppointmentDTO.get(artAppointment);
        }

        return ArtAppointmentDTO.get(new ArtAppointment(null, art.getId()));
    }

    public ArtAppointmentDTO saveArtAppointment(ArtAppointmentDTO artAppointmentDTO) {

        Log.d(TAG, "Current state of ArtAppointment DTO : " + artAppointmentDTO);

        FollowUpReason followUpReason = null;
        if (artAppointmentDTO.getReason() != null) {
            followUpReason = ehrMobileDatabase.followUpReasonDao().findById(artAppointmentDTO.getReason());
        }

        ehrMobileDatabase.artAppointmentDao().save(artAppointmentDTO.getInstance(artAppointmentDTO, followUpReason));

        return ArtAppointmentDTO.get(ehrMobileDatabase.artAppointmentDao().findByArtIdAndDate(
                artAppointmentDTO.getArtId(), artAppointmentDTO.getDate().getTime()));
    }

    public List<ArtAppointmentDTO> getPersonArtAppointments(String personId) {

        Art art = ehrMobileDatabase.artDao().findByPersonId(personId);
        return ArtAppointmentDTO.get(ehrMobileDatabase.artAppointmentDao().findByArtIdOrderByDateDesc(art.getId()));
    }

    public ArtFollowUpDTO getArtFollowUp(String artFollowUpId) {

        Log.d(TAG, "Retrieving ArtFollowUp entity using artFollowUpId : " + artFollowUpId);

        return ArtFollowUpDTO.get(ehrMobileDatabase.artFollowUpDao().findById(artFollowUpId));
    }

    public ArtFollowUpDTO saveArtFollowUpVisit(ArtFollowUpDTO artFollowUpDTO) {

        return saveArtFollowUp(artFollowUpDTO, FollowUpType.VISIT);
    }

    public ArtFollowUpDTO saveArtFollowUpCall(ArtFollowUpDTO artFollowUpDTO) {

        return saveArtFollowUp(artFollowUpDTO, FollowUpType.CALL);
    }

    private ArtFollowUpDTO saveArtFollowUp(ArtFollowUpDTO artFollowUpDTO, FollowUpType followUpType) {

        Log.d(TAG, "State of ArtFollowUpDTO : " + artFollowUpDTO);

        FollowUpReason outcome = null;
        if (artFollowUpDTO.getOutcome() != null) {
            outcome = ehrMobileDatabase.followUpReasonDao().findById(artFollowUpDTO.getOutcome());
        }

        ArtFollowUp artFollowUp = ArtFollowUpDTO.getInstance(artFollowUpDTO, followUpType, outcome);

        Log.d(TAG, "State of ArtFollowUp : " + artFollowUp);

        ehrMobileDatabase.artFollowUpDao().save(artFollowUp);

        return ArtFollowUpDTO.get(ehrMobileDatabase.artFollowUpDao().findById(artFollowUp.getId()));
    }

}
