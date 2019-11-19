package zw.gov.mohcc.mrs.ehr_mobile.persistance.dao;

import androidx.room.Dao;
import androidx.room.Insert;
import androidx.room.Query;

import java.util.List;

import zw.gov.mohcc.mrs.ehr_mobile.model.terminology.ArtReason;


@Dao
public interface ArtReasonDao {

    @Insert
    void insertAll(List<ArtReason> artReasons);

    @Insert
    void insertOne(ArtReason artReason);

    @Query("DELETE FROM ArtReason")
    void deleteAll();

    @Query("SELECT * FROM ArtReason")
    List<ArtReason> findAll();

    @Query("SELECT * FROM ArtReason WHERE code=:id")
    ArtReason findById(String id);

    @Query("SELECT * FROM ArtReason WHERE name=:name")
    ArtReason findByName(String name);

}
