package zw.gov.mohcc.mrs.ehr_mobile.model;


public enum NewTestPregLact {
    YES(0),
    NO(1);

    private final int newTestPregLact;

    private NewTestPregLact(int newTestPregLact) {
        this.newTestPregLact = newTestPregLact;
    }

    public int getNewTestPregLact() {
        return newTestPregLact;
    }

    public static NewTestPregLact get(String name) {
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
