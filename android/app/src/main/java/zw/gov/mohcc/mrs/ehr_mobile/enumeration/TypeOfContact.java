package zw.gov.mohcc.mrs.ehr_mobile.enumeration;


public enum TypeOfContact {
    PRIMARY("PRIMARY"), SECONDARY("SECONDARY");

    private final String typeOfContact;

    TypeOfContact(String typeOfContact) {
        this.typeOfContact = typeOfContact;
    }

    public static TypeOfContact get(String name) {

        for (TypeOfContact item : values()) {
            if (item.getTypeOfContact().equals(name)) {
                return item;
            }
        }
        throw new IllegalArgumentException("Unknown argument passes to method : " + name);
    }

    public String getTypeOfContact() {
        return typeOfContact;
    }
}
