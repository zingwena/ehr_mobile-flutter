package zw.gov.mohcc.mrs.ehr_mobile.service;

import android.util.Log;

import androidx.room.Transaction;

import java.util.Arrays;
import java.util.HashSet;
import java.util.List;

import zw.gov.mohcc.mrs.ehr_mobile.constant.InvestigationIdConstants;
import zw.gov.mohcc.mrs.ehr_mobile.dto.Age;
import zw.gov.mohcc.mrs.ehr_mobile.dto.ArtDTO;
import zw.gov.mohcc.mrs.ehr_mobile.enumeration.AgeGroup;
import zw.gov.mohcc.mrs.ehr_mobile.enumeration.RegimenType;
import zw.gov.mohcc.mrs.ehr_mobile.model.art.Art;
import zw.gov.mohcc.mrs.ehr_mobile.model.art.ArtLinkageFrom;
import zw.gov.mohcc.mrs.ehr_mobile.model.laboratory.PersonInvestigation;
import zw.gov.mohcc.mrs.ehr_mobile.model.person.Person;
import zw.gov.mohcc.mrs.ehr_mobile.model.terminology.ArvCombinationRegimen;
import zw.gov.mohcc.mrs.ehr_mobile.persistance.database.EhrMobileDatabase;

public class ArtService {

    private final String TAG = "Art Service";
    private EhrMobileDatabase ehrMobileDatabase;
    private VisitService visitService;

    public ArtService(EhrMobileDatabase ehrMobileDatabase) {
        this.ehrMobileDatabase = ehrMobileDatabase;
    }

    @Transaction
    public Art createArt(Art art) {

        Log.i(TAG, "Creating ART record : " + art);

        ehrMobileDatabase.artRegistrationDao().save(art);

        Art newArtRecord = ehrMobileDatabase.artRegistrationDao().findById(art.getId());
        Log.i(TAG, "Created art record : " + newArtRecord);

        return newArtRecord;
    }

    public ArtDTO getArt(String personId) {

        Log.d(TAG, "Retrieving patient art record using art record : " + personId);

        ArtDTO artDTO = null;
        Art art = ehrMobileDatabase.artRegistrationDao().findByPersonId(personId);
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
            }
        }

        Log.d(TAG, "ART and ART Linkage record retrieved : " + artDTO);
        return artDTO;
    }

    public PersonInvestigation getLatestHivPositiveRecord(String personId) {

        PersonInvestigation latestPositiveHivResult = ehrMobileDatabase.personInvestigationDao().
                findTopByPersonIdAndResultNameAndInvestigationIdInOrderByDateDesc(personId, InvestigationIdConstants.POSITIVE_HIV_RESULT,
                        new HashSet<>(Arrays.asList(InvestigationIdConstants.HIV_TESTS)));
        Log.d(TAG, "Retrieved latest hiv positive result for this patient : " + latestPositiveHivResult);
        return latestPositiveHivResult;
    }

    public String initiatePatientOnArt(String artId) {

        return null;
    }

    public List<ArvCombinationRegimen> getPersonArvCombinationRegimens(String personId, RegimenType regimenType) {

        Person person = ehrMobileDatabase.personDao().findPatientById(personId);
        Age age = Age.getInstance(person);
        List<ArvCombinationRegimen> combinationRegimenList = ehrMobileDatabase.arvCombinationRegimenDao().findByLineAndAgeGroup(regimenType, AgeGroup.getPersonAgeGroup(age.getYears()));

        return combinationRegimenList;
    }
}
