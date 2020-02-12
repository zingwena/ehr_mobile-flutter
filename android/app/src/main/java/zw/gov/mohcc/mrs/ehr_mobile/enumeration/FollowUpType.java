package zw.gov.mohcc.mrs.ehr_mobile.enumeration;

public enum FollowUpType {

    VISIT("VISIT"), CALL("CALL");

    private final String followUpType;

    FollowUpType(String followUpType) {
        this.followUpType = followUpType;
    }

    public static FollowUpType get(String name) {

        for (FollowUpType item : values()) {
            if (item.getFollowUpType().equals(name)) {
                return item;
            }
        }
        throw new IllegalArgumentException("Unknown argument passes to method : " + name);
    }

    public String getFollowUpType() {
        return followUpType;
    }
}
