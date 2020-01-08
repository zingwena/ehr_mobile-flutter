package zw.gov.mohcc.mrs.ehr_mobile.model.warehouse;

import androidx.annotation.NonNull;
import androidx.room.Embedded;
import androidx.room.Entity;
import androidx.room.TypeConverters;

import java.util.Date;

import zw.gov.mohcc.mrs.ehr_mobile.converter.DateConverter;
import zw.gov.mohcc.mrs.ehr_mobile.dto.Batch;
import zw.gov.mohcc.mrs.ehr_mobile.dto.BinTypeIdName;
import zw.gov.mohcc.mrs.ehr_mobile.model.BaseEntity;
import zw.gov.mohcc.mrs.ehr_mobile.model.terminology.NameCode;

@Entity
public class TestKitBatchIssue extends BaseEntity {

    @NonNull
    private String binType;
    private Double remaining;
    private Boolean statusAccepted;
    private Boolean expiredStatus;
    @Embedded(prefix = "batch_")
    private Batch batch;
    @Embedded(prefix = "detail_")
    private BinTypeIdName detail;
    private Double quantity;

    @TypeConverters(DateConverter.class)
    private Date date;

    public TestKitBatchIssue() {
    }

    @NonNull
    public String getBinType() {
        return binType;
    }

    public void setBinType(@NonNull String binType) {
        this.binType = binType;
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

    public Date getDate() {
        return date;
    }

    public void setDate(Date date) {
        this.date = date;
    }

    public BinTypeIdName getDetail() {
        return detail;
    }

    public void setDetail(BinTypeIdName detail) {
        this.detail = detail;
    }
}
