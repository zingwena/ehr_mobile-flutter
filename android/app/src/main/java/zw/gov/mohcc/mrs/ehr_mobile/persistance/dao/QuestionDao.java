package zw.gov.mohcc.mrs.ehr_mobile.persistance.dao;

import androidx.room.Dao;
import androidx.room.Insert;
import androidx.room.Query;

import java.util.List;

import zw.gov.mohcc.mrs.ehr_mobile.enumeration.WorkArea;
import zw.gov.mohcc.mrs.ehr_mobile.model.terminology.Question;


@Dao
public interface QuestionDao {

    @Insert
    void saveAll(List<Question> questions);

    @Query("DELETE FROM Question")
    void deleteAll();

    @Insert
    void saveOne(Question question);

    @Query("SELECT * FROM Question ORDER BY name ASC")
    List<Question> findAll();

    @Query("SELECT * FROM Question WHERE code=:code")
    Question findById(String code);

    @Query("SELECT * FROM Question where name=:name")
    Question findByName(String name);

    @Query("SELECT * FROM Question where workArea=:workArea Order by name ASC")
    List<Question> findByWorkArea(WorkArea workArea);

    @Query("SELECT * FROM Question where categoryId=:categoryId Order by name ASC")
    List<Question> findByCategoryId(String categoryId);

    @Query("SELECT q.* FROM Question q inner join QuestionCategory c on c.code=q.categoryId where q.workArea=:workArea and q.categoryId=:categoryId Order by name ASC")
    List<Question> findByWorkAreaAndCategoryId(WorkArea workArea, String categoryId);
}
