package zw.gov.mohcc.mrs.ehr_mobile.persistance.dao;

import androidx.room.Dao;
import androidx.room.Insert;
import androidx.room.Query;

import java.util.List;

import zw.gov.mohcc.mrs.ehr_mobile.model.terminology.LactatingStatus;


@Dao
public interface LactatingStatusDao {

    @Insert
    void saveAll(List<LactatingStatus> lactatingStatuses);

    @Query("DELETE FROM LactatingStatus")
    void deleteAll();

    @Insert
    void saveOne(LactatingStatus lactatingStatus);

    @Query("SELECT * FROM LactatingStatus ORDER BY name ASC")
    List<LactatingStatus> findAll();

    @Query("SELECT * FROM LactatingStatus WHERE code=:code")
    LactatingStatus findById(String code);

}
