package zw.gov.mohcc.mrs.ehr_mobile.model.terminology;


import androidx.annotation.NonNull;
import androidx.room.Entity;
import androidx.room.ForeignKey;
import androidx.room.Ignore;
import androidx.room.Index;

import zw.gov.mohcc.mrs.ehr_mobile.model.BaseEntity;

import static androidx.room.ForeignKey.CASCADE;

@Entity(indices = {@Index("investigationId"), @Index("testKitId")},
        foreignKeys = {@ForeignKey(entity = Investigation.class, onDelete = CASCADE,
                parentColumns = "id",
                childColumns = "investigationId"),
                @ForeignKey(entity = TestKit.class, onDelete = CASCADE,
                        parentColumns = "code",
                        childColumns = "testKitId")})
public class InvestigationTestkit extends BaseEntity {

    private String investigationId;
    private String testKitId;

    public InvestigationTestkit() {
    }

    @Ignore
    public InvestigationTestkit(@NonNull String id, String investigationId, String testKitId) {
        super(id);
        this.investigationId = investigationId;
        this.testKitId = testKitId;
    }

    public String getInvestigationId() {
        return investigationId;
    }

    public void setInvestigationId(String investigationId) {
        this.investigationId = investigationId;
    }

    public String getTestKitId() {
        return testKitId;
    }

    public void setTestKitId(String testKitId) {
        this.testKitId = testKitId;
    }
}
