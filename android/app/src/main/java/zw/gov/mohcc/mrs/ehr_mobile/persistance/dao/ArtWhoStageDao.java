package zw.gov.mohcc.mrs.ehr_mobile.persistance.dao;

import androidx.room.Dao;
import androidx.room.Insert;
import androidx.room.OnConflictStrategy;
import androidx.room.Query;
import androidx.room.Update;

import java.util.List;

import zw.gov.mohcc.mrs.ehr_mobile.enumeration.WhoStage;
import zw.gov.mohcc.mrs.ehr_mobile.model.art.ArtWhoStage;


@Dao
public interface ArtWhoStageDao {


    @Insert(onConflict = OnConflictStrategy.REPLACE)
    void save(ArtWhoStage artWhoStage);

    @Query("DELETE from ArtWhoStage")
    void deleteAll();

    @Update
    void update(ArtWhoStage artWhoStage);

    @Query("SELECT a.* FROM ArtWhoStage a inner join Visit v on a.visitId=v.id WHERE artId=:artid Order By v.time DESC")
    List<ArtWhoStage> findByArtId(String artid);

    @Query("DELETE FROM ArtWhoStage where id=:id")
    void deleteById(String id);

    @Query("SELECT * FROM ArtWhoStage WHERE visitId=:visitId")
    ArtWhoStage findByVisitId(String visitId);

    @Query("SELECT count(*) FROM ArtWhoStage WHERE artId=:artId and stage=:whoStage")
    int existsByArtIdAndWhoStage(String artId, WhoStage whoStage);

    @Query("SELECT * FROM ArtWhoStage WHERE artId=:artId and stage=:whoStage")
    ArtWhoStage findByArtIdAndWhoStage(String artId, WhoStage whoStage);
}
