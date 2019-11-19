package zw.gov.mohcc.mrs.ehr_mobile.persistance.dao;

import androidx.room.Dao;
import androidx.room.Insert;
import androidx.room.Query;

import java.util.List;

import zw.gov.mohcc.mrs.ehr_mobile.model.terminology.ArtStatus;


@Dao
public interface ArtStatusDao {

    @Insert
    void insertAll(List<ArtStatus> artStatuses);

    @Insert
    void insertOne(ArtStatus artStatus);

    @Query("DELETE FROM ArtStatus")
    void deleteAll();

    @Query("SELECT * FROM ArtStatus")
    List<ArtStatus> findAll();

    @Query("SELECT * FROM ArtStatus WHERE code=:id")
    ArtStatus findById(String id);

    @Query("SELECT * FROM ArtStatus WHERE name=:name")
    ArtStatus findByName(String name);

}
