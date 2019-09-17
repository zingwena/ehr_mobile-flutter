package zw.gov.mohcc.mrs.ehr_mobile.model.vitals;

public enum TestForPregnantLactatingMother {
    NEW(0), NONE(1), RETEST(2);

    private final int code;

    TestForPregnantLactatingMother(int code) {
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

    public int getCode() {
        return code;
    }
}

