package zw.gov.mohcc.mrs.ehr_mobile.persistance.dao;

import androidx.room.Dao;
import androidx.room.Insert;
import androidx.room.Query;

import java.util.List;

import zw.gov.mohcc.mrs.ehr_mobile.model.Education;
import zw.gov.mohcc.mrs.ehr_mobile.model.Religion;

@Dao
public interface EducationDao {

    @Insert
    void insertEducations(List<Education> educations);

    @Insert
    void insertReligion(Education education);

    @Query("SELECT * FROM Education")
    List<Religion> getAllEducations();

    @Query("SELECT * FROM Education WHERE id=:id")
    Religion findEducationById(int id);
}
