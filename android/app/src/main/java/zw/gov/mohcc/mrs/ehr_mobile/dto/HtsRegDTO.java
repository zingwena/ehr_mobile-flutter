package zw.gov.mohcc.mrs.ehr_mobile.dto;

import androidx.room.TypeConverters;

import java.util.Date;
import java.util.UUID;

import zw.gov.mohcc.mrs.ehr_mobile.model.Hts;
import zw.gov.mohcc.mrs.ehr_mobile.model.HtsType;
import zw.gov.mohcc.mrs.ehr_mobile.util.DateConverter;
import zw.gov.mohcc.mrs.ehr_mobile.util.HtsTypeConverter;

public class HtsRegDTO {

    private String visitId;
    private String htsType;
    @TypeConverters(DateConverter.class)
    private Date dateOfHivTest;
    private String entryPointId;

    public String getVisitId() {
        return visitId;
    }

    public void setVisitId(String visitId) {
        this.visitId = visitId;
    }

    public String getHtsType() {
        return htsType;
    }

    public void setHtsType(String htsType) {
        this.htsType = htsType;
    }

    public Date getDateOfHivTest() {
        return dateOfHivTest;
    }

    public void setDateOfHivTest(Date dateOfHivTest) {
        this.dateOfHivTest = dateOfHivTest;
    }

    public String getEntryPointId() {
        return entryPointId;
    }

    public void setEntryPointId(String entryPointId) {
        this.entryPointId = entryPointId;
    }

    public static Hts getInstance(HtsRegDTO dto) {
        String htsId = UUID.randomUUID().toString();
        Hts hts = new Hts();
        hts.setId(htsId);
        hts.setDateOfHivTest(dto.getDateOfHivTest());
        hts.setHtsType(dto.getHtsType());
        hts.setEntryPointId(dto.getEntryPointId());
        return hts;
    }
}
