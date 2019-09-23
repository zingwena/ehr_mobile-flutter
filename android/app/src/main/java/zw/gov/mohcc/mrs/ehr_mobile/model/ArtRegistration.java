package zw.gov.mohcc.mrs.ehr_mobile.model;

import androidx.annotation.NonNull;
import androidx.room.ColumnInfo;
import androidx.room.Entity;
import androidx.room.TypeConverters;

import java.util.Date;

import zw.gov.mohcc.mrs.ehr_mobile.util.DateConverter;

@Entity
public class ArtRegistration extends BaseEntity{

    @ColumnInfo(name = "personId")
    private String personId;

    @TypeConverters(DateConverter.class)
    private Date dateOfEnrolmentIntoCare;

    @TypeConverters(DateConverter.class)
    private Date dateOfHivTest;

    private String oiArtNumber;




    public ArtRegistration(){

    }

    public ArtRegistration(@NonNull String id, String personId, Date dateOfEnrolmentIntoCare, Date dateOfHivTest, String oiArtNumber) {
        super(id);
        this.personId = personId;
        this.dateOfEnrolmentIntoCare = dateOfEnrolmentIntoCare;
        this.dateOfHivTest = dateOfHivTest;
        this.oiArtNumber = oiArtNumber;
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

    @Override
    public String toString() {
        return "ArtRegistration{" +
                "personId='" + personId + '\'' +
                ", dateOfEnrolmentIntoCare=" + dateOfEnrolmentIntoCare +
                ", dateOfHivTest=" + dateOfHivTest +
                ", oiArtNumber='" + oiArtNumber + '\'' +
                '}';
    }
}
