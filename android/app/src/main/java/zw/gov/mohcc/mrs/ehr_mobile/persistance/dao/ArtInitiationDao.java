package zw.gov.mohcc.mrs.ehr_mobile.persistance.dao;

import androidx.room.Dao;
import androidx.room.Insert;
import androidx.room.OnConflictStrategy;
import androidx.room.Query;
import androidx.room.RawQuery;
import androidx.room.Update;
import androidx.sqlite.db.SimpleSQLiteQuery;

import java.util.List;

import zw.gov.mohcc.mrs.ehr_mobile.model.ArtInitiation;



@Dao
public interface ArtInitiationDao {


    @Insert(onConflict = OnConflictStrategy.REPLACE)
    void createArtInitiation(ArtInitiation artInitiation);

    @Query("DELETE from ArtInitiation")
    void deleteAll();

    @Query("SELECT COUNT(id) FROM ArtInitiation WHERE id =:id")
    int getNumberOfRows(String id);

    @Update
    void updateArtInitiation(ArtInitiation artInitiation);

    @Query("SELECT * FROM ArtInitiation")
    List<ArtInitiation> listArtInitiation();

    @Query("SELECT * FROM ArtInitiation WHERE id =:id")
    ArtInitiation findArtInitiationById(String id);

    @Query("DELETE FROM ArtInitiation where id = :id")
    void deleteById(String id);

    @RawQuery
    List<ArtInitiation> searchArtInitiation(SimpleSQLiteQuery query);




}
