package zw.gov.mohcc.mrs.ehr_mobile.enumeration;


public enum CoupleCounselling {
    YES(0),
    NO(1);

    private final int coupleCounselling;

    private CoupleCounselling(int coupleCounselling) {
        this.coupleCounselling = coupleCounselling;
    }

    public int getCoupleCounselling() {
        return coupleCounselling;
    }

    public static CoupleCounselling get(String name) {
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
