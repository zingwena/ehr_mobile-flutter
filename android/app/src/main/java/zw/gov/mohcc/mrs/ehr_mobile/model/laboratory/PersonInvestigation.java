package zw.gov.mohcc.mrs.ehr_mobile.model.laboratory;


import androidx.annotation.NonNull;
import androidx.room.Entity;
import androidx.room.ForeignKey;
import androidx.room.Ignore;
import androidx.room.Index;
import androidx.room.TypeConverters;

import java.util.Date;

import zw.gov.mohcc.mrs.ehr_mobile.model.BaseEntity;
import zw.gov.mohcc.mrs.ehr_mobile.model.person.Person;
import zw.gov.mohcc.mrs.ehr_mobile.model.terminology.Investigation;
import zw.gov.mohcc.mrs.ehr_mobile.model.terminology.Result;
import zw.gov.mohcc.mrs.ehr_mobile.converter.DateConverter;

import static androidx.room.ForeignKey.CASCADE;

@Entity(indices = {@Index("personId"), @Index("investigationId"), @Index("resultId")},
        foreignKeys = {
                @ForeignKey(entity = Person.class, onDelete = CASCADE,
                        parentColumns = "id",
                        childColumns = "personId"),
                @ForeignKey(entity = Investigation.class, onDelete = CASCADE,
                        parentColumns = "id",
                        childColumns = "investigationId"),
                @ForeignKey(entity = Result.class, onDelete = CASCADE,
                        parentColumns = "code",
                        childColumns = "resultId")})
public class PersonInvestigation extends BaseEntity {

    @NonNull
    private String personId;
    @NonNull
    private String investigationId;
    @TypeConverters(DateConverter.class)
    private Date date;
    private String resultId;

    public PersonInvestigation() {
    }

    @Ignore
    public PersonInvestigation(@NonNull String id, String personId, String investigationId, Date date) {
        super(id);
        this.personId = personId;
        this.investigationId = investigationId;
        this.date = date;
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

    public Date getDate() {
        return date;
    }

    public void setDate(Date date) {
        this.date = date;
    }

    public String getResultId() {
        return resultId;
    }

    public void setResultId(String resultId) {
        this.resultId = resultId;
    }

    @Override
    public String toString() {
        return super.toString().concat("PersonInvestigation{" +
                "personInvestigationId=" + getId() +
                ", patientId='" + personId + '\'' +
                ", investigationId='" + investigationId + '\'' +
                ", date='" + date + '\'' +
                ", resultId='" + resultId + '\'' +
                '}');
    }
}
