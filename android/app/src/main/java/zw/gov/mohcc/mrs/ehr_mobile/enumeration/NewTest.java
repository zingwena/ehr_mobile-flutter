package zw.gov.mohcc.mrs.ehr_mobile.enumeration;


public enum NewTest {
    PITC("PITC"),
    CICTC("CICTC");

    private final String newTest;

    NewTest(String newTest) {
        this.newTest = newTest;
    }

    public static NewTest get(String name) {
        switch (name) {
            case "PITC":
                return PITC;
            case "CICTC":
                return CICTC;

            default:
                throw new IllegalArgumentException("Unknown argument passes to method : " + name);
        }
    }

    public String getNewTest() {
        return newTest;
    }
}
