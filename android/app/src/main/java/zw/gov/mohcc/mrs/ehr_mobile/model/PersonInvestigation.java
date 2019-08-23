package zw.gov.mohcc.mrs.ehr_mobile.model;


import androidx.room.ColumnInfo;
import androidx.room.Entity;
import androidx.room.PrimaryKey;

import com.android.tools.r8.org.intellij.lang.annotations.Identifier;

import org.jetbrains.annotations.Nullable;

import java.util.Date;

@Entity
public class PersonInvestigation {
    @PrimaryKey(autoGenerate = true)
    private String personInvestigationId;

    @ColumnInfo(name = "personId")
    private String personId;

    @ColumnInfo(name = "investigationId")
    private String investigationId;

    @ColumnInfo(name = "sample")
    private BaseNameModel sample;

    @ColumnInfo(name = "test")
    private BaseNameModel test;

    @ColumnInfo(name = "date")
    private Date date;

    @ColumnInfo(name = "note")
    private  String note;

    @ColumnInfo(name = "result")
    private BaseNameModel result;

    public String getPersonInvestigationId() {
        return personInvestigationId;
    }

    public void setPersonInvestigationId(String personInvestigationId) {
        this.personInvestigationId = personInvestigationId;
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

    public BaseNameModel getSample() {
        return sample;
    }

    public void setSample(BaseNameModel sample) {
        this.sample = sample;
    }

    public Date getDate() {
        return date;
    }

    public void setDate(Date date) {
        this.date = date;
    }

    public String getNote() {
        return note;
    }

    public void setNote(String note) {
        this.note = note;
    }

    public BaseNameModel getResult() {
        return result;
    }

    public void setResult(BaseNameModel result) {
        this.result = result;
    }
}
