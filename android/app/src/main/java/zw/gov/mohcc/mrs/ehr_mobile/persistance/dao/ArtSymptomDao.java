package zw.gov.mohcc.mrs.ehr_mobile.persistance.dao;

import androidx.room.Dao;
import androidx.room.Insert;
import androidx.room.OnConflictStrategy;
import androidx.room.Query;
import androidx.room.Update;

import zw.gov.mohcc.mrs.ehr_mobile.model.art.ArtSymptom;


@Dao
public interface ArtSymptomDao {


    @Insert(onConflict = OnConflictStrategy.REPLACE)
    void save(ArtSymptom artSymptom);

    @Query("DELETE from ArtSymptom")
    void deleteAll();

    @Update
    void update(ArtSymptom artSymptom);

    @Query("SELECT * FROM ArtSymptom WHERE id=:id")
    ArtSymptom findByArtId(String id);

    @Query("DELETE FROM ArtSymptom where id=:id")
    void deleteById(String id);

    @Query("SELECT * FROM ArtSymptom WHERE artId=:artId")
    ArtSymptom findById(String artId);

    @Query("SELECT * FROM ArtSymptom WHERE artId=:artId and code=:questionId")
    ArtSymptom findByArtIdAndQuestionId(String artId, String questionId);
}
