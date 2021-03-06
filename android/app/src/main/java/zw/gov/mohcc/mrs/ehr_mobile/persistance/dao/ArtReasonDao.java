package zw.gov.mohcc.mrs.ehr_mobile.persistance.dao;

import androidx.room.Dao;
import androidx.room.Insert;
import androidx.room.Query;

import java.util.List;

import zw.gov.mohcc.mrs.ehr_mobile.model.terminology.ArtReason;


@Dao
public interface ArtReasonDao {

    @Insert
    void saveAll(List<ArtReason> artReasons);

    @Insert
    void saveOne(ArtReason artReason);

    @Query("DELETE FROM ArtReason")
    void deleteAll();

    @Query("SELECT * FROM ArtReason a Order By a.name ASC")
    List<ArtReason> findAll();

    @Query("SELECT * FROM ArtReason WHERE code=:id")
    ArtReason findById(String id);

    @Query("SELECT * FROM ArtReason WHERE name=:name")
    ArtReason findByName(String name);

}
