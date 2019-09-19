package zw.gov.mohcc.mrs.ehr_mobile.model;

import androidx.annotation.NonNull;
import androidx.room.Entity;
import androidx.room.ForeignKey;
import androidx.room.Ignore;
import androidx.room.Index;

import static androidx.room.ForeignKey.CASCADE;

@Entity(indices = {@Index("laboratoryTestId"), @Index("sampleId")},
        foreignKeys = {@ForeignKey(entity = LaboratoryTest.class, onDelete = CASCADE,
                parentColumns = "code",
                childColumns = "laboratoryTestId"),
                @ForeignKey(entity = Sample.class, onDelete = CASCADE,
                        parentColumns = "code",
                        childColumns = "sampleId")})
public class Investigation extends BaseEntity {

    private String laboratoryTestId;
    private String sampleId;

    public Investigation() {
    }

    @Ignore
    public Investigation(@NonNull String id, String laboratoryTestId, String sampleId) {
        super(id);
        this.laboratoryTestId = laboratoryTestId;
        this.sampleId = sampleId;
    }

    public String getLaboratoryTestId() {
        return laboratoryTestId;
    }

    public void setLaboratoryTestId(String laboratoryTestId) {
        this.laboratoryTestId = laboratoryTestId;
    }

    public String getSampleId() {
        return sampleId;
    }

    public void setSampleId(String sampleId) {
        this.sampleId = sampleId;
    }
}