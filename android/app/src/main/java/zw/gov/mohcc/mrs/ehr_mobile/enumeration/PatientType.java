package zw.gov.mohcc.mrs.ehr_mobile.enumeration;

public enum PatientType {

    OUTPATIENT("OUTPATIENT"), INPATIENT("INPATIENT");

    private final String patientType;

    PatientType(String patientType) {
        this.patientType = patientType;
    }

    public static PatientType get(String name) {
        switch (name) {
            case "OUTPATIENT":
                return OUTPATIENT;
            case "INPATIENT":
                return INPATIENT;
            default:
                throw new IllegalArgumentException("Illegal parameter passed to method");
        }
    }

    public String getPatientType() {
        return patientType;
    }
}
