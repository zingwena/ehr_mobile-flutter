package zw.gov.mohcc.mrs.ehr_mobile.converter;

import androidx.room.TypeConverter;

import zw.gov.mohcc.mrs.ehr_mobile.enumeration.MedicineLevel;

public class MedicineLevelConverter {

    @TypeConverter
    public static MedicineLevel toMedicineLevel(String medicineLevel) {

        if (medicineLevel.equals(MedicineLevel.A.getMedicineLevel())) {
            return MedicineLevel.A;
        } else if (medicineLevel.equals(MedicineLevel.B.getMedicineLevel())) {
            return MedicineLevel.B;
        } else if (medicineLevel.equals(MedicineLevel.C.getMedicineLevel())) {
            return MedicineLevel.C;
        } else if (medicineLevel.equals(MedicineLevel.D.getMedicineLevel())) {
            return MedicineLevel.D;
        } else if (medicineLevel.equals(MedicineLevel.S.getMedicineLevel())) {
            return MedicineLevel.S;
        }
        return null;
    }

    @TypeConverter
    public static String toString(MedicineLevel medicineLevel) {
        if (medicineLevel == null) {
            return null;
        }
        return medicineLevel.getMedicineLevel();
    }
}
