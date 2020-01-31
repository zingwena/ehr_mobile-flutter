package zw.gov.mohcc.mrs.ehr_mobile.converter;

import androidx.room.TypeConverter;

import zw.gov.mohcc.mrs.ehr_mobile.enumeration.MedicineCategory;

public class MedicineCategoryConverter {

    @TypeConverter
    public static MedicineCategory toMedicineCategory(int medicineCategory) {

        if (medicineCategory == MedicineCategory.V.getMedicineCategory()) {
            return MedicineCategory.V;
        } else if (medicineCategory == MedicineCategory.E.getMedicineCategory()) {
            return MedicineCategory.E;
        } else if (medicineCategory == MedicineCategory.N.getMedicineCategory()) {
            return MedicineCategory.N;
        }
        return null;
    }

    @TypeConverter
    public static Integer toInt(MedicineCategory medicineCategory) {
        if (medicineCategory == null) {
            return null;
        }
        return medicineCategory.getMedicineCategory();
    }
}
