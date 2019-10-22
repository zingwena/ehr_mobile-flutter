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

    @Query("DELETE from Visit")
    void deleteAll();

    @Query("SELECT * FROM Visit WHERE personId = :personId")
    Visit findByPersonVisit(String personId);

    @Query("SELECT * FROM Visit")
    List<Visit> getAll();

    @Query("SELECT * FROM Visit WHERE id = :id")
    Visit findById(String id);
}
