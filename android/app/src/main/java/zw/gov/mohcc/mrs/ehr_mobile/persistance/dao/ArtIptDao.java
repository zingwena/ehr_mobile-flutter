package zw.gov.mohcc.mrs.ehr_mobile.persistance.dao;

import androidx.room.Dao;
import androidx.room.Insert;
import androidx.room.OnConflictStrategy;
import androidx.room.Query;
import androidx.room.Update;

import java.util.List;

import zw.gov.mohcc.mrs.ehr_mobile.model.art.ArtIpt;

@Dao
public interface ArtIptDao {

    @Insert(onConflict = OnConflictStrategy.REPLACE)
    void save(ArtIpt artIpt);

    @Query("DELETE from ArtIpt")
    void deleteAll();

    @Update
    void update(ArtIpt artIpt);

    @Query("SELECT a.* FROM ArtIpt a inner join Visit v on a.visitId=v.id WHERE artId=:artId Order By v.time DESC")
    List<ArtIpt> findByArtId(String artId);

    @Query("DELETE FROM ArtIpt where id=:id")
    void deleteById(String id);

    @Query("SELECT a.* FROM ArtIpt a inner join Visit v on a.visitId=v.id WHERE artId=:artId Order By v.time DESC limit 1")
    ArtIpt findLatestIpt(String artId);

    @Query("SELECT * FROM ArtIpt WHERE visitId=:visitId")
    ArtIpt findByVisitId(String visitId);
}
