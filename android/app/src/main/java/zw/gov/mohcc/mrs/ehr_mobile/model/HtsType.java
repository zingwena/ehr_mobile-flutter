package zw.gov.mohcc.mrs.ehr_mobile.model;


public enum HtsType {
    SELF(0),
    RAPID(1);

    private final int htsType;

    HtsType(int htsType) {
        this.htsType = htsType;
    }

    public static HtsType get(String name) {
        switch (name) {
            case "SELF":
                return SELF;
            case "RAPID":
                return RAPID;

            default:
                throw new IllegalArgumentException("Unknown argument passes to method : " + name);
        }
    }

    public static HtsType getInt(int htsType) {
        for (HtsType type : values()) {
            if (type.getHtsType() == htsType) {
                return type;
            }
        }
        throw new IllegalArgumentException("Unknown argument passes to method : " + htsType);
    }

    public int getHtsType() {
        return htsType;
    }
}
