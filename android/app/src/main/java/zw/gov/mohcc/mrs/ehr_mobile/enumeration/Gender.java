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

        for (Gender item : values()) {
            if(item.getSex().equals(name)) {
                return item;
            }
        }
        throw new IllegalArgumentException("Unknown argument passes to method : " + name);
    }
}
