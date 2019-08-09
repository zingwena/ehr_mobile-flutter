package zw.gov.mohcc.mrs.ehr_mobile.model;


import androidx.room.Entity;
import androidx.room.Ignore;
@Entity()
public enum Gender {
    MALE("Male"),
    FEMALE("Female"),
    UNKNOWN("Unknown"),
    NON_BINARY("Non_Binary");

    private String gender;

  Gender(String gender) {
         this.gender=gender;
    }

    public String getGender() {
        return gender;
    }
}
