package zw.gov.mohcc.mrs.ehr_mobile.enumeration;

public enum ActivityStatus {

    DONE(0), NOT_DONE(1), UNKNOWN(2);

    private int activityStatus;

    private ActivityStatus(Integer activityStatus) {
        this.activityStatus = activityStatus;
    }

    public Integer getActivityStatus() {
        return activityStatus;
    }

    public static ActivityStatus get(String name) {
        switch (name) {
            case "DONE":
                return DONE;
            case "NOT_DONE":
                return NOT_DONE;
            case "UNKNOWN":
                return UNKNOWN;
            default:
                throw new IllegalArgumentException("Unknown argument passes to method : " + name);
        }
    }
}
