package zw.gov.mohcc.mrs.ehr_mobile.enumeration;

public enum AgeGroup {

    ADULT(0), PEADS(1);

    private final int ageGroup;

    AgeGroup(Integer ageGroup) {
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

    public Integer getAgeGroup() {
        return ageGroup;
    }
}
