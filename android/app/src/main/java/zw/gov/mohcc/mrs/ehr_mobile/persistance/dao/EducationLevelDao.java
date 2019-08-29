package zw.gov.mohcc.mrs.ehr_mobile.persistance.dao;

import androidx.room.Dao;
import androidx.room.Insert;
import androidx.room.Query;

import java.util.List;

import zw.gov.mohcc.mrs.ehr_mobile.model.EducationLevel;

@Dao
public interface EducationLevelDao {

   @Insert
    void insertEducationLevels(List<EducationLevel> educationLevels);

   @Query("DELETE FROM educationlevel")
   void deleteEducationLevels();

   @Insert
    void insertEducation(EducationLevel EducationLevel);

   @Query("SELECT * FROM EducationLevel ")
    List<EducationLevel> getEducationLevels();

   @Query("SELECT name FROM EducationLevel WHERE id=:id")
   String findByEducationLevelId(String id);

}
