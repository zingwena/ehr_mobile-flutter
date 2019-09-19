package zw.gov.mohcc.mrs.ehr_mobile.persistance.dao.vitalsDao;

import androidx.room.Dao;
import androidx.room.Insert;
import androidx.room.Query;

import java.util.List;

import zw.gov.mohcc.mrs.ehr_mobile.model.vitals.RespiratoryRate;

@Dao
public interface RespiratoryRateDao {
    @Insert
    void insert(RespiratoryRate respiratoryRate);

    @Query("SELECT * From RespiratoryRate")
    List<RespiratoryRate> getAll();

    @Query("Delete From RespiratoryRate")
    void deleteAll();
}
