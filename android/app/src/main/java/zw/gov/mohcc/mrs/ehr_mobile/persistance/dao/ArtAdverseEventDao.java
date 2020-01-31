package zw.gov.mohcc.mrs.ehr_mobile.persistance.dao;

import androidx.room.Dao;
import androidx.room.Insert;
import androidx.room.Query;

import java.util.List;

import zw.gov.mohcc.mrs.ehr_mobile.model.terminology.ArtAdverseEvent;

@Dao
public interface ArtAdverseEventDao {

    @Insert
    void saveOne(ArtAdverseEvent artAdverseEvent);

    @Query("DELETE FROM ArtAdverseEvent")
    void deleteAll();

    @Insert
    void saveAll(List<ArtAdverseEvent> artAdverseEvents);

    @Query("SELECT * FROM ArtAdverseEvent ORDER BY name DESC")
    List<ArtAdverseEvent> findAll();
}
