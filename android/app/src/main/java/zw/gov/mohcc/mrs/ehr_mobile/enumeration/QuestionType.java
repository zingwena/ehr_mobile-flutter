package zw.gov.mohcc.mrs.ehr_mobile.enumeration;


public enum QuestionType {
    BOOLEAN("BOOLEAN"), TEXT("TEXT"), SET("SET"), NUMERIC("NUMERIC"),
    SKIN_PINCH("SKIN_PINCH"), VITAL("VITAL"), INVESTIGATION("INVESTIGATION");

    private final String questionTye;

    QuestionType(String questionTye) {
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

    public String getQuestionTye() {
        return questionTye;
    }
}
