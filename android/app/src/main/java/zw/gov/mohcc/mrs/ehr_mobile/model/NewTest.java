package zw.gov.mohcc.mrs.ehr_mobile.model;


public enum NewTest {
    PITC(0),
    CICTC(1);

    private final int newTest;

    private NewTest(int newTest) {
        this.newTest = newTest;
    }

    public int getNewTest() {
        return newTest;
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
}
