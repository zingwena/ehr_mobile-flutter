package zw.gov.mohcc.mrs.ehr_mobile.model.vitals;

import androidx.room.Entity;

@Entity
public class BloodPressure extends VitalsBaseEntityId {
    private String systolic;
    private String diastolic;

    public String getSystolic() {
        return systolic;
    }

    public void setSystolic(String systolic) {
        this.systolic = systolic;
    }

    public String getDiastolic() {
        return diastolic;
    }

    public void setDiastolic(String diastolic) {
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
