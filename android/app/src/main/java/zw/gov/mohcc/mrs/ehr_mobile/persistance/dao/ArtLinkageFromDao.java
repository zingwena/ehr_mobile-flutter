package zw.gov.mohcc.mrs.ehr_mobile.persistance.dao;

import androidx.room.Dao;
import androidx.room.Insert;
import androidx.room.OnConflictStrategy;
import androidx.room.Query;
import androidx.room.Update;

import zw.gov.mohcc.mrs.ehr_mobile.model.art.Art;


@Dao
public interface ArtLinkageFromDao {


    @Insert(onConflict = OnConflictStrategy.REPLACE)
    void save(Art artRegistration);

    @Query("DELETE from Art")
    void deleteAll();

    @Update
    void update(Art artRegistration);

    @Query("SELECT * FROM Art WHERE id =:id")
    Art findById(String id);

    @Query("SELECT * FROM Art WHERE personId =:personId")
    Art findByArtId(String personId);

    @Query("DELETE FROM Art where id = :id")
    void deleteById(String id);
}
