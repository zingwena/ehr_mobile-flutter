package zw.gov.mohcc.mrs.ehr_mobile.enumeration;

public enum PrepOption {

    INFANT("INFANT"), PRE_EXPOSURE("PRE_EXPOSURE"), POST_EXPOSURE("POST_EXPOSURE"), NONE("NONE");

    private String prepOption;

    PrepOption(String prepOption) {
        this.prepOption = prepOption;
    }

    public static PrepOption get(String name) {

        for (PrepOption item : values()) {
            if (item.getPrepOption().equals(name)) {
                return item;
            }
        }
        throw new IllegalArgumentException("Unknown argument passes to method : " + name);
    }

    public String getPrepOption() {
        return prepOption;
    }
}
