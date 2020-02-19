package zw.gov.mohcc.mrs.ehr_mobile.persistance.dao;

import androidx.room.Dao;
import androidx.room.Insert;
import androidx.room.OnConflictStrategy;
import androidx.room.Query;
import androidx.room.Update;

import java.util.Date;
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

    @Query("SELECT a.* FROM ArtIpt a WHERE artId=:artId Order By a.date DESC")
    List<ArtIpt> findByArtId(String artId);

    @Query("DELETE FROM ArtIpt where id=:id")
    void deleteById(String id);

    @Query("SELECT a.* FROM ArtIpt a WHERE artId=:artId Order By a.date DESC limit 1")
    ArtIpt findLatestIpt(String artId);

    @Query("SELECT * FROM ArtIpt WHERE date=:date")
    ArtIpt findByDate(Long date);
}
