package zw.gov.mohcc.mrs.ehr_mobile.persistance.dao;

import androidx.room.Dao;
import androidx.room.Insert;
import androidx.room.Query;

import java.util.List;

import zw.gov.mohcc.mrs.ehr_mobile.model.terminology.EducationLevel;

@Dao
public interface EducationLevelDao {

    @Insert
    void saveAll(List<EducationLevel> educationLevels);

    @Query("DELETE FROM educationlevel")
    void deleteAll();

    @Insert
    void saveOne(EducationLevel EducationLevel);

    @Query("SELECT * FROM EducationLevel Order By name ASC")
    List<EducationLevel> findAll();

    @Query("SELECT name FROM EducationLevel WHERE code=:code")
    String findbyId(String code);

}
