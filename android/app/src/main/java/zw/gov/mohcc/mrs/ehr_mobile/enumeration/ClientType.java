package zw.gov.mohcc.mrs.ehr_mobile.enumeration;


public enum ClientType {
    NEW_CLIENT(0),
    OLD_CLIENT(1);

    private final int clientType;

    private ClientType(int clientType) {
        this.clientType = clientType;
    }

    public int getClientType() {
        return clientType;
    }

    public static ClientType get(String name) {
        switch (name) {
            case "NEW CLIENT":
                return NEW_CLIENT;
            case "OLD CLIENT":
                return OLD_CLIENT;

            default:
                throw new IllegalArgumentException("Unknown argument passes to method : " + name);
        }
    }
}
