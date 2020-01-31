package zw.gov.mohcc.mrs.ehr_mobile.converter;

import androidx.room.TypeConverter;

import zw.gov.mohcc.mrs.ehr_mobile.enumeration.MedicineLevel;

public class MedicineLevelConverter {

    @TypeConverter
    public static MedicineLevel toMedicineLevel(int medicineLevel) {

        if (medicineLevel == MedicineLevel.A.getMedicineLevel()) {
            return MedicineLevel.A;
        } else if (medicineLevel == MedicineLevel.B.getMedicineLevel()) {
            return MedicineLevel.B;
        } else if (medicineLevel == MedicineLevel.C.getMedicineLevel()) {
            return MedicineLevel.C;
        } else if (medicineLevel == MedicineLevel.D.getMedicineLevel()) {
            return MedicineLevel.D;
        } else if (medicineLevel == MedicineLevel.S.getMedicineLevel()) {
            return MedicineLevel.S;
        }
        return null;
    }

    @TypeConverter
    public static Integer toInt(MedicineLevel medicineLevel) {
        if (medicineLevel == null) {
            return null;
        }
        return medicineLevel.getMedicineLevel();
    }
}
