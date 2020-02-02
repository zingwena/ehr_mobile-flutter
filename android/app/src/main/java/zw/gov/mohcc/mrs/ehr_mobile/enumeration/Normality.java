package zw.gov.mohcc.mrs.ehr_mobile.enumeration;

public enum Normality {

    NONE("NONE"), NORMAL("NORMAL"), ABNORMAL("ABNORMAL");

    private String normality;

    Normality(String normality) {
        this.normality = normality;
    }

    public static Normality get(String name) {

        for (Normality item : values()) {
            if (item.getNormality().equals(name)) {
                return item;
            }
        }
        throw new IllegalArgumentException("Unknown argument passes to method : " + name);
    }

    public String getNormality() {
        return normality;
    }
}
