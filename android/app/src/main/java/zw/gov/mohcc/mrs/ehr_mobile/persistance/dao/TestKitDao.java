package zw.gov.mohcc.mrs.ehr_mobile.persistance.dao;

import androidx.room.Dao;
import androidx.room.Insert;
import androidx.room.Query;

import java.util.List;

import zw.gov.mohcc.mrs.ehr_mobile.model.terminology.TestKit;

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

    @Query("SELECT * FROM TestKit WHERE name=:name")
    TestKit findTestKitByName(String name);

    @Query("SELECT * FROM TestKit t inner join TestKitTestLevel l on l.testKitId=t.code WHERE l.testLevel=:level")
    List<TestKit> findTestKitsByLevel(String level);

    @Query("SELECT * FROM TestKit WHERE code in (:ids)")
    List<TestKit> findTestKitIdsIn(List<String> ids);
}
