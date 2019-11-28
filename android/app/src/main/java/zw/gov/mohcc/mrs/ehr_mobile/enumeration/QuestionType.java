package zw.gov.mohcc.mrs.ehr_mobile.enumeration;


public enum QuestionType {
    BOOLEAN(0), TEXT(1), SET(2), NUMERIC(3), SKIN_PINCH(4), VITAL(5), INVESTIGATION(6);

    private final int questionTye;

    QuestionType(Integer questionTye) {
        this.questionTye = questionTye;
    }

    public static QuestionType get(String name) {
        switch (name) {
            case "BOOLEAN":
                return BOOLEAN;
            case "TEXT":
                return TEXT;
            case "SET":
                return SET;
            case "NUMERIC":
                return NUMERIC;
            case "SKIN_PINCH":
                return SKIN_PINCH;
            case "VITAL":
                return VITAL;
            case "INVESTIGATION":
                return INVESTIGATION;
            default:
                throw new IllegalArgumentException("Unknown argument passes to method : " + name);
        }
    }

    public int getQuestionTye() {
        return questionTye;
    }
}
