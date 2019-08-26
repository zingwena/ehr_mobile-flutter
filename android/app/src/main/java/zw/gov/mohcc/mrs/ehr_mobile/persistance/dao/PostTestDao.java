package zw.gov.mohcc.mrs.ehr_mobile.persistance.dao;

import androidx.room.Dao;
import androidx.room.Insert;
import androidx.room.OnConflictStrategy;
import androidx.room.Query;
import androidx.room.RawQuery;
import androidx.room.Update;
import androidx.sqlite.db.SimpleSQLiteQuery;

import java.util.List;

import zw.gov.mohcc.mrs.ehr_mobile.model.PostTest;


@Dao
public interface PostTestDao {
    @Insert(onConflict = OnConflictStrategy.REPLACE)
    Long createPostTest(PostTest postTest);

    @Query("DELETE from PostTest")
    void deleteAll();

    @Query("SELECT COUNT(id) FROM PostTest WHERE id =:id")
    int getNumberOfRows(int id);

    @Update
    int updatePostTest(PostTest postTest);

    @Query("SELECT * FROM PostTest ORDER BY id Asc")
    List<PostTest> listPostTest();

    @Query("SELECT * FROM PostTest WHERE id =:id")
    PostTest findPostTestById(int id);

    @Query("DELETE FROM PostTest where id = :id")
    void deleteById(Long id);

    @RawQuery
    List<PostTest> searchPostTest(SimpleSQLiteQuery query);

//

}
