package zw.gov.mohcc.mrs.ehr_mobile.model;


import androidx.room.Entity;
@Entity()
public enum Gender {
    MALE(0),
    FEMALE(1),
    UNKNOWN(2),
    NON_BINARY(3);

    private int gender;

  Gender(int gender) {
         this.gender=gender;
    }

    public int getGender() {
        return gender;
    }
}
