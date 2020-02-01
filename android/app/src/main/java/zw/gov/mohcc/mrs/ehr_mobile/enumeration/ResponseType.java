package zw.gov.mohcc.mrs.ehr_mobile.enumeration;

public enum ResponseType {

    YES("YES"), NO("NO"), REFUSED("REFUSED");

    private final String responseType;

    ResponseType(String responseType) {
        this.responseType = responseType;
    }

    public static ResponseType get(String name) {

        for (ResponseType item : values()) {
            if (item.getResponseType().equals(name)) {
                return item;
            }
        }
        throw new IllegalArgumentException("Unknown argument passes to method : " + name);
    }

    public String getResponseType() {
        return responseType;
    }
}
