package zw.gov.mohcc.mrs.ehr_mobile.persistance.dao;

import androidx.room.Dao;
import androidx.room.Insert;
import androidx.room.Query;

import java.util.List;

import zw.gov.mohcc.mrs.ehr_mobile.model.TestKit;

/**
 * @author kombo on 8/21/19
 */
@Dao
public interface TestKitDao {
    @Insert
    void insertTestKits(List<TestKit> testKits);

    @Query("DELETE FROM TestKit")
    void deleteTestKits();


    @Insert
    void insertTestKit(TestKit testKit);

    @Query("SELECT * FROM TestKit ORDER BY  name ASC")
    List<TestKit> getAllTestKits();

    @Query("SELECT * FROM TestKit WHERE code=:id")
    TestKit findTestKitById(String id);

    @Query("SELECT * FROM TestKit WHERE level=:level")
    List<TestKit> findTestKitsByLevel(String level);

}
