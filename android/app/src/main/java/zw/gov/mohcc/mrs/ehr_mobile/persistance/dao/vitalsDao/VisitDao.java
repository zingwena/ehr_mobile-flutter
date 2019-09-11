package zw.gov.mohcc.mrs.ehr_mobile.persistance.dao.vitalsDao;

import androidx.room.Dao;
import androidx.room.Insert;
import androidx.room.Query;

import java.util.Date;
import java.util.List;

import zw.gov.mohcc.mrs.ehr_mobile.model.vitals.Visit;

@Dao
public interface VisitDao {
    @Insert
    void insert(Visit visit);

    //@Query("SELECT * FROM Visit WHERE personId = :personId AND visitDate Between :startTime and :endTime")
    //Visit findByPersonVisit(String personId, Date startTime, Date endTime);

    @Query("SELECT * FROM Visit")
    List<Visit> getAll();

    /*
    @Query("SELECT * FROM Person WHERE firstName=:firstName AND lastName=:lastName")
    Person findPatientByName (String firstName, String lastName);
     */
}
