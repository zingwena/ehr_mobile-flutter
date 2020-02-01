package zw.gov.mohcc.mrs.ehr_mobile.enumeration;


public enum CoupleCounselling {
    YES("YES"),
    NO("NO");

    private final String coupleCounselling;

    CoupleCounselling(String coupleCounselling) {
        this.coupleCounselling = coupleCounselling;
    }

    public static CoupleCounselling get(String name) {

        for (CoupleCounselling item : values()) {
            if (item.getCoupleCounselling().equals(item)) {
                return item;
            }
        }
        throw new IllegalArgumentException("Unknown argument passes to method : " + name);
    }

    public String getCoupleCounselling() {
        return coupleCounselling;
    }
}
