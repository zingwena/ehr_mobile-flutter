package zw.gov.mohcc.mrs.ehr_mobile.persistance.dao;

import androidx.room.Dao;
import androidx.room.Insert;
import androidx.room.Query;

import java.util.List;

import zw.gov.mohcc.mrs.ehr_mobile.enumeration.TestLevel;
import zw.gov.mohcc.mrs.ehr_mobile.model.terminology.TestKitTestLevel;

/**
 * @author kombo on 8/21/19
 */
@Dao
public interface TestKitTestLevelDao {
    @Insert
    void saveAll(List<TestKitTestLevel> testKitTestLevels);

    @Query("DELETE FROM TestKitTestLevel")
    void deleteAll();

    @Insert
    void saveOne(TestKitTestLevel testKitTestLevel);

    @Query("SELECT * FROM TestKitTestLevel")
    List<TestKitTestLevel> findAll();

    @Query("SELECT * FROM TestKitTestLevel WHERE testKitId=:testKitId")
    List<TestKitTestLevel> findByTestKitId(String testKitId);

    @Query("SELECT * FROM TestKitTestLevel WHERE testLevel=:testLevel")
    List<TestKitTestLevel> findByTestLevel(TestLevel testLevel);

    @Query("SELECT * FROM TestKitTestLevel WHERE testKitId=:testKitId and testLevel=:testLevel")
    TestKitTestLevel findByTestKitIdAndTestLevel(String testKitId, TestLevel testLevel);
}
