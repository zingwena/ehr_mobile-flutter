package zw.gov.mohcc.mrs.ehr_mobile.model;

import androidx.room.Entity;
import androidx.room.ForeignKey;
import androidx.room.Index;
import androidx.room.PrimaryKey;

import static androidx.room.ForeignKey.CASCADE;

@Entity(indices ={ @Index("personId")}, foreignKeys = {@ForeignKey(entity = Person.class, onDelete = CASCADE,
parentColumns = "id", childColumns = "personId")})

public class PatientPhoneNumber {

    @PrimaryKey(autoGenerate = true)
    private String id;
    private String personId;
    private String phoneNumber1;
    private String phoneNumber2;

    public PatientPhoneNumber(String id, String personId, String phoneNumber1, String phoneNumber2) {
        this.id = id;
        this.personId = personId;
        this.phoneNumber1 = phoneNumber1;
        this.phoneNumber2 = phoneNumber2;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getPersonId() {
        return personId;
    }

    public void setPersonId(String personId) {
        this.personId = personId;
    }

    public String getPhoneNumber1() {
        return phoneNumber1;
    }

    public void setPhoneNumber1(String phoneNumber1) {
        this.phoneNumber1 = phoneNumber1;
    }

    public String getPhoneNumber2() {
        return phoneNumber2;
    }

    public void setPhoneNumber2(String phoneNumber2) {
        this.phoneNumber2 = phoneNumber2;
    }
}
