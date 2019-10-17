package zw.gov.mohcc.mrs.ehr_mobile.dto;

import androidx.room.ColumnInfo;
import androidx.room.TypeConverters;

import java.util.Date;
import java.util.UUID;

import zw.gov.mohcc.mrs.ehr_mobile.model.Art;
import zw.gov.mohcc.mrs.ehr_mobile.model.Hts;
import zw.gov.mohcc.mrs.ehr_mobile.util.DateConverter;

public class ArtDto {

    private String personId;

    @TypeConverters(DateConverter.class)
    private Date dateOfEnrolmentIntoCare;

    @TypeConverters(DateConverter.class)
    private Date dateOfHivTest;

    private String oiArtNumber;

    public static Art getInstance(ArtDto dto) {
        String artId = UUID.randomUUID().toString();
        Art art = new Art();
        art.setId(artId);
        art.setDateOfEnrolmentIntoCare(dto.getDateOfEnrolmentIntoCare());
        art.setDateOfHivTest(dto.getDateOfEnrolmentIntoCare());
        art.setOiArtNumber(dto.getOiArtNumber());

        return art;
    }

    public String getPersonId() {
        return personId;
    }

    public void setPersonId(String personId) {
        this.personId = personId;
    }

    public Date getDateOfEnrolmentIntoCare() {
        return dateOfEnrolmentIntoCare;
    }

    public void setDateOfEnrolmentIntoCare(Date dateOfEnrolmentIntoCare) {
        this.dateOfEnrolmentIntoCare = dateOfEnrolmentIntoCare;
    }

    public Date getDateOfHivTest() {
        return dateOfHivTest;
    }

    public void setDateOfHivTest(Date dateOfHivTest) {
        this.dateOfHivTest = dateOfHivTest;
    }

    public String getOiArtNumber() {
        return oiArtNumber;
    }

    public void setOiArtNumber(String oiArtNumber) {
        this.oiArtNumber = oiArtNumber;
    }
}
