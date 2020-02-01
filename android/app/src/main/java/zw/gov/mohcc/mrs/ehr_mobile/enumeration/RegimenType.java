package zw.gov.mohcc.mrs.ehr_mobile.enumeration;

public enum RegimenType {

    FIRST_LINE("FIRST_LINE"), SECOND_LINE("SECOND_LINE"), THIRD_LINE("THIRD_LINE");

    private final String regimenType;

    RegimenType(String regimenType) {
        this.regimenType = regimenType;
    }

    public static RegimenType get(String name) {

        for (RegimenType item : values()) {
            if (item.getRegimenType().equals(name)) {
                return item;
            }
        }
        throw new IllegalArgumentException("Unknown argument passes to method : " + name);
    }

    public String getRegimenType() {
        return regimenType;
    }
}
