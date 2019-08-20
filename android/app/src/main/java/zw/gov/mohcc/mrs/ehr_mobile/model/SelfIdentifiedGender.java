package zw.gov.mohcc.mrs.ehr_mobile.model;

public enum SelfIdentifiedGender {
    MALE(0),
    FEMALE(1),
    OTHER(2),
    NON_BINARY(3),
    NULL_VALS(-1);

    private int selfIdentifiedGender;

    SelfIdentifiedGender(int selfIdentifiedGender) {
        this.selfIdentifiedGender = selfIdentifiedGender;
    }

    public int getSelfIdentifiedGender() {
        return selfIdentifiedGender;
    }
}