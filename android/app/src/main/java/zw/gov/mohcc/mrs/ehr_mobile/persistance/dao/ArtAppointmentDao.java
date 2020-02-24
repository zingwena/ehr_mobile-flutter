package zw.gov.mohcc.mrs.ehr_mobile.persistance.dao;

import androidx.room.Dao;
import androidx.room.Insert;
import androidx.room.Query;

import java.util.List;

import zw.gov.mohcc.mrs.ehr_mobile.model.art.ArtAppointment;

@Dao
public interface ArtAppointmentDao {

    @Query("DELETE FROM ArtAppointment")
    void deleteAll();

    @Insert
    void save(ArtAppointment artAppointment);

    @Query("SELECT * FROM ArtAppointment WHERE id=:id")
    ArtAppointment findById(String id);

    @Query("SELECT * FROM ArtAppointment WHERE artId=:artId Order By date DESC")
    List<ArtAppointment> findByArtIdOrderByDateDesc(String artId);

    @Query("SELECT * FROM ArtAppointment WHERE artId=:artId and date between:date and :endDate")
    ArtAppointment findByArtIdAndDate(String artId, long date, long endDate);
}
