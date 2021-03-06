package zw.gov.mohcc.mrs.ehr_mobile.model.warehouse;

import androidx.room.Embedded;
import androidx.room.Entity;

import zw.gov.mohcc.mrs.ehr_mobile.dto.Batch;
import zw.gov.mohcc.mrs.ehr_mobile.dto.BinTypeIdName;
import zw.gov.mohcc.mrs.ehr_mobile.model.BaseEntity;

@Entity
public class TestKitBatchIssue extends BaseEntity {

    private Double remaining;
    private Boolean statusAccepted;
    private Boolean expiredStatus;
    @Embedded(prefix = "batch_")
    private Batch batch;
    @Embedded(prefix = "detail_")
    private BinTypeIdName detail;
    private Double quantity;

    public TestKitBatchIssue() {
    }

    public Double getRemaining() {
        return remaining;
    }

    public void setRemaining(Double remaining) {
        this.remaining = remaining;
    }

    public Boolean getStatusAccepted() {
        return statusAccepted;
    }

    public void setStatusAccepted(Boolean statusAccepted) {
        this.statusAccepted = statusAccepted;
    }

    public Boolean getExpiredStatus() {
        return expiredStatus;
    }

    public void setExpiredStatus(Boolean expiredStatus) {
        this.expiredStatus = expiredStatus;
    }

    public Batch getBatch() {
        return batch;
    }

    public void setBatch(Batch batch) {
        this.batch = batch;
    }

    public Double getQuantity() {
        return quantity;
    }

    public void setQuantity(Double quantity) {
        this.quantity = quantity;
    }

    public BinTypeIdName getDetail() {
        return detail;
    }

    public void setDetail(BinTypeIdName detail) {
        this.detail = detail;
    }

    @Override
    public String toString() {
        return "TestKitBatchIssue{" +
                "remaining=" + remaining +
                ", statusAccepted=" + statusAccepted +
                ", expiredStatus=" + expiredStatus +
                ", batch=" + batch +
                ", detail=" + detail +
                ", quantity=" + quantity +
                '}';
    }
}
