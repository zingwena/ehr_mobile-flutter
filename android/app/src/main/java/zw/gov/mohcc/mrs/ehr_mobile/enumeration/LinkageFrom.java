package zw.gov.mohcc.mrs.ehr_mobile.enumeration;


public enum LinkageFrom {

    EID("EID"), HTS("HTS"), PMTCT("PMTCT"), STI("STI"),
    TB_PROGRAM("TB_PROGRAM"), VMMC("VMMC"), VIAC("VIAC");

    private final String linkageFrom;

    LinkageFrom(String linkageFrom) {
        this.linkageFrom = linkageFrom;
    }

    public static LinkageFrom get(String name) {

        for (LinkageFrom item : values()) {
            if (item.getLinkageFrom().equals(name)) {
                return item;
            }
        }
        throw new IllegalArgumentException("Unknown argument passes to method : " + name);
    }

    public String getLinkageFrom() {
        return linkageFrom;
    }
}
