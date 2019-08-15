package zw.gov.mohcc.mrs.ehr_mobile.model;


public enum Gender {
    MALE,
    FEMALE,
    UNKNOWN,
    NON_BINARY;

    public static Gender get(String name) {
        switch (name) {
            case "MALE":
                return MALE;
            case "FEMALE":
                return FEMALE;
            case "UNKNOWN":
                return UNKNOWN;
            case "NON_BINARY":
                return NON_BINARY;
            default:
                throw new IllegalArgumentException("Unknown argument passes to method : " + name);
        }
    }
}
