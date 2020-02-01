package zw.gov.mohcc.mrs.ehr_mobile.enumeration;


public enum MedicineLevel {

    A("A"), B("B"), C("C"), D("D"), S("S");

    private final String medicineLevel;

    MedicineLevel(String medicineLevel) {
        this.medicineLevel = medicineLevel;
    }

    public static MedicineLevel get(String name) {

        for (MedicineLevel item : values()) {
            if (item.getMedicineLevel().equals(name)) {
                return item;
            }
        }
        throw new IllegalArgumentException("Unknown argument passes to method : " + name);
    }

    public String getMedicineLevel() {
        return medicineLevel;
    }
}
