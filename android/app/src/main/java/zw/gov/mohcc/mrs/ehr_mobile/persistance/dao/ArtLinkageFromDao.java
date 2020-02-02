package zw.gov.mohcc.mrs.ehr_mobile.persistance.dao;

import androidx.room.Dao;
import androidx.room.Insert;
import androidx.room.OnConflictStrategy;
import androidx.room.Query;
import androidx.room.Update;

import zw.gov.mohcc.mrs.ehr_mobile.model.art.Art;
import zw.gov.mohcc.mrs.ehr_mobile.model.art.ArtLinkageFrom;


@Dao
public interface ArtLinkageFromDao {


    @Insert(onConflict = OnConflictStrategy.REPLACE)
    void save(ArtLinkageFrom artLinkageFrom);

    @Query("DELETE from ArtLinkageFrom")
    void deleteAll();

    @Update
    void update(ArtLinkageFrom artLinkageFrom);

    @Query("SELECT * FROM ArtLinkageFrom WHERE id=:id")
    ArtLinkageFrom findById(String id);

    @Query("SELECT * FROM ArtLinkageFrom WHERE artId=:artId")
    ArtLinkageFrom findByArtId(String artId);

    @Query("DELETE FROM ArtLinkageFrom where id=:id")
    void deleteById(String id);
}
