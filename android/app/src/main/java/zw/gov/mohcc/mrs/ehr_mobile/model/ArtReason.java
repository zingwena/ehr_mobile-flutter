package zw.gov.mohcc.mrs.ehr_mobile.model;

import androidx.room.Entity;
import androidx.room.ForeignKey;
import androidx.room.Ignore;
import androidx.room.Index;

import static androidx.room.ForeignKey.CASCADE;

@Entity(indices = {@Index("artStatusId")})
@ForeignKey(entity = ArtStatus.class, onDelete = CASCADE,
        parentColumns = "code",
        childColumns = "artStatusId")
public class ArtReason extends BaseNameModel {

    private String artStatusId;

    public ArtReason() {
    }

    @Ignore
    public ArtReason(String code, String name, String artStatusId) {
        super(code, name);
        this.artStatusId = artStatusId;
    }

    public String getArtStatusId() {
        return artStatusId;
    }

    public void setArtStatusId(String artStatusId) {
        this.artStatusId = artStatusId;
    }

    @Override
    public String toString() {
        return super.toString().concat("ArtReason{" +
                "artStatusId='" + artStatusId + '\'' +
                '}');
    }
}
