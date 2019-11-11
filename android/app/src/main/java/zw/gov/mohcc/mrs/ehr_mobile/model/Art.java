package zw.gov.mohcc.mrs.ehr_mobile.model;

import androidx.annotation.NonNull;
import androidx.room.ColumnInfo;
import androidx.room.Entity;
import androidx.room.ForeignKey;
import androidx.room.Ignore;
import androidx.room.Index;
import androidx.room.TypeConverters;

import java.util.Date;

import zw.gov.mohcc.mrs.ehr_mobile.util.DateConverter;

import static androidx.room.ForeignKey.CASCADE;
@Entity(indices = {@Index("personId")})
@ForeignKey(entity = Person.class, onDelete = CASCADE,
        parentColumns = "id",
        childColumns = "personId")
public class Art extends BaseEntity{

    @ColumnInfo(name = "personId")
    @NonNull
    private String personId;

    @TypeConverters(DateConverter.class)
    private Date dateOfEnrolmentIntoCare;

    @TypeConverters(DateConverter.class)
    private Date dateOfHivTest;

    private String oiArtNumber;

    public Art(){

    }

    @Ignore
    public Art(@NonNull String id, String personId, Date dateOfEnrolmentIntoCare, Date dateOfHivTest, String oiArtNumber) {
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
        return "Art{" +
                "personId='" + personId + '\'' +
                ", dateOfEnrolmentIntoCare=" + dateOfEnrolmentIntoCare +
                ", dateOfHivTest=" + dateOfHivTest +
                ", oiArtNumber='" + oiArtNumber + '\'' +
                '}';
    }
}
