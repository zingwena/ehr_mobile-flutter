package zw.gov.mohcc.mrs.ehr_mobile.enumeration;


public enum MedicineLevel {

    A("A"), B("B"), C("C"), D("D"), S("S");

    private final String medicineLevel;

    MedicineLevel(String medicineLevel) {
        this.medicineLevel = medicineLevel;
    }

    public static MedicineLevel get(String name) {
        switch (name) {
            case "A":
                return A;
            case "B":
                return B;
            case "C":
                return C;
            case "D":
                return D;
            case "S":
                return S;
            default:
                throw new IllegalArgumentException("Unknown argument passes to method : " + name);
        }
    }

    public String getMedicineLevel() {
        return medicineLevel;
    }
}
