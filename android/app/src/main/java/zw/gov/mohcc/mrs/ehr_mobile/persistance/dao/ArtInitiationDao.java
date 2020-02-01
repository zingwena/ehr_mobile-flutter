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
public interface ArtInitiationDao {


    @Insert(onConflict = OnConflictStrategy.REPLACE)
    void createArtInitiation(ArtCurrentStatus artCurrentStatus);

    @Query("DELETE from ArtCurrentStatus")
    void deleteAll();

    @Query("SELECT COUNT(id) FROM ArtCurrentStatus WHERE id =:id")
    int getNumberOfRows(String id);

    @Update
    void updateArtInitiation(ArtCurrentStatus artCurrentStatus);

    @Query("SELECT * FROM ArtCurrentStatus")
    List<ArtCurrentStatus> listArtInitiation();

    @Query("SELECT * FROM ArtCurrentStatus WHERE id =:id")
    ArtCurrentStatus findArtInitiationById(String id);

    @Query("DELETE FROM ArtCurrentStatus where id = :id")
    void deleteById(String id);

    @RawQuery
    List<ArtCurrentStatus> searchArtInitiation(SimpleSQLiteQuery query);

    @Query("SELECT * FROM ArtCurrentStatus WHERE personId =:personId")
    ArtCurrentStatus findByPersonId(String personId);




}
