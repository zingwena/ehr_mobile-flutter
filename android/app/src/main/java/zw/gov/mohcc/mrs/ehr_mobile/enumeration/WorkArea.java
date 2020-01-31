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
        switch (name) {
            case "PNC":
                return PNC;
            case "IMNCI":
                return IMNCI;
            case "ART":
                return ART;
            case "TB":
                return TB;
            case "ANC":
                return ANC;
            case "PNC_MOTHER":
                return PNC_MOTHER;
            case "PNC_CHILD":
                return PNC_CHILD;
            case "ART_SIGN":
                return ART_SIGN;
            case "ART_SYMPTOM":
                return ART_SYMPTOM;
            case "ART_NEWOI":
                return ART_NEWOI;
            case "ESSENTIAL_BABY_CARE":
                return ESSENTIAL_BABY_CARE;
            case "MATERNAL":
                return MATERNAL;
            case "HISTORY":
                return HISTORY;
            case "MOTHER_PREGNANCY_DANGER_SIGNS":
                return MOTHER_PREGNANCY_DANGER_SIGNS;
            case "BABY_PREGNANCY_DANGER_SIGNS":
                return BABY_PREGNANCY_DANGER_SIGNS;
            case "HTS":
                return HTS;
            case "SEXUAL_HISTORY":
                return SEXUAL_HISTORY;
            default:
                throw new IllegalArgumentException("Unknown argument passes to method : " + name);
        }
    }

    public String getWorkArea() {
        return workArea;
    }
}
