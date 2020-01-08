package zw.gov.mohcc.mrs.ehr_mobile.persistance.dao;

import androidx.room.Dao;
import androidx.room.Insert;
import androidx.room.OnConflictStrategy;
import androidx.room.Query;
import androidx.room.Update;

import java.util.List;

import zw.gov.mohcc.mrs.ehr_mobile.model.warehouse.TestKitBatchIssue;

@Dao
public interface TestKitBatchIssueDao {


    @Insert(onConflict = OnConflictStrategy.REPLACE)
    void save(TestKitBatchIssue testKitBatchIssue);

    @Insert
    void saveAll(List<TestKitBatchIssue> testKitBatchIssues);

    @Query("DELETE from TestKitBatchIssue")
    void deleteAll();

    @Update
    void update(TestKitBatchIssue testKitBatchIssue);

    @Query("SELECT * FROM TestKitBatchIssue")
    List<TestKitBatchIssue> findAll();

    @Query("SELECT * FROM TestKitBatchIssue WHERE id=:id")
    TestKitBatchIssue findById(String id);

    @Query("DELETE FROM TestKitBatchIssue where id=:id")
    void deleteById(String id);
}
