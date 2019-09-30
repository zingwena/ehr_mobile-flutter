package zw.gov.mohcc.mrs.ehr_mobile.model;

import androidx.annotation.NonNull;
import androidx.room.Entity;
import androidx.room.Ignore;

@Entity
public class InvestigationResult extends BaseEntity {

    private String resultId;
    private String investigationId;

    public InvestigationResult() {
    }

    @Ignore
    public InvestigationResult(@NonNull String id, String resultId, String investigationId) {
        super(id);
        this.resultId = resultId;
        this.investigationId = investigationId;
    }

    public String getResultId() {
        return resultId;
    }

    public void setResultId(String resultId) {
        this.resultId = resultId;
    }

    public String getInvestigationId() {
        return investigationId;
    }

    public void setInvestigationId(String investigationId) {
        this.investigationId = investigationId;
    }
}
