package zw.gov.mohcc.mrs.ehr_mobile.service;

import android.util.Log;

import androidx.room.Transaction;

import java.util.List;
import java.util.UUID;

import zw.gov.mohcc.mrs.ehr_mobile.dto.ArtDto;
import zw.gov.mohcc.mrs.ehr_mobile.dto.HtsRegDTO;
import zw.gov.mohcc.mrs.ehr_mobile.model.Art;
import zw.gov.mohcc.mrs.ehr_mobile.model.Hts;
import zw.gov.mohcc.mrs.ehr_mobile.model.LaboratoryInvestigation;
import zw.gov.mohcc.mrs.ehr_mobile.model.PersonInvestigation;
import zw.gov.mohcc.mrs.ehr_mobile.model.Result;
import zw.gov.mohcc.mrs.ehr_mobile.model.vitals.Visit;
import zw.gov.mohcc.mrs.ehr_mobile.persistance.database.EhrMobileDatabase;

public class ArtService {

    private final String TAG = "Art Service";
    private EhrMobileDatabase ehrMobileDatabase;
    private VisitService visitService;

    public ArtService(EhrMobileDatabase ehrMobileDatabase) {
        this.ehrMobileDatabase = ehrMobileDatabase;
    }

    @Transaction
    public String createArt(ArtDto dto) {

        Log.i(TAG, "Creating HTS record");
        Art art = ArtDto.getInstance(dto);
        ehrMobileDatabase.artRegistrationDao().createArtRegistration(art);
        Log.i(TAG, "Created art record : " + ehrMobileDatabase.artRegistrationDao().findArtRegistrationById(art.getId()));

        return art.getId();
    }


}
