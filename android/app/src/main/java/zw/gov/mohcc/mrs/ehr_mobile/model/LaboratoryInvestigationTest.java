package zw.gov.mohcc.mrs.ehr_mobile.model;

import androidx.room.Entity;
import androidx.room.TypeConverters;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.Date;

import zw.gov.mohcc.mrs.ehr_mobile.util.DateConverter;

@Entity
public class LaboratoryInvestigationTest {

    private int id;
    private String laboratoryInvestigationId;
    @TypeConverters(DateConverter.class)
    private Date startdate;
    @TypeConverters(DateConverter.class)
    private Date starttime;
    @TypeConverters(DateConverter.class)
    private Date readingdate;
    @TypeConverters(DateConverter.class)
    private Date readingtime;
    private Result result;
    private String visitId;

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getLaboratoryInvestigationId() {
        return laboratoryInvestigationId;
    }

    public void setLaboratoryInvestigationId(String laboratoryInvestigationId) {
        this.laboratoryInvestigationId = laboratoryInvestigationId;
    }

    public Date getStartdate() {
        return startdate;
    }

    public void setStartdate(Date startdate) {
        this.startdate = startdate;
    }

    public Date getStarttime() {
        return starttime;
    }

    public void setStarttime(Date starttime) {
        this.starttime = starttime;
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

    public Result getResult() {
        return result;
    }

    public void setResult(Result result) {
        this.result = result;
    }

    public String getVisitId() {
        return visitId;
    }

    public void setVisitId(String visitId) {
        this.visitId = visitId;
    }
}
