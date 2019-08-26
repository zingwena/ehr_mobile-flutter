package zw.gov.mohcc.mrs.ehr_mobile.model;


public enum PreTestInfoGiven {
    YES(0),
    NO(1);

    private final int preTestInfoGiven;

    private PreTestInfoGiven(int preTestInfoGiven) {
        this.preTestInfoGiven = preTestInfoGiven;
    }

    public int getPreTestInfoGiven() {
        return preTestInfoGiven;
    }

    public static PreTestInfoGiven get(String name) {
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
