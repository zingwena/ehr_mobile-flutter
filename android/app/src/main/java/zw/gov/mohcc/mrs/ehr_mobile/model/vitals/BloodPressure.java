package zw.gov.mohcc.mrs.ehr_mobile.model.vitals;

import androidx.room.Entity;

@Entity
public class BloodPressure extends VitalsBaseEntityId {

    private double systolic;
    private double diastolic;

    public double getSystolic() {
        return systolic;
    }

    public void setSystolic(double systolic) {
        this.systolic = systolic;
    }

    public double getDiastolic() {
        return diastolic;
    }

    public void setDiastolic(double diastolic) {
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
