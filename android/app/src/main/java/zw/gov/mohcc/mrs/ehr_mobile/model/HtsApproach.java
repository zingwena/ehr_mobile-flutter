package zw.gov.mohcc.mrs.ehr_mobile.model;


public enum HtsApproach {
    PITC(0),
    CICTC(1);

    private final int htsApproach;

    private HtsApproach(int htsApproach) {
        this.htsApproach = htsApproach;
    }

    public int getHtsApproach() {
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
