package zw.gov.mohcc.mrs.ehr_mobile.service;

import android.util.Log;

import androidx.room.Transaction;

import java.util.Arrays;
import java.util.HashSet;
import java.util.List;
import java.util.UUID;

import zw.gov.mohcc.mrs.ehr_mobile.constant.APPLICATION_CONSTANTS;
import zw.gov.mohcc.mrs.ehr_mobile.dto.Age;
import zw.gov.mohcc.mrs.ehr_mobile.dto.ArtDTO;
import zw.gov.mohcc.mrs.ehr_mobile.enumeration.AgeGroup;
import zw.gov.mohcc.mrs.ehr_mobile.enumeration.ArvStatus;
import zw.gov.mohcc.mrs.ehr_mobile.enumeration.RegimenType;
import zw.gov.mohcc.mrs.ehr_mobile.enumeration.WorkArea;
import zw.gov.mohcc.mrs.ehr_mobile.model.art.Art;
import zw.gov.mohcc.mrs.ehr_mobile.model.art.ArtCurrentStatus;
import zw.gov.mohcc.mrs.ehr_mobile.model.art.ArtLinkageFrom;
import zw.gov.mohcc.mrs.ehr_mobile.model.laboratory.LaboratoryInvestigation;
import zw.gov.mohcc.mrs.ehr_mobile.model.laboratory.PersonInvestigation;
import zw.gov.mohcc.mrs.ehr_mobile.model.person.Person;
import zw.gov.mohcc.mrs.ehr_mobile.model.terminology.ArvCombinationRegimen;
import zw.gov.mohcc.mrs.ehr_mobile.model.terminology.Facility;
import zw.gov.mohcc.mrs.ehr_mobile.model.terminology.NameCode;
import zw.gov.mohcc.mrs.ehr_mobile.model.terminology.Question;
import zw.gov.mohcc.mrs.ehr_mobile.persistance.database.EhrMobileDatabase;

public class ArtService {

    private final String TAG = "Art Service";
    private EhrMobileDatabase ehrMobileDatabase;
    private VisitService visitService;

    public ArtService(EhrMobileDatabase ehrMobileDatabase) {
        this.ehrMobileDatabase = ehrMobileDatabase;
    }

    @Transaction
    public ArtDTO createArt(ArtDTO artDTO) {

        Log.i(TAG, "Creating ART record : " + artDTO);

        Art artFromDTO = ArtDTO.getArt(artDTO);
        ehrMobileDatabase.artDao().save(artFromDTO);

        Art art = ehrMobileDatabase.artDao().findById(artFromDTO.getId());
        Log.i(TAG, "Created art record : " + art);
        Log.d(TAG, "Creating art linkage record ");

        ehrMobileDatabase.artLinkageFromDao().save(ArtDTO.getArtLinkage(artDTO, artDTO.getPersonId()));

        ArtLinkageFrom artLinkageFrom = ehrMobileDatabase.artLinkageFromDao().findByArtId(art.getId());

        Log.d(TAG, "Art Linkage record : " + artLinkageFrom);

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
                artDTO.setDateOfHivTest(personInvestigation.getDate());
                LaboratoryInvestigation laboratoryInvestigation = getLaboratoryInvestigationForLatestHivTest(personInvestigation.getId());
                Log.d(TAG, "Laboratory investigation if any for this history record : " + laboratoryInvestigation);

                if (laboratoryInvestigation != null) {
                    Facility facility = ehrMobileDatabase.facilityDao().findById(laboratoryInvestigation.getFacilityId());
                    artDTO.setFacility(new NameCode(facility.getCode(), facility.getName()));
                }
            }
        }

        Log.d(TAG, "ART and ART Linkage record retrieved : " + artDTO);
        return artDTO;
    }

    public PersonInvestigation getLatestHivPositiveRecord(String personId) {

        PersonInvestigation latestPositiveHivResult = ehrMobileDatabase.personInvestigationDao().
                findTopByPersonIdAndResultNameAndInvestigationIdInOrderByDateDesc(personId, APPLICATION_CONSTANTS.POSITIVE_HIV_RESULT,
                        new HashSet<>(Arrays.asList(APPLICATION_CONSTANTS.HIV_TESTS)));
        Log.d(TAG, "Retrieved latest hiv positive result for this patient : " + latestPositiveHivResult);
        return latestPositiveHivResult;
    }

    public LaboratoryInvestigation getLaboratoryInvestigationForLatestHivTest(String personInvestigationId) {

        Log.d(TAG, "Retrieved laboratory investigation record if test was done in EHR : " + personInvestigationId);

        return ehrMobileDatabase.laboratoryInvestigationDao().findByPersonInvestigationId(personInvestigationId);
    }

    public ArtCurrentStatus initiatePatientOnArt(ArtCurrentStatus artCurrentStatus) {

        artCurrentStatus.setState(ArvStatus.START_ARV);
        artCurrentStatus.setId(UUID.randomUUID().toString());
        Log.d(TAG, "State of art current status : " + artCurrentStatus);
        ehrMobileDatabase.artCurrentStatusDao().save(artCurrentStatus);

        ArtCurrentStatus savedArtCurrentStatus = ehrMobileDatabase.artCurrentStatusDao()
                .findLastestPatientStatus(artCurrentStatus.getArtId());

        Log.d(TAG, "Latest saved art current status : " + savedArtCurrentStatus);

        return savedArtCurrentStatus;
    }

    public ArtCurrentStatus getArtCurrentStatus(String artId) {

        Log.d(TAG, "Fetching patient art current status using artId : " + artId);

        ArtCurrentStatus artCurrentStatus = ehrMobileDatabase.artCurrentStatusDao()
                .findLastestPatientStatus(artId);

        Log.d(TAG, "Fetched art current status : " + artId);

        return artCurrentStatus;
    }

    public List<ArvCombinationRegimen> getPersonArvCombinationRegimens(String personId, RegimenType regimenType) {

        Person person = ehrMobileDatabase.personDao().findPatientById(personId);
        Age age = Age.getInstance(person);
        List<ArvCombinationRegimen> combinationRegimenList = ehrMobileDatabase.arvCombinationRegimenDao().findByLineAndAgeGroup(regimenType, AgeGroup.getPersonAgeGroup(age.getYears()));

        return combinationRegimenList;
    }

    public List<Question> findByWorkAreaAndCategoryId(WorkArea workArea, String categoryId) {

        Log.d(TAG, "Calling question dao with workarea : " + workArea + " and category ID : " + categoryId);
        return ehrMobileDatabase.questionDao().findByWorkAreaAndCategoryId(workArea, categoryId);
    }
}
