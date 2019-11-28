package zw.gov.mohcc.mrs.ehr_mobile.enumeration;

public enum ResponseType {

    YES(0), NO(1), REFUSED(2);

    private final int responseType;

    ResponseType(int responseType) {
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

    public int getResponseType() {
        return responseType;
    }
}
