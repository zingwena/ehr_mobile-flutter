package zw.gov.mohcc.mrs.ehr_mobile.dto;

import androidx.annotation.NonNull;
import androidx.room.Embedded;
import java.io.Serializable;
import java.util.Date;
import zw.gov.mohcc.mrs.ehr_mobile.model.terminology.NameCode;
public class LaboratoryInvestigationTestDTO implements Serializable {

    @NonNull
    private String personId;
    @NonNull
    private String visitId;
    @Embedded(prefix = "result_")
    @NonNull
    private NameCode result;
    @Embedded(prefix = "testkit_")
    @NonNull
    private NameCode testkit;
    @NonNull
    private String investigationId;

    public LaboratoryInvestigationTestDTO(@NonNull String personId, @NonNull String visitId, @NonNull NameCode result, @NonNull NameCode testkit, @NonNull String investigationId) {
        this.personId = personId;
        this.visitId = visitId;
        this.result = result;
        this.testkit = testkit;
        this.investigationId = investigationId;
    }

    @NonNull
    public String getPersonId() {
        return personId;
    }

    public void setPersonId(@NonNull String personId) {
        this.personId = personId;
    }

    @NonNull
    public String getVisitId() {
        return visitId;
    }

    public void setVisitId(@NonNull String visitId) {
        this.visitId = visitId;
    }

    @NonNull
    public NameCode getResult() {
        return result;
    }

    public void setResult(@NonNull NameCode result) {
        this.result = result;
    }

    @NonNull
    public NameCode getTestkit() {
        return testkit;
    }

    public void setTestkit(@NonNull NameCode testkit) {
        this.testkit = testkit;
    }

    @NonNull
    public String getInvestigationId() {
        return investigationId;
    }

    public void setInvestigationId(@NonNull String investigationId) {
        this.investigationId = investigationId;
    }

    public InvestigationDTO get(LaboratoryInvestigationTestDTO dto) {

        return new InvestigationDTO(dto.getPersonId(), new Date(), dto.getVisitId(), dto.getInvestigationId(), dto.getResult().getCode());
    }
}
