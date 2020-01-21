package zw.gov.mohcc.mrs.ehr_mobile.enumeration;

public enum RecordStatus {

    NEW(0),
    IMPORTED(1),
    SYNCED(2),
    DELETED(3),
    CHANGED(4);

    private final int status;

    private RecordStatus(int status) {
        this.status = status;
    }

    public int getStatus() {
        return this.status;
    }

    public static RecordStatus get(String name) {
        byte var2 = -1;
        switch(name.hashCode()) {
            case -2026521607:
                if (name.equals("DELETED")) {
                    var2 = 2;
                }
                break;
            case -1834164102:
                if (name.equals("SYNCED")) {
                    var2 = 1;
                }
                break;
            case 360258308:
                if (name.equals("IMPORTED")) {
                    var2 = 0;
                }
                break;
            case 1456926356:
                if (name.equals("CHANGED")) {
                    var2 = 3;
                }
        }

        switch(var2) {
            case 0:
                return IMPORTED;
            case 1:
                return SYNCED;
            case 2:
                return DELETED;
            case 3:
                return CHANGED;
            default:
                return NEW;
        }
    }
}
