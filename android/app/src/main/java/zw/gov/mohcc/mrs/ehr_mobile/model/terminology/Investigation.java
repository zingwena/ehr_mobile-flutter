package zw.gov.mohcc.mrs.ehr_mobile.model.terminology;

import androidx.annotation.NonNull;
import androidx.room.Entity;
import androidx.room.ForeignKey;
import androidx.room.Ignore;
import androidx.room.Index;

import zw.gov.mohcc.mrs.ehr_mobile.model.BaseEntity;

import static androidx.room.ForeignKey.CASCADE;

@Entity(/*indices = {@Index("laboratoryTestId"), @Index("sampleId")},
        foreignKeys = {@ForeignKey(entity = LaboratoryTest.class, onDelete = CASCADE,
                parentColumns = "code",
                childColumns = "laboratoryTestId"),
                @ForeignKey(entity = Sample.class, onDelete = CASCADE,
                        parentColumns = "code",
                        childColumns = "sampleId")}*/)
public class Investigation extends BaseEntity {

    @NonNull
    private String laboratoryTestId;
    @NonNull
    private String sampleId;

    public Investigation() {
    }

    @Ignore
    public Investigation(@NonNull String id, @NonNull String laboratoryTestId, @NonNull String sampleId) {
        super(id);
        this.laboratoryTestId = laboratoryTestId;
        this.sampleId = sampleId;
    }

    @NonNull
    public String getLaboratoryTestId() {
        return laboratoryTestId;
    }

    public void setLaboratoryTestId(@NonNull String laboratoryTestId) {
        this.laboratoryTestId = laboratoryTestId;
    }

    @NonNull
    public String getSampleId() {
        return sampleId;
    }

    public void setSampleId(@NonNull String sampleId) {
        this.sampleId = sampleId;
    }

    @Override
    public String toString() {
        return super.toString().concat("Investigation{" +
                "laboratoryTestId='" + laboratoryTestId + '\'' +
                ", sampleId='" + sampleId + '\'' +
                '}');
    }
}