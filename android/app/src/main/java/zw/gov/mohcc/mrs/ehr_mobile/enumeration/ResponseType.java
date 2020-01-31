package zw.gov.mohcc.mrs.ehr_mobile.enumeration;

public enum ResponseType {

    YES("YES"), NO("NO"), REFUSED("REFUSED");

    private final String responseType;

    ResponseType(String responseType) {
        this.responseType = responseType;
    }

    public static ResponseType get(String name) {

        switch (name) {
            case "YES":
                return YES;
            case "NO":
                return NO;
            case "REFUSED":
                return REFUSED;
            default:
                throw new IllegalArgumentException("Unknown argument passes to method : " + name);
        }
    }

    public String getResponseType() {
        return responseType;
    }
}
