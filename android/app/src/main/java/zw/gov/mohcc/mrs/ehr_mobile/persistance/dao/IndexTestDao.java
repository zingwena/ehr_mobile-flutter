package zw.gov.mohcc.mrs.ehr_mobile.persistance.dao;

import androidx.room.Dao;
import androidx.room.Insert;
import androidx.room.Query;

import java.util.List;

import zw.gov.mohcc.mrs.ehr_mobile.model.EntryPoint;
import zw.gov.mohcc.mrs.ehr_mobile.model.IndexTest;


@Dao
public interface IndexTestDao {

    @Insert
    void saveAll(List<IndexTest> indexTests);

    @Query("DELETE FROM IndexTest")
    void deleteAll();

    @Insert
    void saveOne(IndexTest indexTest);

    @Query("SELECT * FROM IndexTest Where personId=:personId")
    List<IndexTest> findByPersonId(String personId);

    @Query("SELECT * FROM IndexTest WHERE id=:id")
    IndexTest findById(String id);

}
