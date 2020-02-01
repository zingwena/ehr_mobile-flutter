package zw.gov.mohcc.mrs.ehr_mobile.enumeration;

public enum ActivityStatus {

    DONE("DONE"), NOT_DONE("NOT_DONE"), UNKNOWN("UNKNOWN");

    private String activityStatus;

    ActivityStatus(String activityStatus) {
        this.activityStatus = activityStatus;
    }

    public static ActivityStatus get(String name) {

        for (ActivityStatus item : values()) {
            if (item.getActivityStatus().equals(name)) {
                return item;
            }
        }
        throw new IllegalArgumentException("Unknown argument passes to method : " + name);
    }

    public String getActivityStatus() {
        return activityStatus;
    }
}
