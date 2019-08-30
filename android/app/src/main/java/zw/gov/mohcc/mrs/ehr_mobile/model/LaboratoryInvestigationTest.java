package zw.gov.mohcc.mrs.ehr_mobile.model;

import androidx.room.Entity;
import androidx.room.PrimaryKey;
import androidx.room.TypeConverters;

import java.util.Date;

import zw.gov.mohcc.mrs.ehr_mobile.util.DateConverter;

@Entity
public class LaboratoryInvestigationTest {
    @PrimaryKey(autoGenerate = true)
    private int id;
    private String laboratoryInvestigationId;
    @TypeConverters(DateConverter.class)
    private Date readingdate;
    @TypeConverters(DateConverter.class)
    private Date readingtime;
    private String visitId;
    private String resultId;

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getVisitId() {
        return visitId;
    }

    public void setVisitId(String visitId) {
        this.visitId = visitId;
    }

    public String getLaboratoryInvestigationId() {
        return laboratoryInvestigationId;
    }

    public void setLaboratoryInvestigationId(String laboratoryInvestigationId) {
        this.laboratoryInvestigationId = laboratoryInvestigationId;
    }

    public Date getReadingdate() {
        return readingdate;
    }

    public void setReadingdate(Date readingdate) {
        this.readingdate = readingdate;
    }

    public Date getReadingtime() {
        return readingtime;
    }

    public void setReadingtime(Date readingtime) {
        this.readingtime = readingtime;
    }

    public String getResultId() {
        return resultId;
    }

    public void setResultId(String resultId) {
        this.resultId = resultId;
    }

}
