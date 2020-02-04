package zw.gov.mohcc.mrs.ehr_mobile.persistance.dao;

import androidx.room.Dao;
import androidx.room.Insert;
import androidx.room.OnConflictStrategy;
import androidx.room.Query;
import androidx.room.Update;

import java.util.List;

import zw.gov.mohcc.mrs.ehr_mobile.model.art.Art;
import zw.gov.mohcc.mrs.ehr_mobile.model.art.ArtVisit;


@Dao
public interface ArtVisitDao {


    @Insert(onConflict = OnConflictStrategy.REPLACE)
    void save(ArtVisit artVisit);

    @Query("DELETE from ArtVisit")
    void deleteAll();

    @Update
    void update(ArtVisit artVisit);

    @Query("SELECT * FROM ArtVisit WHERE id=:id")
    ArtVisit findById(String id);

    @Query("SELECT * FROM ArtVisit WHERE visitId=:visitId")
    ArtVisit findByVisitId(String visitId);

    @Query("SELECT * FROM ArtVisit a inner join Visit v on a.visitId=v.id WHERE artId=:artId Order by v.time DESC")
    List<ArtVisit> findByArtId(String artId);

    @Query("DELETE FROM ArtVisit where id=:id")
    void deleteById(String id);
}
