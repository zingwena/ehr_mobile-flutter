package zw.gov.mohcc.mrs.ehr_mobile.enumeration;


public enum MedicineLevel {

    A(0), B(1), C(2), D(3), S(4);

    private final int medicineLevel;

    MedicineLevel(int medicineLevel) {
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

    public int getMedicineLevel() {
        return medicineLevel;
    }
}
