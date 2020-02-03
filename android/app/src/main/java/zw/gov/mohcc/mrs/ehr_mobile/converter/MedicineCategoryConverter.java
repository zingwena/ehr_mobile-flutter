package zw.gov.mohcc.mrs.ehr_mobile.converter;

import androidx.room.TypeConverter;

import zw.gov.mohcc.mrs.ehr_mobile.enumeration.MedicineCategory;

public class MedicineCategoryConverter {

    @TypeConverter
    public static MedicineCategory toMedicineCategory(String medicineCategory) {

        if (medicineCategory == null) {
            return null;
        }
        if (medicineCategory.equals(MedicineCategory.V.getMedicineCategory())) {
            return MedicineCategory.V;
        } else if (medicineCategory.equals(MedicineCategory.E.getMedicineCategory())) {
            return MedicineCategory.E;
        } else if (medicineCategory.equals(MedicineCategory.N.getMedicineCategory())) {
            return MedicineCategory.N;
        }
        return null;
    }

    @TypeConverter
    public static String toString(MedicineCategory medicineCategory) {
        if (medicineCategory == null) {
            return null;
        }
        return medicineCategory.getMedicineCategory();
    }
}
