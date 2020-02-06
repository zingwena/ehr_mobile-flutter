package zw.gov.mohcc.mrs.ehr_mobile.enumeration;

public enum TestForPregnantLactatingMother {
    NEW("NEW"), NONE("NONE"), RETEST("RETEST");

    private final String code;

    TestForPregnantLactatingMother(String code) {
        this.code = code;
    }

    public static TestForPregnantLactatingMother get(String name) {
        switch (name) {
            case "NEW":
                return NEW;
            case "NONE":
                return NONE;
            case "RETEST":
                return RETEST;
            default:
                throw new IllegalArgumentException("Unknown parameter passed to method : " + name);
        }
    }

    public String getCode() {
        return code;
    }
}

