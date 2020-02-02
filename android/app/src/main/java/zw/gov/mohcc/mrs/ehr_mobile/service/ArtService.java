package zw.gov.mohcc.mrs.ehr_mobile.service;

import android.util.Log;

import androidx.room.Transaction;

import java.util.List;

import zw.gov.mohcc.mrs.ehr_mobile.dto.Age;
import zw.gov.mohcc.mrs.ehr_mobile.dto.ArtDTO;
import zw.gov.mohcc.mrs.ehr_mobile.enumeration.AgeGroup;
import zw.gov.mohcc.mrs.ehr_mobile.enumeration.RegimenType;
import zw.gov.mohcc.mrs.ehr_mobile.model.art.Art;
import zw.gov.mohcc.mrs.ehr_mobile.model.hts.Hts;
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

        ArtDTO artDTO = ehrMobileDatabase.artRegistrationDao().findByPersonId(personId);
        Log.d(TAG, "ART and ART Linkage record retrieved : " + artDTO);
        return artDTO;
    }

    public Hts getLatestHivPositiveRecord(String personId) {

        return null;
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
