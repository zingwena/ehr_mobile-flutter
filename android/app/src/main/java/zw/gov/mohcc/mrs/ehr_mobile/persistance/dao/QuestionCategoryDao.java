package zw.gov.mohcc.mrs.ehr_mobile.persistance.dao;

import androidx.room.Dao;
import androidx.room.Insert;
import androidx.room.Query;

import java.util.List;

import zw.gov.mohcc.mrs.ehr_mobile.enumeration.WorkArea;
import zw.gov.mohcc.mrs.ehr_mobile.model.terminology.QuestionCategory;


@Dao
public interface QuestionCategoryDao {

    @Insert
    void saveAll(List<QuestionCategory> questionCategories);

    @Query("DELETE FROM QuestionCategory")
    void deleteAll();

    @Insert
    void saveOne(QuestionCategory questionCategory);

    @Query("SELECT * FROM QuestionCategory ORDER BY name ASC")
    List<QuestionCategory> findAll();

    @Query("SELECT * FROM QuestionCategory WHERE code=:code")
    QuestionCategory findByid(String code);

    @Query("SELECT * FROM QuestionCategory where name=:name")
    QuestionCategory findByName(String name);

    @Query("SELECT * FROM QuestionCategory where workArea=:workArea")
    List<QuestionCategory> findByWorkArea(WorkArea workArea);
}
