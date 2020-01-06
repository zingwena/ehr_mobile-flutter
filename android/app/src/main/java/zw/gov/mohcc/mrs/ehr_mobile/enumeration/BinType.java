package zw.gov.mohcc.mrs.ehr_mobile.enumeration;

public enum BinType {

    QUEUE(0), WARD(1);

    private final int binType;

    BinType(Integer binType) {
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

    public Integer getBinType() {
        return binType;
    }
}
