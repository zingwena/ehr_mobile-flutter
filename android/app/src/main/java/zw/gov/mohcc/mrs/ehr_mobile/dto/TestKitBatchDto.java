package zw.gov.mohcc.mrs.ehr_mobile.dto;

import androidx.room.TypeConverters;

import zw.gov.mohcc.mrs.ehr_mobile.converter.DateConverter;
import zw.gov.mohcc.mrs.ehr_mobile.enumeration.BinType;

public class TestKitBatchDto {

    @TypeConverters(BinType.class)
    private BinType binType;
    private String binId;
    private String testKitId;

    public TestKitBatchDto(BinType binType, String binId, String testKitId) {
        this.binType = binType;
        this.binId = binId;
        this.testKitId = testKitId;
    }

    public BinType getBinType() {
        return binType;
    }

    public void setBinType(BinType binType) {
        this.binType = binType;
    }

    public String getBinId() {
        return binId;
    }

    public void setBinId(String binId) {
        this.binId = binId;
    }

    public String getTestKitId() {
        return testKitId;
    }

    public void setTestKitId(String testKitId) {
        this.testKitId = testKitId;
    }
}
