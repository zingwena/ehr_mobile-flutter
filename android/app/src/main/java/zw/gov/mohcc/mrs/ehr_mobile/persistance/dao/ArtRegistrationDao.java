package zw.gov.mohcc.mrs.ehr_mobile.persistance.dao;

import androidx.room.Dao;
import androidx.room.Insert;
import androidx.room.OnConflictStrategy;
import androidx.room.Query;
import androidx.room.RawQuery;
import androidx.room.Update;
import androidx.sqlite.db.SimpleSQLiteQuery;

import java.util.List;

import zw.gov.mohcc.mrs.ehr_mobile.model.ArtRegistration;


@Dao
public interface ArtRegistrationDao {


    @Insert(onConflict = OnConflictStrategy.REPLACE)
    void createArtRegistration(ArtRegistration artRegistration);

    @Query("DELETE from ArtRegistration")
    void deleteAll();

    @Query("SELECT COUNT(id) FROM ArtRegistration WHERE id =:id")
    int getNumberOfRows(String id);

    @Update
    void updateArtRegistration(ArtRegistration artRegistration);

    @Query("SELECT * FROM ArtRegistration")
    List<ArtRegistration> listArtRegistration();

    @Query("SELECT * FROM ArtRegistration WHERE id =:id")
    ArtRegistration findArtRegistrationById(String id);

    @Query("DELETE FROM ArtRegistration where id = :id")
    void deleteById(String id);

    @RawQuery
    List<ArtRegistration> searchArtRegistration(SimpleSQLiteQuery query);




}
