package zw.gov.mohcc.mrs.ehr_mobile.persistance.dao;

import androidx.room.Dao;
import androidx.room.Insert;
import androidx.room.Query;

import java.util.List;

import zw.gov.mohcc.mrs.ehr_mobile.model.terminology.MedicineName;

@Dao
public interface MedicineNameDao {

    @Insert
    void saveAll(List<MedicineName> medicineNames);

    @Query("DELETE FROM MedicineName")
    void deleteALl();

    @Insert
    void saveOne(MedicineName medicineName);

    @Query("SELECT * FROM MedicineName Order By name ASC")
    List<MedicineName> findAll();

    @Query("SELECT * FROM MedicineName WHERE code=:id")
    MedicineName findById(String id);
}
