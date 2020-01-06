package zw.gov.mohcc.mrs.ehr_mobile.model.warehouse;

import androidx.annotation.NonNull;
import androidx.room.Embedded;
import androidx.room.Entity;
import androidx.room.TypeConverters;

import java.util.Date;

import zw.gov.mohcc.mrs.ehr_mobile.converter.BinTypeConverter;
import zw.gov.mohcc.mrs.ehr_mobile.enumeration.BinType;
import zw.gov.mohcc.mrs.ehr_mobile.model.BaseEntity;
import zw.gov.mohcc.mrs.ehr_mobile.model.terminology.NameCode;

@Entity
public class TestKitBatchIssue extends BaseEntity {

    @NonNull
    private String testKitBatchId;

    @Embedded(prefix = "bin_")
    private NameCode bin;

    @NonNull
    @TypeConverters(BinTypeConverter.class)
    private BinType binType;

    @Embedded(prefix = "packSize_")
    private NameCode packSize;

    private Double quantity;

    private Date date;

    public TestKitBatchIssue() {
    }

    @NonNull
    public String getTestKitBatchId() {
        return testKitBatchId;
    }

    public void setTestKitBatchId(@NonNull String testKitBatchId) {
        this.testKitBatchId = testKitBatchId;
    }

    public NameCode getBin() {
        return bin;
    }

    public void setBin(NameCode bin) {
        this.bin = bin;
    }

    @NonNull
    public BinType getBinType() {
        return binType;
    }

    public void setBinType(@NonNull BinType binType) {
        this.binType = binType;
    }

    public NameCode getPackSize() {
        return packSize;
    }

    public void setPackSize(NameCode packSize) {
        this.packSize = packSize;
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
}
