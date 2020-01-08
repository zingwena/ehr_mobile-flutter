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

    public Batch() {
    }

    @Ignore
    public Batch(String batchNumber, Date expiryDate) {
        this.batchNumber = batchNumber;
        this.expiryDate = expiryDate;
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

    @Override
    public String toString() {
        return "Batch{" +
                "batchNumber='" + batchNumber + '\'' +
                ", expiryDate=" + expiryDate +
                '}';
    }
}
