package zw.gov.mohcc.mrs.ehr_mobile.persistance.dao;

import androidx.room.Dao;
import androidx.room.Insert;
import androidx.room.OnConflictStrategy;
import androidx.room.Query;
import androidx.room.RawQuery;
import androidx.room.Update;
import androidx.sqlite.db.SimpleSQLiteQuery;

import java.util.List;

import zw.gov.mohcc.mrs.ehr_mobile.model.art.ArtInitiation;
import zw.gov.mohcc.mrs.ehr_mobile.model.warehouse.TestKitBatch;

@Dao
public interface TestKitBatchDao {


    @Insert(onConflict = OnConflictStrategy.REPLACE)
    void save(TestKitBatch testKitBatch);

    @Query("DELETE from testKitBatch")
    void deleteAll();

    @Update
    void update(TestKitBatch testKitBatch);

    @Query("SELECT * FROM TestKitBatch")
    List<TestKitBatch> findAll();

    @Query("SELECT * FROM TestKitBatch WHERE id=:id")
    TestKitBatch findById(String id);

    @Query("DELETE FROM TestKitBatch where id=:id")
    void deleteById(String id);
}
