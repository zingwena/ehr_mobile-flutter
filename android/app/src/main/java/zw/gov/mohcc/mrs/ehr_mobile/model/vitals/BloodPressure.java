package zw.gov.mohcc.mrs.ehr_mobile.model.vitals;

import androidx.annotation.NonNull;
import androidx.room.Entity;
import androidx.room.ForeignKey;
import androidx.room.Index;

import zw.gov.mohcc.mrs.ehr_mobile.model.Visit;
import zw.gov.mohcc.mrs.ehr_mobile.model.person.Person;

@Entity(indices = {@Index("visitId"), @Index("personId")},
        foreignKeys = {
                @ForeignKey(entity = Visit.class, onDelete = ForeignKey.CASCADE,
                        parentColumns = "id",
                        childColumns = "visitId"),
                @ForeignKey(entity = Person.class, onDelete = ForeignKey.CASCADE,
                        parentColumns = "id",
                        childColumns = "personId")})
public class BloodPressure extends VitalsBaseEntityId {

    @NonNull
    private Double systolic;
    @NonNull
    private Double diastolic;

    public double getSystolic() {
        return systolic;
    }

    public void setSystolic(@NonNull Double systolic) {
        this.systolic = systolic;
    }

    public Double getDiastolic() {
        return diastolic;
    }

    public void setDiastolic(@NonNull Double diastolic) {
        this.diastolic = diastolic;
    }

    @Override
    public String toString() {
        return super.toString().concat("BloodPressure{" +
                "systolic='" + systolic + '\'' +
                ", diastolic='" + diastolic + '\'' +
                '}');
    }
}
