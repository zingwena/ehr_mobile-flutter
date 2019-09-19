package zw.gov.mohcc.mrs.ehr_mobile.persistance.dao.vitalsDao;

import androidx.room.Dao;
import androidx.room.Insert;
import androidx.room.Query;

import java.util.List;

import zw.gov.mohcc.mrs.ehr_mobile.model.Hts;
import zw.gov.mohcc.mrs.ehr_mobile.model.vitals.BloodPressure;

@Dao
public interface BloodPressureDao {
    @Insert
    void insert(BloodPressure bloodPressure);

    @Query("SELECT * From BloodPressure")
    List<BloodPressure> getAll();

    @Query("SELECT * FROM BloodPressure WHERE visitId =:visitId")
    BloodPressure findByVisitId(String visitId);
}
