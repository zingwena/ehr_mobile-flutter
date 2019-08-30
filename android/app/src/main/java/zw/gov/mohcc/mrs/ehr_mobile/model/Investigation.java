package zw.gov.mohcc.mrs.ehr_mobile.model;

import androidx.annotation.NonNull;
import androidx.room.Entity;
import androidx.room.ForeignKey;
import androidx.room.Index;
import androidx.room.PrimaryKey;

import java.io.Serializable;

import static androidx.room.ForeignKey.CASCADE;

@Entity(indices = {@Index("laboratoryTestId"), @Index("sampleId")}, foreignKeys = {@ForeignKey(entity = LaboratoryTest.class, onDelete = CASCADE,
        parentColumns = "code",
        childColumns = "laboratoryTestId"),
        @ForeignKey(entity = Sample.class, onDelete = CASCADE,
                parentColumns = "code",
                childColumns = "sampleId")})
public class Investigation implements Serializable {

    @PrimaryKey
    @NonNull
    private String investigationId;
    private String laboratoryTestId;
    private int sampleId;

    public Investigation() {
    }

    public String getInvestigationId() {
        return investigationId;
    }

    public void setInvestigationId(String investigationId) {
        this.investigationId = investigationId;
    }

    public String getLaboratoryTestId() {
        return laboratoryTestId;
    }

    public void setLaboratoryTestId(String laboratoryTestId) {
        this.laboratoryTestId = laboratoryTestId;
    }

    public int getSampleId() {
        return sampleId;
    }

    public void setSampleId(int sampleId) {
        this.sampleId = sampleId;
    }
}