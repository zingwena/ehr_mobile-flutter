package zw.gov.mohcc.mrs.ehr_mobile.persistance.dao;

import androidx.room.Dao;
import androidx.room.Entity;
import androidx.room.Insert;
import androidx.room.Query;

import java.util.List;

import zw.gov.mohcc.mrs.ehr_mobile.model.EducationLevel;
@Entity
@Dao
public interface EducationLevelDao {

   @Insert
    void insertEducationLevels(List<EducationLevel> educationLevels);

   @Query("DELETE FROM educationlevel")
   void deleteEducationLevels();

   @Insert
    void insertEducation(EducationLevel EducationLevel);

   @Query("SELECT * FROM EducationLevel")
    List<EducationLevel> getEducationLevels();

   @Query("SELECT * FROM EducationLevel WHERE id=:id")
   EducationLevel findByEducationLevelId(int id);

}
