package zw.gov.mohcc.mrs.ehr_mobile.enumeration;


public enum Gender {
    MALE("MALE"),
    FEMALE("FEMALE"),
    UNKNOWN("UNKNOWN"),
    NON_BINARY("NON_BINARY"),
    NULL_VALS("NULL_VALS");

    private final String sex;

    private Gender (String sex) {
        this.sex = sex;
    }

    public String getSex() {
        return sex;
    }

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
