package zw.gov.mohcc.mrs.ehr_mobile.model;

public enum Result {
    NEGATIVE(0),
    POSITIVE(1),
    INCONCLUSIVE(2);

    private final int resultId;

    private Result (int resultId) {
        this.resultId = resultId;
    }

    public int getResultId() {
        return resultId;
    }

    public static Result get(String name) {
        switch (name) {
            case "POSITIVE":
                return POSITIVE;
            case "NEGATIVE":
                return NEGATIVE;
            case "INCONCLUSIVE":
                return INCONCLUSIVE;
            default:
                throw new IllegalArgumentException("Unknown argument passes to method : " + name);
        }
    }
}
