package zw.gov.mohcc.mrs.ehr_mobile.enumeration;


public enum TypeOfContact {
    PRIMARY("PRIMARY"), SECONDARY("SECONDARY");

    private final String typeOfContact;

    TypeOfContact(String typeOfContact) {
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

    public String getTypeOfContact() {
        return typeOfContact;
    }
}
