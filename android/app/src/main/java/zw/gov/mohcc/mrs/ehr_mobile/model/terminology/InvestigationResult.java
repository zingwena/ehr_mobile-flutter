package zw.gov.mohcc.mrs.ehr_mobile.model.terminology;

import androidx.annotation.NonNull;
import androidx.room.Entity;
import androidx.room.ForeignKey;
import androidx.room.Index;

import zw.gov.mohcc.mrs.ehr_mobile.model.BaseEntity;

import static androidx.room.ForeignKey.CASCADE;

@Entity(indices = {@Index("resultId"), @Index("investigationId")},
foreignKeys = {@ForeignKey(entity = Result.class, parentColumns = "code", childColumns = "resultId", onDelete = CASCADE),
        @ForeignKey(entity = Investigation.class, parentColumns = "id", childColumns = "investigationId", onDelete = CASCADE)})
public class InvestigationResult extends BaseEntity {

    @NonNull
    private String resultId;
    @NonNull
    private String investigationId;

    public InvestigationResult() {
    }

    @NonNull
    public String getResultId() {
        return resultId;
    }

    public void setResultId(@NonNull String resultId) {
        this.resultId = resultId;
    }

    @NonNull
    public String getInvestigationId() {
        return investigationId;
    }

    public void setInvestigationId(@NonNull String investigationId) {
        this.investigationId = investigationId;
    }

    @Override
    public String toString() {
        return "InvestigationResult{" +
                "id='" + getId() + '\'' +
                "resultId='" + resultId + '\'' +
                ", investigationId='" + investigationId + '\'' +
                '}';
    }
}
