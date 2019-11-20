package zw.gov.mohcc.mrs.ehr_mobile.persistance.dao;

import androidx.room.Dao;
import androidx.room.Insert;
import androidx.room.OnConflictStrategy;
import androidx.room.Query;
import androidx.room.RawQuery;
import androidx.room.Update;
import androidx.sqlite.db.SimpleSQLiteQuery;

import java.util.List;

import zw.gov.mohcc.mrs.ehr_mobile.model.art.Art;


@Dao
public interface ArtRegistrationDao {


    @Insert(onConflict = OnConflictStrategy.REPLACE)
    void createArtRegistration(Art artRegistration);

    @Query("DELETE from Art")
    void deleteAll();

    @Query("SELECT COUNT(id) FROM Art WHERE id =:id")
    int getNumberOfRows(String id);

    @Update
    void updateArtRegistration(Art artRegistration);

    @Query("SELECT * FROM Art")
    List<Art> listArtRegistration();

    @Query("SELECT * FROM Art WHERE id =:id")
    Art findArtRegistrationById(String id);

    @Query("SELECT * FROM Art WHERE personId =:personId")
    Art findByPersonId(String personId);

    @Query("DELETE FROM Art where id = :id")
    void deleteById(String id);

    @RawQuery
    List<Art> searchArtRegistration(SimpleSQLiteQuery query);




}
