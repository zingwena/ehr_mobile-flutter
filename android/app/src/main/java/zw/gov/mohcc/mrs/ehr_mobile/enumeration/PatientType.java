package zw.gov.mohcc.mrs.ehr_mobile.enumeration;

public enum PatientType {

    OUTPATIENT(0), INPATIENT(1);

    private final Integer patientType;

    PatientType(Integer patientType) {
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

    public Integer getPatientType() {
        return patientType;
    }
}
