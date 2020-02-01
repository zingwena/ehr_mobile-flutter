package zw.gov.mohcc.mrs.ehr_mobile.enumeration;


public enum HtsType {
    SELF("SELF"),
    RAPID("RAPID");

    private final String htsType;

    HtsType(String htsType) {
        this.htsType = htsType;
    }

    public static HtsType get(String htsType) {
        for (HtsType type : values()) {
            if (type.getHtsType().equals(htsType)) {
                return type;
            }
        }
        throw new IllegalArgumentException("Unknown argument passes to method : " + htsType);
    }

    public String getHtsType() {
        return htsType;
    }
}
