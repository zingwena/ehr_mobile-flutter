package zw.gov.mohcc.mrs.ehr_mobile.persistance.dao;

import androidx.room.Dao;
import androidx.room.Insert;
import androidx.room.Query;

import java.util.List;

import zw.gov.mohcc.mrs.ehr_mobile.model.terminology.Facility;
@Dao
public interface FacilityDao {
    @Insert
    void saveAll(List<Facility> facilities);

    @Insert
    void saveOne(Facility facility);

    @Query("SELECT * FROM Facility Order By name ASC")
    List<Facility> findAll();

    @Query("DELETE FROM facility")
    void deleteAll();

    @Query("SELECT * FROM Facility WHERE code=:code")
    Facility findById(String code);
}
