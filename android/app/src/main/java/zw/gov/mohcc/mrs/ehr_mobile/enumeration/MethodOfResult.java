package zw.gov.mohcc.mrs.ehr_mobile.enumeration;

public enum MethodOfResult {

    VERBAL("Verbal"),
    TEST_KIT_VALID("Test kit valid(within 72 hours)"),
    TEST_KIT_INVALID("Test kit invalid");


    private final String name;

    private MethodOfResult(String name) {
        this.name = name;
    }

    public String getName() {
        return name;
    }
}
