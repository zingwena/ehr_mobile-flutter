package zw.gov.mohcc.mrs.ehr_mobile.persistance.dao;

import androidx.room.Dao;
import androidx.room.Insert;
import androidx.room.Query;

import java.util.List;

import zw.gov.mohcc.mrs.ehr_mobile.model.terminology.FunctionalStatus;


@Dao
public interface FunctionalStatusDao {

    @Insert
    void saveAll(List<FunctionalStatus> functionalStatuses);

    @Query("DELETE FROM FunctionalStatus")
    void deleteAll();

    @Insert
    void saveOne(FunctionalStatus functionalStatus);

    @Query("SELECT * FROM FunctionalStatus ORDER BY name ASC")
    List<FunctionalStatus> findAll();

    @Query("SELECT * FROM FunctionalStatus WHERE code=:code")
    FunctionalStatus findById(String code);

}
