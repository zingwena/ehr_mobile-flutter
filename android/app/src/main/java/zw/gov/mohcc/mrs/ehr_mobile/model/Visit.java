package zw.gov.mohcc.mrs.ehr_mobile.model;

import androidx.annotation.NonNull;
import androidx.room.Embedded;
import androidx.room.Entity;
import androidx.room.ForeignKey;
import androidx.room.Ignore;
import androidx.room.Index;
import androidx.room.TypeConverters;

import java.util.Date;

import zw.gov.mohcc.mrs.ehr_mobile.converter.DateConverter;
import zw.gov.mohcc.mrs.ehr_mobile.converter.PatientTypeConverter;
import zw.gov.mohcc.mrs.ehr_mobile.enumeration.PatientType;
import zw.gov.mohcc.mrs.ehr_mobile.model.person.Person;
import zw.gov.mohcc.mrs.ehr_mobile.model.terminology.Facility;
import zw.gov.mohcc.mrs.ehr_mobile.model.terminology.NameCode;

@Entity(indices = {@Index(value = "personId"), @Index("code")},
        foreignKeys = {@ForeignKey(entity = Person.class, onDelete = ForeignKey.CASCADE,
                parentColumns = "id",
                childColumns = "personId"),
                @ForeignKey(entity = Facility.class, onDelete = ForeignKey.CASCADE,
                        parentColumns = "code",
                        childColumns = "code")})
public class Visit extends BaseEntity {

    @NonNull
    private String personId;
    @TypeConverters(PatientTypeConverter.class)
    @NonNull
    private PatientType patientType;
    @TypeConverters(DateConverter.class)
    private Date time;
    @TypeConverters(DateConverter.class)
    private Date discharged;
    private String hospitalNumber;
    @Embedded
    @NonNull
    private NameCode facility;

    public Visit() {
    }

    @Ignore
    public Visit(@NonNull String id, @NonNull String personId, @NonNull PatientType patientType, @NonNull Date time) {
        super(id);
        this.personId = personId;
        this.patientType = patientType;
        this.time = time;
    }

    @NonNull
    public String getPersonId() {
        return personId;
    }

    public void setPersonId(@NonNull String personId) {
        this.personId = personId;
    }

    @NonNull
    public PatientType getPatientType() {
        return patientType;
    }

    public void setPatientType(@NonNull PatientType patientType) {
        this.patientType = patientType;
    }

    public Date getTime() {
        return time;
    }

    public void setTime(Date time) {
        this.time = time;
    }

    public Date getDischarged() {
        return discharged;
    }

    public void setDischarged(Date discharged) {
        this.discharged = discharged;
    }

    public String getHospitalNumber() {
        return hospitalNumber;
    }

    public void setHospitalNumber(String hospitalNumber) {
        this.hospitalNumber = hospitalNumber;
    }

    public NameCode getFacility() {
        return facility;
    }

    public void setFacility(NameCode facility) {
        this.facility = facility;
    }

    @Override
    public String toString() {
        return super.toString().concat("Visit{" +
                "personId='" + personId + '\'' +
                ", patientType=" + patientType +
                ", time=" + time +
                ", discharged=" + discharged +
                ", hospitalNumber='" + hospitalNumber + '\'' +
                ", facility=" + facility +
                '}');
    }
}
