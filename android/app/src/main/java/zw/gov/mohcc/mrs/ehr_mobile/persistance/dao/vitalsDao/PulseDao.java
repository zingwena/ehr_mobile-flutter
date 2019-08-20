package zw.gov.mohcc.mrs.ehr_mobile.persistance.dao.vitalsDao;

import androidx.room.Dao;
import androidx.room.Insert;
import androidx.room.Query;

import java.util.List;

import zw.gov.mohcc.mrs.ehr_mobile.vitals.Pulse;

@Dao
public interface PulseDao {
    @Insert
    void insert(Pulse pulse);

    @Query("SELECT * From Pulse")
    List<Pulse> getAll();
}
