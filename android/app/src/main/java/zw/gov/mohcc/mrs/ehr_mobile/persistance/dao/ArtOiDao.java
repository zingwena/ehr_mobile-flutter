package zw.gov.mohcc.mrs.ehr_mobile.persistance.dao;

import androidx.room.Dao;
import androidx.room.Insert;
import androidx.room.OnConflictStrategy;
import androidx.room.Query;
import androidx.room.Update;

import zw.gov.mohcc.mrs.ehr_mobile.model.art.ArtOi;


@Dao
public interface ArtOiDao {


    @Insert(onConflict = OnConflictStrategy.REPLACE)
    void save(ArtOi artOi);

    @Query("DELETE from ArtOi")
    void deleteAll();

    @Update
    void update(ArtOi artOi);

    @Query("SELECT * FROM ArtOi WHERE id=:id")
    ArtOi findByArtId(String id);

    @Query("DELETE FROM ArtOi where id=:id")
    void deleteById(String id);

    @Query("SELECT * FROM ArtOi WHERE artId=:artId")
    ArtOi findById(String artId);

    @Query("SELECT * FROM ArtOi WHERE artId=:artId and code=:questionId")
    ArtOi findByArtIdAndQuestionId(String artId, String questionId);
}
