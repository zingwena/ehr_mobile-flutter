package zw.gov.mohcc.mrs.ehr_mobile.model;


public enum OptOutOfTest {
    YES(0),
    NO(1);

    private final int optOutOfTest;

    private OptOutOfTest(int optOutOfTest) {
        this.optOutOfTest = optOutOfTest;
    }

    public int getOptOutOfTest() {
        return optOutOfTest;
    }

    public static OptOutOfTest get(String name) {
        switch (name) {
            case "YES":
                return YES;
            case "NO":
                return NO;

            default:
                throw new IllegalArgumentException("Unknown argument passes to method : " + name);
        }
    }
}
