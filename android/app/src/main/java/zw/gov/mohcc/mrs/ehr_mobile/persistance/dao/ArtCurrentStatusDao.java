package zw.gov.mohcc.mrs.ehr_mobile.persistance.dao;

import androidx.room.Dao;
import androidx.room.Insert;
import androidx.room.OnConflictStrategy;
import androidx.room.Query;
import androidx.room.RawQuery;
import androidx.room.Update;
import androidx.sqlite.db.SimpleSQLiteQuery;

import java.util.List;

import zw.gov.mohcc.mrs.ehr_mobile.model.art.ArtCurrentStatus;


@Dao
public interface ArtCurrentStatusDao {


    @Insert(onConflict = OnConflictStrategy.REPLACE)
    void save(ArtCurrentStatus artCurrentStatus);

    @Query("DELETE from ArtCurrentStatus")
    void deleteAll();

    @Update
    void update(ArtCurrentStatus artCurrentStatus);

    @Query("SELECT * FROM ArtCurrentStatus WHERE id =:id")
    ArtCurrentStatus findArtInitiationById(String id);

    @Query("DELETE FROM ArtCurrentStatus where id=:id")
    void deleteById(String id);

    @Query("SELECT * FROM ArtCurrentStatus WHERE artId=:artId")
    ArtCurrentStatus findByVisitId(String artId);

    @Query("SELECT * FROM ArtCurrentStatus WHERE artId=:artId Order By date Desc limit 1")
    ArtCurrentStatus findLastestPatientStatus(String artId);
}
