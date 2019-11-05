package zw.gov.mohcc.mrs.ehr_mobile.model;

public enum PrepOption {

    INFANT(0), PRE_EXPOSURE(1), POST_EXPOSURE(2), NONE(3);

    private Integer prepOption;

    private PrepOption(Integer prepOption) {
        this.prepOption = prepOption;
    }

    public Integer getPrepOption() {
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
