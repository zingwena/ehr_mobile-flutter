package zw.gov.mohcc.mrs.ehr_mobile.model;

import androidx.room.Entity;
import androidx.room.ForeignKey;
import androidx.room.PrimaryKey;

import java.io.Serializable;

import static androidx.room.ForeignKey.CASCADE;

@Entity(foreignKeys = {@ForeignKey(entity = LaboratoryTest.class, onDelete = CASCADE,
        parentColumns = "code",
        childColumns = "laboratoryTestId"),
        @ForeignKey(entity = Sample.class, onDelete = CASCADE,
                parentColumns = "code",
                childColumns = "sampleId")})
public class Investigation implements Serializable {

    @PrimaryKey
    private String investigationId;
    private String laboratoryTestId;
    private String sampleId;

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

    public String getSampleId() {
        return sampleId;
    }

    public void setSampleId(String sampleId) {
        this.sampleId = sampleId;
    }
}