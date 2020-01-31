package zw.gov.mohcc.mrs.ehr_mobile.enumeration;

public enum PrepOption {

    INFANT("INFANT"), PRE_EXPOSURE("PRE_EXPOSURE"), POST_EXPOSURE("POST_EXPOSURE"), NONE("NONE");

    private String prepOption;

    private PrepOption(String prepOption) {
        this.prepOption = prepOption;
    }

    public String getPrepOption() {
        return prepOption;
    }

    public static PrepOption get(String name) {
        switch (name) {
            case "INFANT":
                return INFANT;
            case "PRE_EXPOSURE":
                return PRE_EXPOSURE;
            case "POST_EXPOSURE":
                return POST_EXPOSURE;
            case "NONE":
                return NONE;
            default:
                throw new IllegalArgumentException("Unknown argument passes to method : " + name);
        }
    }
}
