package zw.gov.mohcc.mrs.ehr_mobile.persistance.dao;

import androidx.room.Dao;
import androidx.room.Insert;
import androidx.room.Query;

import java.util.List;

import zw.gov.mohcc.mrs.ehr_mobile.model.Occupation;


@Dao
public interface OccupationDao {

    @Insert
    void insertOccupations(List<Occupation> occupations);

    @Query("DELETE FROM occupation")
    void deleteOccupations();

    @Insert
    void insertOccupation(Occupation occupation);

    @Query("SELECT * FROM Occupation")
    List<Occupation> getAllOccupations();

    @Query("SELECT * FROM Occupation WHERE occupation_Id=:id")
    Occupation findOccupationsById(int id);

}
