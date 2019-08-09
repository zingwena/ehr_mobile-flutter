package zw.gov.mohcc.mrs.ehr_mobile.persistance.dao;

import androidx.room.Dao;
import androidx.room.Insert;
import androidx.room.Query;

import java.util.List;

import zw.gov.mohcc.mrs.ehr_mobile.model.Education;

@Dao
public interface EducationDao {

    @Insert
    void insertEducations(List<Education> educations);

    @Insert
    void insertReligion(Education education);

   @Insert
    void insertEducationList(List<Education> educationList);

   @Insert
    void insertEducation(Education education);

   @Query("SELECT * FROM Education")
    List<Education> getEducationList();

   @Query("SELECT * FROM Education WHERE id=:id")
    Education findByEducationId(int id);
}
