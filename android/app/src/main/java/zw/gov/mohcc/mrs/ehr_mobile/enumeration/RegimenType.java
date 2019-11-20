package zw.gov.mohcc.mrs.ehr_mobile.enumeration;

public enum RegimenType {

    FIRST_LINE(0), SECOND_LINE(1), THIRD_LINE(2);

    private final int regimenType;

    RegimenType(Integer regimenType) {
        this.regimenType = regimenType;
    }

    public static RegimenType get(String name) {
        switch (name) {
            case "FIRST_LINE":
                return FIRST_LINE;
            case "SECOND_LINE":
                return SECOND_LINE;
            case "THIRD_LINE":
                return THIRD_LINE;
            default:
                throw new IllegalArgumentException("Unknown argument passes to method : " + name);
        }
    }

    public Integer getRegimenType() {
        return regimenType;
    }
}
