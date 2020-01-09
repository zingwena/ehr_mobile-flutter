package zw.gov.mohcc.mrs.ehr_mobile.dto;

import androidx.room.Ignore;
import androidx.room.TypeConverters;

import java.io.Serializable;
import java.util.Date;

import zw.gov.mohcc.mrs.ehr_mobile.converter.DateConverter;

public class Batch implements Serializable {

    private String batchNumber;
    @TypeConverters(DateConverter.class)
    private Date expiryDate;
    private String textKitId;
    private String testKitName;

    public Batch() {
    }

    @Ignore
    public Batch(String batchNumber, Date expiryDate, String textKitId, String testKitName) {
        this.batchNumber = batchNumber;
        this.expiryDate = expiryDate;
        this.textKitId = textKitId;
        this.testKitName = testKitName;
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

    public String getTextKitId() {
        return textKitId;
    }

    public void setTextKitId(String textKitId) {
        this.textKitId = textKitId;
    }

    public String getTestKitName() {
        return testKitName;
    }

    public void setTestKitName(String testKitName) {
        this.testKitName = testKitName;
    }

    @Override
    public String toString() {
        return "Batch{" +
                "batchNumber='" + batchNumber + '\'' +
                ", expiryDate=" + expiryDate +
                ", textKitId='" + textKitId + '\'' +
                ", testKitName='" + testKitName + '\'' +
                '}';
    }
}
