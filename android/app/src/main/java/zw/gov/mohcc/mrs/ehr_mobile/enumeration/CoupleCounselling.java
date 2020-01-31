package zw.gov.mohcc.mrs.ehr_mobile.enumeration;


public enum CoupleCounselling {
    YES("YES"),
    NO("NO");

    private final String coupleCounselling;

    private CoupleCounselling(String coupleCounselling) {
        this.coupleCounselling = coupleCounselling;
    }

    public String getCoupleCounselling() {
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
