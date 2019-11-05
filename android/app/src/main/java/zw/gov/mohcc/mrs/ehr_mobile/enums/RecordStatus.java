package zw.gov.mohcc.mrs.ehr_mobile.enums;


public enum RecordStatus {

    NEW(0),
    IMPORTED(1),
    UPDATED(2),
    DELETED(3),
    CHANGED(4);


    private final int status;

    RecordStatus (int status) {
        this.status = status;
    }

    public int getStatus() {
        return status;
    }

    public static RecordStatus get(String name) {
        switch (name) {
            case "NEW":
                return NEW;
            case "IMPORTED":
                return IMPORTED;
            case "UPDATED":
                return UPDATED;
            case "DELETED":
                return DELETED;
            case "CHANGED":
                return CHANGED;
            default:
                return IMPORTED;
                //throw new IllegalArgumentException("Unknown argument passes to method : " + name);
        }
    }
}
