package zw.gov.mohcc.mrs.ehr_mobile.enumeration;


public enum WhoStage {
    ONE("ONE"), TWO("TWO"), THREE("THREE"), FOUR("FOUR");

    private final String whoStage;

    WhoStage(String whoStage) {
        this.whoStage = whoStage;
    }

    public static WhoStage get(String name) {
        switch (name) {
            case "ONE":
                return ONE;
            case "TWO":
                return TWO;
            case "THREE":
                return THREE;
            case "FOUR":
                return FOUR;

            default:
                throw new IllegalArgumentException("Unknown argument passes to method : " + name);
        }
    }

    public String getWhoStage() {
        return whoStage;
    }
}
