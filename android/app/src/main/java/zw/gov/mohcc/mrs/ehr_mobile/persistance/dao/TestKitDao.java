package zw.gov.mohcc.mrs.ehr_mobile.persistance.dao;

import androidx.room.Dao;
import androidx.room.Insert;
import androidx.room.Query;

import java.util.List;

import zw.gov.mohcc.mrs.ehr_mobile.enumeration.TestLevel;
import zw.gov.mohcc.mrs.ehr_mobile.model.terminology.TestKit;

/**
 * @author kombo on 8/21/19
 */
@Dao
public interface TestKitDao {
    @Insert
    void saveAll(List<TestKit> testKits);

    @Query("DELETE FROM TestKit")
    void deleteAll();

    @Insert
    void saveOne(TestKit testKit);

    @Query("SELECT * FROM TestKit ORDER BY name ASC")
    List<TestKit> findAll();

    @Query("SELECT * FROM TestKit WHERE code=:id")
    TestKit findById(String id);

    @Query("SELECT t.* FROM TestKit t inner join TestKitTestLevel l on l.testKitId=t.code WHERE l.testLevel=:level")
    List<TestKit> findTestKitsByLevel(TestLevel level);

    @Query("SELECT * FROM TestKit WHERE code in (:ids)")
    List<TestKit> findTestKitIdsIn(List<String> ids);
}
