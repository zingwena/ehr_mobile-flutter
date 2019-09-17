package zw.gov.mohcc.mrs.ehr_mobile.model;

import androidx.room.Entity;
import androidx.room.ForeignKey;
import androidx.room.Index;
import androidx.room.PrimaryKey;

import static androidx.room.ForeignKey.CASCADE;

@Entity(indices ={ @Index("personId")}, foreignKeys = {@ForeignKey(entity = Patient.class, onDelete = CASCADE,
parentColumns = "id", childColumns = "personId")})

public class PatientPhoneNumber {

    @PrimaryKey(autoGenerate = true)
    private int id;
    private int patientId;
    private String personId;
    private String phonenumber_1;
    private String phonenumber_2;

    /*public PatientPhoneNumber(String personId, String phonenumber_1, String phonenumber_2) {
        this.personId = personId;
        this.phonenumber_1 = phonenumber_1;
        this.phonenumber_2 = phonenumber_2;
    }*/
    public PatientPhoneNumber(int patientId, String phonenumber_1, String phonenumber_2) {
        this.patientId = patientId;
        this.phonenumber_1 = phonenumber_1;
        this.phonenumber_2 = phonenumber_2;
    }
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getPersonId() {
        return personId;
    }

    public void setPersonId(String personId) {
        this.personId = personId;
    }

    public String getPhonenumber_1() {
        return phonenumber_1;
    }

    public void setPhonenumber_1(String phonenumber_1) {
        this.phonenumber_1 = phonenumber_1;
    }

    public String getPhonenumber_2() {
        return phonenumber_2;
    }

    public void setPhonenumber_2(String phonenumber_2) {
        this.phonenumber_2 = phonenumber_2;
    }

    public int getPatientId() {
        return patientId;
    }

    public void setPatientId(int patientId) {
        this.patientId = patientId;
    }
}
