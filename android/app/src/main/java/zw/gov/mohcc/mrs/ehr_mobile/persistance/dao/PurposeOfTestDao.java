package zw.gov.mohcc.mrs.ehr_mobile.persistance.dao;

import androidx.room.Dao;
import androidx.room.Insert;
import androidx.room.Query;

import java.util.List;

import zw.gov.mohcc.mrs.ehr_mobile.model.PurposeOfTest;


@Dao
public interface PurposeOfTestDao {

    @Insert
    void insertPurposeOfTest(List<PurposeOfTest> purposeOfTests);

    @Insert
    void insertPurposeOfTests(PurposeOfTest purposeOfTest);

    @Query("DELETE FROM PurposeOfTest")
    void deletePurposeOfTests();

    @Query("SELECT * FROM PurposeOfTest")
    List<PurposeOfTest> getAllPurposeOfTest();

    @Query("SELECT * FROM PurposeOfTest WHERE code=:id")
    PurposeOfTest findPurposeOfTestsById(String id);

    @Query("SELECT * FROM PurposeOfTest WHERE name=:name")
    PurposeOfTest findPurposeOfTestByName(String name);

}