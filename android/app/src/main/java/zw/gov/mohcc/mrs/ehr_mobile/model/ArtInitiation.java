package zw.gov.mohcc.mrs.ehr_mobile.model;

import androidx.annotation.NonNull;
import androidx.room.ColumnInfo;
import androidx.room.Embedded;
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
public class ArtInitiation extends BaseEntity{

    @ColumnInfo(name = "personId")
    private String personId;
   private String line;
    private String artRegimenId;
    private String artReasonId;
   // private String artStatusId;

    public ArtInitiation() {
    }

    @Ignore
    public ArtInitiation(String personId, String artRegimenId, String artReasonId) {
        this.personId = personId;
        this.artRegimenId = artRegimenId;
        this.artReasonId = artReasonId;
    }

    public String getLine() {
        return line;
    }

    public void setLine(String line) {
        this.line = line;
    }

    public String getPersonId() {
        return personId;
    }

    public void setPersonId(String personId) {
        this.personId = personId;
    }


    public String getArtRegimenId() {
        return artRegimenId;
    }

    public void setArtRegimenId(String artRegimenId) {
        this.artRegimenId = artRegimenId;
    }

    public String getArtReasonId() {
        return artReasonId;
    }

    public void setArtReasonId(String artReasonId) {
        this.artReasonId = artReasonId;
    }

    @Override
    public String toString() {
        return "ArtInitiation{" +
                "personId='" + personId + '\'' +
                ", artRegimenId='" + artRegimenId + '\'' +
                ", artReasonId='" + artReasonId + '\'' +
                '}';
    }
}
