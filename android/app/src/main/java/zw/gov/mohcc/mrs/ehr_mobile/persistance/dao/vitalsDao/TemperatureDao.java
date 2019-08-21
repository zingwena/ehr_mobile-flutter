package zw.gov.mohcc.mrs.ehr_mobile.persistance.dao.vitalsDao;

import androidx.room.Dao;
import androidx.room.Insert;
import androidx.room.Query;

import java.util.List;

import zw.gov.mohcc.mrs.ehr_mobile.vitals.Temperature;

@Dao
public interface TemperatureDao {

    @Insert
    void insert(Temperature temperature);

    @Query("SELECT * From Temperature")
    List<Temperature> getAll();
}