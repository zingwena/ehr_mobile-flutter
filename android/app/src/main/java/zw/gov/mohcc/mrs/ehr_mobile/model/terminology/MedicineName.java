package zw.gov.mohcc.mrs.ehr_mobile.model.terminology;

import androidx.annotation.NonNull;
import androidx.room.Entity;
import androidx.room.Ignore;
import androidx.room.TypeConverters;

import zw.gov.mohcc.mrs.ehr_mobile.converter.MedicineCategoryConverter;
import zw.gov.mohcc.mrs.ehr_mobile.converter.MedicineLevelConverter;
import zw.gov.mohcc.mrs.ehr_mobile.enumeration.MedicineCategory;
import zw.gov.mohcc.mrs.ehr_mobile.enumeration.MedicineLevel;
import zw.gov.mohcc.mrs.ehr_mobile.model.BaseNameModel;

@Entity
public class MedicineName extends BaseNameModel {

    @TypeConverters(MedicineCategoryConverter.class)
    private MedicineCategory medicineCategory;
    @TypeConverters(MedicineLevelConverter.class)
    private MedicineLevel medicineLevel;
    private boolean otc;

    public MedicineName() {
    }

    @Ignore
    public MedicineName(@NonNull String code, @NonNull String name, MedicineCategory medicineCategory, MedicineLevel medicineLevel, boolean otc) {
        super(code, name);
        this.medicineCategory = medicineCategory;
        this.medicineLevel = medicineLevel;
        this.otc = otc;
    }

    public MedicineCategory getMedicineCategory() {
        return medicineCategory;
    }

    public void setMedicineCategory(MedicineCategory medicineCategory) {
        this.medicineCategory = medicineCategory;
    }

    public MedicineLevel getMedicineLevel() {
        return medicineLevel;
    }

    public void setMedicineLevel(MedicineLevel medicineLevel) {
        this.medicineLevel = medicineLevel;
    }

    public boolean isOtc() {
        return otc;
    }

    public void setOtc(boolean otc) {
        this.otc = otc;
    }
}
