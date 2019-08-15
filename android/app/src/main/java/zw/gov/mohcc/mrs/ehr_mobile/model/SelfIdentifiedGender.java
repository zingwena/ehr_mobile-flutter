package zw.gov.mohcc.mrs.ehr_mobile.model;

public enum SelfIdentifiedGender {
    MALE("MALE"),
    FEMALE("FEMALE"),
    OTHER("OTHER"),
    NON_BINARY("NON_BINARY");

    private String name;

    SelfIdentifiedGender(String name) {
        this.name = name;
    }

    public String getName() {
        return name;
    }
}