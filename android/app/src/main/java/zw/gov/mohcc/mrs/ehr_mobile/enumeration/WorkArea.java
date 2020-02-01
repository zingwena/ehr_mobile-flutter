package zw.gov.mohcc.mrs.ehr_mobile.enumeration;

public enum WorkArea {

    PNC("PNC"), IMNCI("IMNCI"), ART("ART"), TB("TB"), ANC("ANC"), PNC_MOTHER("PNC_MOTHER"),
    PNC_CHILD("PNC_CHILD"), ART_SIGN("ART_SIGN"), ART_SYMPTOM("ART_SYMPTOM"), ART_NEWOI("ART_NEWOI"),
    ESSENTIAL_BABY_CARE("ESSENTIAL_BABY_CARE"),
    MATERNAL("MATERNAL"), HISTORY("HISTORY"), MOTHER_PREGNANCY_DANGER_SIGNS("MOTHER_PREGNANCY_DANGER_SIGNS"),
    BABY_PREGNANCY_DANGER_SIGNS("BABY_PREGNANCY_DANGER_SIGNS"), HTS("HTS"), SEXUAL_HISTORY("SEXUAL_HISTORY");

    private final String workArea;

    WorkArea(String workArea) {
        this.workArea = workArea;
    }

    public static WorkArea get(String name) {

        for (WorkArea item : values()) {
            if (item.getWorkArea().equals(name)) {
                return item;
            }
        }
        throw new IllegalArgumentException("Unknown argument passes to method : " + name);
    }

    public String getWorkArea() {
        return workArea;
    }
}
