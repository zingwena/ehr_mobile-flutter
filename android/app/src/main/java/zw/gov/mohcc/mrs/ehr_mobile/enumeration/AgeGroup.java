package zw.gov.mohcc.mrs.ehr_mobile.enumeration;

public enum AgeGroup {

    ADULT("ADULT"), PEADS("PEADS");

    private final String ageGroup;

    AgeGroup(String ageGroup) {
        this.ageGroup = ageGroup;
    }

    public static AgeGroup get(String name) {
        switch (name) {
            case "ADULT":
                return ADULT;
            case "PEADS":
                return PEADS;
            default:
                throw new IllegalArgumentException("Unknown argument passes to method : " + name);
        }
    }

    public static AgeGroup getPersonAgeGroup(int age) {
        if (age <= 15) {
            return PEADS;
        }
        return ADULT;
    }

    public String getAgeGroup() {
        return ageGroup;
    }
}
