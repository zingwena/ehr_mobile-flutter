package zw.gov.mohcc.mrs.ehr_mobile.enumeration;


public enum MedicineCategory {

    V(0), E(1), N(2);

    private final int medicineCategory;

    MedicineCategory(int medicineCategory) {
        this.medicineCategory = medicineCategory;
    }

    public static MedicineCategory get(String name) {
        switch (name) {
            case "V":
                return V;
            case "E":
                return E;
            case "N":
                return N;
            default:
                throw new IllegalArgumentException("Unknown argument passes to method : " + name);
        }
    }

    public int getMedicineCategory() {
        return medicineCategory;
    }
}
