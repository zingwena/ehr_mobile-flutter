package zw.gov.mohcc.mrs.ehr_mobile.model;

public enum SelfIdentifiedGender {
    MALE("Male"),
    FEMALE("Female"),
    UNKNOWN("Unknown"),
    NON_BINARY("Non_Binary");

    private String name;

    SelfIdentifiedGender(String name) {
        this.name = name;
    }

    public String getName() {
        return name;
    }
}