package zw.gov.mohcc.mrs.ehr_mobile.model.vitals;

import androidx.annotation.NonNull;

public class VitalsBaseValue extends VitalsBaseEntityId {

    @NonNull
    private Double value;

    @NonNull
    public Double getValue() {
        return value;
    }

    public void setValue(@NonNull Double value) {
        this.value = value;
    }

    @Override
    public String toString() {
        return super.toString().concat("VitalsBaseValue{" +
                "value='" + value + '\'' +
                '}');
    }
}
