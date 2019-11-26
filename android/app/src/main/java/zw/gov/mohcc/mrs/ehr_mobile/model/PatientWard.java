package zw.gov.mohcc.mrs.ehr_mobile.model;

import androidx.annotation.NonNull;
import androidx.room.Embedded;
import androidx.room.Entity;
import androidx.room.Ignore;
import androidx.room.Index;

import zw.gov.mohcc.mrs.ehr_mobile.model.terminology.NameCode;

@Entity(indices = {@Index(value = "visitId", unique = true)})
public class PatientWard extends BaseEntity {

    @NonNull
    private String visitId;
    @Embedded(prefix = "ward_")
    @NonNull
    private NameCode ward;

    public PatientWard() {
    }

    @Ignore
    public PatientWard(@NonNull String id, @NonNull String visitId, @NonNull NameCode ward) {
        super(id);
        this.visitId = visitId;
        this.ward = ward;
    }

    @NonNull
    public String getVisitId() {
        return visitId;
    }

    public void setVisitId(@NonNull String visitId) {
        this.visitId = visitId;
    }

    @NonNull
    public NameCode getWard() {
        return ward;
    }

    public void setWard(@NonNull NameCode ward) {
        this.ward = ward;
    }

    @Override
    public String toString() {
        return super.toString().concat("PatientWard{" +
                "visitId='" + visitId + '\'' +
                ", ward=" + ward +
                '}');
    }
}
