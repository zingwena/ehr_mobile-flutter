package zw.gov.mohcc.mrs.ehr_mobile.enumeration;

public enum BinType {

    QUEUE("QUEUE"), WARD("WARD");

    private final String binType;

    BinType(String binType) {
        this.binType = binType;
    }

    public static BinType get(String name) {

        for (BinType item : values()) {
            if (item.getBinType().equals(name)) {
                return item;
            }
        }
        throw new IllegalArgumentException("Unknown argument passes to method : " + name);
    }

    public String getBinType() {
        return binType;
    }
}
