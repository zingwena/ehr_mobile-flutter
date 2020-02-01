package zw.gov.mohcc.mrs.ehr_mobile.enumeration;


public enum HtsApproach {
    PITC("PITC"),
    CICTC("CICTC");

    private final String htsApproach;

    HtsApproach(String htsApproach) {
        this.htsApproach = htsApproach;
    }

    public static HtsApproach get(String name) {

        for (HtsApproach item : values()) {
            if (item.getHtsApproach().equals(name)) {
                return item;
            }
        }
        throw new IllegalArgumentException("Unknown argument passes to method : " + name);
    }

    public String getHtsApproach() {
        return htsApproach;
    }
}
