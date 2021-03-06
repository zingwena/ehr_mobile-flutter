package zw.gov.mohcc.mrs.ehr_mobile.persistance.dao;

import androidx.room.Dao;
import androidx.room.Insert;
import androidx.room.Query;

import java.util.List;

import zw.gov.mohcc.mrs.ehr_mobile.model.FacilityQueue;

@Dao
public interface FacilityQueueDao {
    @Insert
    void saveAll(List<FacilityQueue> facilityQueues);

    @Insert
    void saveOne(FacilityQueue facilityQueue);

    @Query("SELECT * FROM FacilityQueue Order by queue_name ASC")
    List<FacilityQueue> findAll();

    @Query("DELETE FROM FacilityQueue")
    void deleteAll();

    @Query("SELECT * FROM FacilityQueue WHERE id=:id")
    FacilityQueue findById(String id);
}
