package zw.gov.mohcc.mrs.ehr_mobile.model;


import androidx.room.ColumnInfo;
import androidx.room.Entity;
import androidx.room.PrimaryKey;


import java.util.Date;

@Entity
public class PersonInvestigation {
    @PrimaryKey(autoGenerate = true)
    private int personInvestigationId;

    @ColumnInfo(name = "personId")
    private String personId;

    @ColumnInfo(name = "investigationId")
    private String investigationId;

    @ColumnInfo(name = "sample")
    private int sampleId;

    @ColumnInfo(name = "test")
    private String test;

    @ColumnInfo(name = "date")
    private String date;

    @ColumnInfo(name = "note")
    private  String note;

    @ColumnInfo(name = "result")
    private String result;


    public PersonInvestigation(int personInvestigationId, String personId, String investigationId, int sampleId, String test, String date, String note, String result) {
        this.personInvestigationId = personInvestigationId;
        this.personId = personId;
        this.investigationId = investigationId;
        this.sampleId = sampleId;
        this.test = test;
        this.date = date;
        this.note = note;
        this.result = result;
    }

    public int getPersonInvestigationId() {
        return personInvestigationId;
    }

    public String getPersonId() {
        return personId;
    }

    public void setPersonId(String personId) {
        this.personId = personId;
    }

    public String getInvestigationId() {
        return investigationId;
    }

    public void setInvestigationId(String investigationId) {
        this.investigationId = investigationId;
    }

    public int getSampleId() {
        return sampleId;
    }

    public void setSampleId(int sampleId) {
        this.sampleId = sampleId;
    }

    public String getTest() {
        return test;
    }

    public void setTest(String test) {
        this.test = test;
    }

    public void setPersonInvestigationId(int personInvestigationId) {
        this.personInvestigationId = personInvestigationId;
    }

    public String getDate() {
        return date;
    }

    public void setDate(String date) {
        this.date = date;
    }

    public String getNote() {
        return note;
    }

    public void setNote(String note) {
        this.note = note;
    }

    public String getResult() {
        return result;
    }

    public void setResult(String result) {
        this.result = result;
    }
}
