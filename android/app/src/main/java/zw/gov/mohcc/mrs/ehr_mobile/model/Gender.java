package zw.gov.mohcc.mrs.ehr_mobile.model;


public enum Gender {
    MALE(0),
    FEMALE(1),
    UNKNOWN(2),
    NON_BINARY(3),
    NULL_VALS(-1);

    private final int sex;

    private Gender (int sex) {
        this.sex = sex;
    }

    public int getSex() {
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
