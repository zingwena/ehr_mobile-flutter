package zw.gov.mohcc.mrs.ehr_mobile.vitals;

public class VitalsBaseValue extends VitalsBaseEntityId {
    private String value;

    public String getValue() {
        return value;
    }

    public void setValue(String value) {
        this.value = value;
    }

    @Override
    public String toString() {
        return super.toString() + "VitalsBaseValue{" +
                "value='" + value + '\'' +
                '}';
    }
}
