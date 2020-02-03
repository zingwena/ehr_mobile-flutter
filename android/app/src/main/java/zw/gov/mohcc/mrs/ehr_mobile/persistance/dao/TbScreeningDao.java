package zw.gov.mohcc.mrs.ehr_mobile.persistance.dao;

import androidx.room.Dao;
import androidx.room.Insert;
import androidx.room.OnConflictStrategy;
import androidx.room.Query;
import androidx.room.Update;

import zw.gov.mohcc.mrs.ehr_mobile.model.tb.TbScreening;


@Dao
public interface TbScreeningDao {


    @Insert(onConflict = OnConflictStrategy.REPLACE)
    void save(TbScreening tbScreening);

    @Query("DELETE from TbScreening")
    void deleteAll();

    @Update
    void update(TbScreening tbScreening);

    @Query("SELECT * FROM TbScreening WHERE id=:id")
    TbScreening findById(String id);

    @Query("SELECT * FROM TbScreening WHERE visitId=:visitId")
    TbScreening findByVisitId(String visitId);

    @Query("DELETE FROM TbScreening where id = :id")
    void deleteById(String id);
}
