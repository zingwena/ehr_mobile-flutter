package zw.gov.mohcc.mrs.ehr_mobile.enumeration;


public enum ClientEligibility {
    ELIGIBLE(0),
    NOT_ELIGIBLE(1);

    private final int clientEligibility;

    private ClientEligibility(int clientEligibility) {
        this.clientEligibility = clientEligibility;
    }

    public int getClientEligibility() {
        return clientEligibility;
    }

    public static ClientEligibility get(String name) {
        switch (name) {
            case "ELIGIBLE":
                return ELIGIBLE;
            case "NOT ELIGIBLE":
                return NOT_ELIGIBLE;

            default:
                throw new IllegalArgumentException("Unknown argument passes to method : " + name);
        }
    }
}
