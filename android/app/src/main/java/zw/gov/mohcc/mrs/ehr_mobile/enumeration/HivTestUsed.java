package zw.gov.mohcc.mrs.ehr_mobile.enumeration;


public enum HivTestUsed {

    AB("AB", "Antibodies"),
    PCR("PCR", "Polymerase Chain Reaction");

    private final String hivTestUsed;
    private final String name;

    HivTestUsed(String hivTestUsed, String name) {
        this.hivTestUsed = hivTestUsed;
        this.name = name;
    }

    public static HivTestUsed get(String name) {

        for (HivTestUsed item : values()) {
            if (item.getHivTestUsed().equals(name)) {
                return item;
            }
        }
        throw new IllegalArgumentException("Unknown argument passes to method : " + name);
    }

    public String getHivTestUsed() {
        return hivTestUsed;
    }

    private String getName() {
        return name;
    }
}
