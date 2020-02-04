package zw.gov.mohcc.mrs.ehr_mobile.persistance.dao;

import androidx.room.Dao;
import androidx.room.Insert;
import androidx.room.OnConflictStrategy;
import androidx.room.Query;
import androidx.room.Update;

import java.util.List;

import zw.gov.mohcc.mrs.ehr_mobile.model.art.ArtWhoStage;


@Dao
public interface ArtWhoStageDao {


    @Insert(onConflict = OnConflictStrategy.REPLACE)
    void save(ArtWhoStage artWhoStage);

    @Query("DELETE from ArtWhoStage")
    void deleteAll();

    @Update
    void update(ArtWhoStage artWhoStage);

    @Query("SELECT a.* FROM ArtWhoStage a inner join Visit v on a.visitId=v.id WHERE id=:id Order By v.time DESC")
    List<ArtWhoStage> findByArtId(String id);

    @Query("DELETE FROM ArtWhoStage where id=:id")
    void deleteById(String id);

    @Query("SELECT * FROM ArtWhoStage WHERE visitId=:visitId")
    ArtWhoStage findByVisitId(String visitId);
}
