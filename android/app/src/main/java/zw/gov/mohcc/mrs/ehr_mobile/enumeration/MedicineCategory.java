package zw.gov.mohcc.mrs.ehr_mobile.enumeration;


public enum MedicineCategory {

    V("V"), E("E"), N("N");

    private final String medicineCategory;

    MedicineCategory(String medicineCategory) {
        this.medicineCategory = medicineCategory;
    }

    public static MedicineCategory get(String name) {

        for (MedicineCategory item : values()) {
            if (item.getMedicineCategory().equals(name)) {
                return item;
            }
        }
        throw new IllegalArgumentException("Unknown argument passes to method : " + name);
    }

    public String getMedicineCategory() {
        return medicineCategory;
    }
}
