package zw.gov.mohcc.mrs.ehr_mobile.model.terminology;

import androidx.room.Entity;
import androidx.room.ForeignKey;
import androidx.room.Index;

import zw.gov.mohcc.mrs.ehr_mobile.model.BaseNameModel;

import static androidx.room.ForeignKey.CASCADE;

@Entity(/*indices = {@Index("artStatusId")},
        foreignKeys = {@ForeignKey(entity = ArtStatus.class, onDelete = CASCADE,
                parentColumns = "code",
                childColumns = "artStatusId")}*/)
public class ArtReason extends BaseNameModel {

    private String artStatusId;

    public ArtReason() {
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
