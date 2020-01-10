package zw.gov.mohcc.mrs.ehr_mobile.persistance.dao;

import androidx.room.Dao;
import androidx.room.Insert;
import androidx.room.Query;

import java.util.List;

import zw.gov.mohcc.mrs.ehr_mobile.model.terminology.Occupation;


@Dao
public interface OccupationDao {

    @Insert
    void saveAll(List<Occupation> occupations);

    @Query("DELETE FROM occupation")
    void deleteAll();

    @Insert
    void saveOne(Occupation occupation);

    @Query("SELECT * FROM occupation ORDER BY name ASC")
    List<Occupation> findAll();

    @Query("SELECT name FROM Occupation WHERE code=:id")
    Occupation findById(String id);

}
