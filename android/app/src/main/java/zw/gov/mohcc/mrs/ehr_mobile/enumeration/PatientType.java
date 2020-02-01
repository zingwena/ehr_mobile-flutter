package zw.gov.mohcc.mrs.ehr_mobile.enumeration;

public enum PatientType {

    OUTPATIENT("OUTPATIENT"), INPATIENT("INPATIENT");

    private final String patientType;

    PatientType(String patientType) {
        this.patientType = patientType;
    }

    public static PatientType get(String name) {

        for (PatientType item : values()) {
            if (item.getPatientType().equals(name)) {
                return item;
            }
        }
        throw new IllegalArgumentException("Unknown argument passes to method : " + name);
    }

    public String getPatientType() {
        return patientType;
    }
}
