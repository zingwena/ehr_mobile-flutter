package zw.gov.mohcc.mrs.ehr_mobile.enumeration;


public enum NewTest {
    PITC("PITC"),
    CICTC("CICTC");

    private final String newTest;

    NewTest(String newTest) {
        this.newTest = newTest;
    }

    public static NewTest get(String name) {

        for (NewTest item : values()) {
            if (item.getNewTest().equals(name)) {
                return item;
            }
        }
        throw new IllegalArgumentException("Unknown argument passes to method : " + name);
    }

    public String getNewTest() {
        return newTest;
    }
}
