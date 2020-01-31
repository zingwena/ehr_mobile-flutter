package zw.gov.mohcc.mrs.ehr_mobile.enumeration;


public enum HtsApproach {
    PITC("PITC"),
    CICTC("CICTC");

    private final String htsApproach;

    private HtsApproach(String htsApproach) {
        this.htsApproach = htsApproach;
    }

    public String getHtsApproach() {
        return htsApproach;
    }

    public static HtsApproach get(String name) {
        switch (name) {
            case "PITC":
                return PITC;
            case "CICTC":
                return CICTC;

            default:
                throw new IllegalArgumentException("Unknown argument passes to method : " + name);
        }
    }
}
