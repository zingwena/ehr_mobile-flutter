package zw.gov.mohcc.mrs.ehr_mobile.persistance.dao;

import androidx.room.Dao;
import androidx.room.Insert;
import androidx.room.OnConflictStrategy;
import androidx.room.Query;
import androidx.room.Update;

import zw.gov.mohcc.mrs.ehr_mobile.model.art.ArtFollowUp;


@Dao
public interface ArtFollowUpDao {


    @Insert(onConflict = OnConflictStrategy.REPLACE)
    void save(ArtFollowUp artFollowUp);

    @Query("DELETE from ArtFollowUp")
    void deleteAll();

    @Update
    void update(ArtFollowUp artFollowUp);

    @Query("SELECT * FROM ArtFollowUp WHERE id=:id")
    ArtFollowUp findById(String id);

    @Query("SELECT * FROM ArtFollowUp WHERE artAppointmentId=:artAppointmentId")
    ArtFollowUp findByArtAppointmentId(String artAppointmentId);

    @Query("DELETE FROM ArtFollowUp where id=:id")
    void deleteById(String id);
}
