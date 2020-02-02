package zw.gov.mohcc.mrs.ehr_mobile.persistance.dao;

import androidx.room.Dao;
import androidx.room.Insert;
import androidx.room.Query;

import zw.gov.mohcc.mrs.ehr_mobile.model.art.ArtAppointment;

@Dao
public interface ArtAppointmentDao {

    @Query("DELETE FROM ArtAppointment")
    void deleteAll();

    @Insert
    void saveOne(ArtAppointment artAppointment);

    @Query("SELECT * FROM ArtAppointment WHERE id=:id")
    ArtAppointment findById(String id);

}
