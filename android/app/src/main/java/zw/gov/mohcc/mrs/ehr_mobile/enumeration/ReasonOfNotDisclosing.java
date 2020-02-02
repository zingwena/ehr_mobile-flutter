package zw.gov.mohcc.mrs.ehr_mobile.enumeration;

public enum ReasonOfNotDisclosing {

    FEAR("FEAR"), NOT_READY("NOT_READY"), PHYSICAL_ABUSE("PHYSICAL_ABUSE");

    private String reasonOfNotDisclosing;

    ReasonOfNotDisclosing(String reasonOfNotDisclosing) {
        this.reasonOfNotDisclosing = reasonOfNotDisclosing;
    }

    public static ReasonOfNotDisclosing get(String name) {

        for (ReasonOfNotDisclosing item : values()) {
            if (item.getReasonOfNotDisclosing().equals(name)) {
                return item;
            }
        }
        throw new IllegalArgumentException("Unknown argument passes to method : " + name);
    }

    public String getReasonOfNotDisclosing() {
        return reasonOfNotDisclosing;
    }
}
