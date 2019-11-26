package zw.gov.mohcc.mrs.ehr_mobile.persistance.dao;

import androidx.room.Dao;
import androidx.room.Insert;
import androidx.room.Query;

import java.util.List;

import zw.gov.mohcc.mrs.ehr_mobile.model.FacilityWard;
import zw.gov.mohcc.mrs.ehr_mobile.model.vitals.FacilityQueue;

@Dao
public interface FacilityWardDao {
    @Insert
    void saveAll(List<FacilityWard> facilityWards);

    @Insert
    void saveOne(FacilityWard facilityWard);

    @Query("SELECT * FROM FacilityWard")
    List<FacilityWard> findAll();

    @Query("DELETE FROM FacilityWard")
    void deleteAll();

    @Query("SELECT * FROM FacilityWard WHERE id=:id")
    FacilityWard findById(String id);
}
