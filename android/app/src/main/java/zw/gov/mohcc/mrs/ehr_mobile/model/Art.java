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
@Entity(indices = {@Index(value = "personId", unique = true)},
foreignKeys = @ForeignKey(entity = Person.class, onDelete = CASCADE,
        parentColumns = "id",
        childColumns = "personId"))
public class Art extends BaseEntity{

    @NonNull
    private String personId;

    @TypeConverters(DateConverter.class)
    @NonNull
    private Date dateOfEnrolmentIntoCare;

    @TypeConverters(DateConverter.class)
    @NonNull
    private Date dateOfHivTest;

    @NonNull
    private String oiArtNumber;

    public Art() {
    }

    @Ignore
    public Art(@NonNull String id, @NonNull String personId, @NonNull Date dateOfEnrolmentIntoCare, @NonNull Date dateOfHivTest, @NonNull String oiArtNumber) {
        super(id);
        this.personId = personId;
        this.dateOfEnrolmentIntoCare = dateOfEnrolmentIntoCare;
        this.dateOfHivTest = dateOfHivTest;
        this.oiArtNumber = oiArtNumber;
    }

    @NonNull
    public String getPersonId() {
        return personId;
    }

    public void setPersonId(@NonNull String personId) {
        this.personId = personId;
    }

    @NonNull
    public Date getDateOfEnrolmentIntoCare() {
        return dateOfEnrolmentIntoCare;
    }

    public void setDateOfEnrolmentIntoCare(@NonNull Date dateOfEnrolmentIntoCare) {
        this.dateOfEnrolmentIntoCare = dateOfEnrolmentIntoCare;
    }

    @NonNull
    public Date getDateOfHivTest() {
        return dateOfHivTest;
    }

    public void setDateOfHivTest(@NonNull Date dateOfHivTest) {
        this.dateOfHivTest = dateOfHivTest;
    }

    @NonNull
    public String getOiArtNumber() {
        return oiArtNumber;
    }

    public void setOiArtNumber(@NonNull String oiArtNumber) {
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
