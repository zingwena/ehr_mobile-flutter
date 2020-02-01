package zw.gov.mohcc.mrs.ehr_mobile.enumeration;


public enum QuestionType {
    BOOLEAN("BOOLEAN"), TEXT("TEXT"), SET("SET"), NUMERIC("NUMERIC"),
    SKIN_PINCH("SKIN_PINCH"), VITAL("VITAL"), INVESTIGATION("INVESTIGATION");

    private final String questionTye;

    QuestionType(String questionTye) {
        this.questionTye = questionTye;
    }

    public static QuestionType get(String name) {

        for (QuestionType item : values()) {
            if (item.getQuestionTye().equals(name)) {
                return item;
            }
        }
        throw new IllegalArgumentException("Unknown argument passes to method : " + name);
    }

    public String getQuestionTye() {
        return questionTye;
    }
}
