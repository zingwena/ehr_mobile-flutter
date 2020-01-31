package zw.gov.mohcc.mrs.ehr_mobile.enumeration;

public enum BinType {

    QUEUE("QUEUE"), WARD("WARD");

    private final String binType;

    BinType(String binType) {
        this.binType = binType;
    }

    public static BinType get(String name) {
        switch (name) {
            case "QUEUE":
                return QUEUE;
            case "WARD":
                return WARD;
            default:
                throw new IllegalArgumentException("Unknown argument passes to method : " + name);
        }
    }

    public String getBinType() {
        return binType;
    }
}
