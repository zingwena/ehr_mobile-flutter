package zw.gov.mohcc.mrs.ehr_mobile.model.warehouse;

import androidx.room.Embedded;
import androidx.room.Entity;
import androidx.room.TypeConverters;

import java.util.Date;

import zw.gov.mohcc.mrs.ehr_mobile.converter.DateConverter;
import zw.gov.mohcc.mrs.ehr_mobile.model.BaseEntity;
import zw.gov.mohcc.mrs.ehr_mobile.model.terminology.NameCode;

@Entity
public class TestKitBatch extends BaseEntity {

    private String batchNumber;

    @TypeConverters(DateConverter.class)
    private Date expiryDate;

    @Embedded(prefix = "testKit_")
    private NameCode testKit;

    @TypeConverters(DateConverter.class)
    private Date dateReceived;

    @Embedded(prefix = "supplier_")
    private NameCode supplier;

    @Embedded(prefix = "manufacture_")
    private NameCode manufacture;

    @Embedded(prefix = "packSize_")
    private NameCode packSize;

    private Double received;

    private double price;

    public TestKitBatch() {
    }

    public String getBatchNumber() {
        return batchNumber;
    }

    public void setBatchNumber(String batchNumber) {
        this.batchNumber = batchNumber;
    }

    public Date getExpiryDate() {
        return expiryDate;
    }

    public void setExpiryDate(Date expiryDate) {
        this.expiryDate = expiryDate;
    }

    public NameCode getTestKit() {
        return testKit;
    }

    public void setTestKit(NameCode testKit) {
        this.testKit = testKit;
    }

    public Date getDateReceived() {
        return dateReceived;
    }

    public void setDateReceived(Date dateReceived) {
        this.dateReceived = dateReceived;
    }

    public NameCode getSupplier() {
        return supplier;
    }

    public void setSupplier(NameCode supplier) {
        this.supplier = supplier;
    }

    public NameCode getManufacture() {
        return manufacture;
    }

    public void setManufacture(NameCode manufacture) {
        this.manufacture = manufacture;
    }

    public NameCode getPackSize() {
        return packSize;
    }

    public void setPackSize(NameCode packSize) {
        this.packSize = packSize;
    }

    public Double getReceived() {
        return received;
    }

    public void setReceived(Double received) {
        this.received = received;
    }

    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
    }
}
