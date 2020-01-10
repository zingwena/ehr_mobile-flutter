package zw.gov.mohcc.mrs.ehr_mobile.persistance.dao;

import androidx.room.Dao;
import androidx.room.Insert;
import androidx.room.Query;

import java.util.List;

import zw.gov.mohcc.mrs.ehr_mobile.model.terminology.PurposeOfTest;


@Dao
public interface PurposeOfTestDao {

    @Insert
    void saveAll(List<PurposeOfTest> purposeOfTests);

    @Insert
    void saveOne(PurposeOfTest purposeOfTest);

    @Query("DELETE FROM PurposeOfTest")
    void deleteAll();

    @Query("SELECT * FROM PurposeOfTest Order By name ASC")
    List<PurposeOfTest> findAll();

    @Query("SELECT * FROM PurposeOfTest WHERE code=:id")
    PurposeOfTest findById(String id);

    @Query("SELECT * FROM PurposeOfTest WHERE name=:name")
    PurposeOfTest findByName(String name);

}
