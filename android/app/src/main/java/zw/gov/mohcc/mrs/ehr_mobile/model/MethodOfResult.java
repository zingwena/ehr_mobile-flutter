package zw.gov.mohcc.mrs.ehr_mobile.model;

public enum  MethodOfResult {

    VERBAL("Verbal"),
    TEST_KIT_VALID("Test kit valid(within 72 hours)"),
    TEST_KIT_INVALID("Test kit invalid");


    private String name;

    MethodOfResult(String name){
        this.name = name;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }
}
