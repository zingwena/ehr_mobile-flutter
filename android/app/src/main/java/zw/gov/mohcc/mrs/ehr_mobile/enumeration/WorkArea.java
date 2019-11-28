package zw.gov.mohcc.mrs.ehr_mobile.enumeration;

public enum WorkArea {

    PNC(0), IMNCI(1), ART(2), TB(3), ANC(4), PNC_MOTHER(5),
    PNC_CHILD(6), ART_SIGN(7), ART_SYMPTOM(8), ART_NEWOI(9), ESSENTIAL_BABY_CARE(10),
    MATERNAL(11), HISTORY(12), MOTHER_PREGNANCY_DANGER_SIGNS(13),
    BABY_PREGNANCY_DANGER_SIGNS(14), HTS(15), SEXUAL_HISTORY(16);

    private final int workArea;

    WorkArea(Integer workArea) {
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

    public Integer getWorkArea() {
        return workArea;
    }
}
