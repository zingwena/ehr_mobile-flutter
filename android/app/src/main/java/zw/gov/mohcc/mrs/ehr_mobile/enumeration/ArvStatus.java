package zw.gov.mohcc.mrs.ehr_mobile.enumeration;


public enum ArvStatus {
    NO_ARV("NO_ARV"), START_ARV("START_ARV"), CONTINUE("CONTINUE"),
    CHANGE("CHANGE"), STOP("STOP"), RESTART("RESTART"), PMTCT_PROPHLAXIS("PMTCT_PROPHLAXIS");

    private final String arvStatus;

    ArvStatus(String arvStatus) {
        this.arvStatus = arvStatus;
    }

    public static ArvStatus get(String arvStatus) {
        for (ArvStatus type : values()) {
            if (type.getArvStatus().equals(arvStatus)) {
                return type;
            }
        }
        throw new IllegalArgumentException("Unknown argument passes to method : " + arvStatus);
    }

    public String getArvStatus() {
        return arvStatus;
    }
}
