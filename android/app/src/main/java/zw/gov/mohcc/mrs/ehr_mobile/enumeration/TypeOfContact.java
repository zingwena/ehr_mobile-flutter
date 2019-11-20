package zw.gov.mohcc.mrs.ehr_mobile.enumeration;


public enum TypeOfContact {
    PRIMARY(0), SECONDARY(1);

    private final int typeOfContact;

    TypeOfContact(int typeOfContact) {
        this.typeOfContact = typeOfContact;
    }

    public static TypeOfContact get(String name) {
        switch (name) {
            case "PRIMARY":
                return PRIMARY;
            case "SECONDARY":
                return SECONDARY;

            default:
                throw new IllegalArgumentException("Unknown argument passes to method : " + name);
        }
    }

    public int getTypeOfContact() {
        return typeOfContact;
    }
}
