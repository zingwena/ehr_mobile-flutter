package zw.gov.mohcc.mrs.ehr_mobile.enumeration;

public enum ActivityStatus {

    DONE("DONE"), NOT_DONE("NOT_DONE"), UNKNOWN("UNKNOWN");

    private String activityStatus;

    ActivityStatus(String activityStatus) {
        this.activityStatus = activityStatus;
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

    public String getActivityStatus() {
        return activityStatus;
    }
}
