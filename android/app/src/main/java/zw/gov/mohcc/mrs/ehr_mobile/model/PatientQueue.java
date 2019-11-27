package zw.gov.mohcc.mrs.ehr_mobile.model;

import androidx.annotation.NonNull;
import androidx.room.Embedded;
import androidx.room.Entity;
import androidx.room.Ignore;
import androidx.room.Index;

import zw.gov.mohcc.mrs.ehr_mobile.model.terminology.NameCode;

@Entity(indices = {@Index(value = "visitId", unique = true)})
public class PatientQueue extends BaseEntity {

    @NonNull
    private String visitId;
    @Embedded(prefix = "queue_")
    @NonNull
    private NameCode queue;

    public PatientQueue() {
    }

    @Ignore
    public PatientQueue(@NonNull String id, @NonNull String visitId, @NonNull NameCode queue) {
        super(id);
        this.visitId = visitId;
        this.queue = queue;
    }

    @NonNull
    public String getVisitId() {
        return visitId;
    }

    public void setVisitId(@NonNull String visitId) {
        this.visitId = visitId;
    }

    @NonNull
    public NameCode getQueue() {
        return queue;
    }

    public void setQueue(@NonNull NameCode queue) {
        this.queue = queue;
    }

    @Override
    public String toString() {
        return super.toString().concat("PatientQueue{" +
                "visitId='" + visitId + '\'' +
                ", queue=" + queue +
                '}');
    }
}
