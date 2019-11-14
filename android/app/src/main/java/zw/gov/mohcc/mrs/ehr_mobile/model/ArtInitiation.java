package zw.gov.mohcc.mrs.ehr_mobile.model;

import androidx.annotation.NonNull;
import androidx.room.Entity;
import androidx.room.ForeignKey;
import androidx.room.Index;

import static androidx.room.ForeignKey.CASCADE;

@Entity(indices = {@Index(value = "personId", unique = true), @Index("artRegimenId"), @Index("artReasonId")},
        foreignKeys = {@ForeignKey(entity = Person.class, onDelete = CASCADE,
                parentColumns = "id",
                childColumns = "personId"),
                @ForeignKey(entity = ArvCombinationRegimen.class, onDelete = CASCADE,
                        parentColumns = "code",
                        childColumns = "artRegimenId"),
                @ForeignKey(entity = ArtReason.class, onDelete = CASCADE,
                        parentColumns = "code",
                        childColumns = "artReasonId")})
public class ArtInitiation extends BaseEntity {

    @NonNull
    private String personId;
    @NonNull
    private String artRegimenId;
    @NonNull
    private String artReasonId;

    public ArtInitiation() {
    }

    @NonNull
    public String getPersonId() {
        return personId;
    }

    public void setPersonId(@NonNull String personId) {
        this.personId = personId;
    }

    @NonNull
    public String getArtRegimenId() {
        return artRegimenId;
    }

    public void setArtRegimenId(@NonNull String artRegimenId) {
        this.artRegimenId = artRegimenId;
    }

    @NonNull
    public String getArtReasonId() {
        return artReasonId;
    }

    public void setArtReasonId(@NonNull String artReasonId) {
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
