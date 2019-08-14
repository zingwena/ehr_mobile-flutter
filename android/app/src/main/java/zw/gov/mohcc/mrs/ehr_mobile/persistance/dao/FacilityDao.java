package zw.gov.mohcc.mrs.ehr_mobile.persistance.dao;

import androidx.room.Dao;
import androidx.room.Insert;
import androidx.room.Query;

import java.util.List;

import zw.gov.mohcc.mrs.ehr_mobile.model.Facility;
@Dao
public interface FacilityDao {
    @Insert
    void insertFacilities(List<Facility> facilities);

    @Insert
    void insertFacility(Facility facility);

    @Query("SELECT * FROM Facility")
    List<Facility> getAllFacilities();

    @Query("SELECT * FROM Facility WHERE facilityCode=:id")
    Facility findFacilityById(int id);
}
