package zw.gov.mohcc.mrs.ehr_mobile.persistance.dao;

import androidx.room.Dao;
import androidx.room.Insert;
import androidx.room.Query;

import java.util.List;

import zw.gov.mohcc.mrs.ehr_mobile.model.PurposeOfTest;


@Dao
public interface PurposeOfTestDao {

    @Insert
    void insertPurpose_Of_Tests(List<PurposeOfTest> purpose_of_tests);

    @Insert
    void insertPurpose_Of_Tests(PurposeOfTest purpose_of_test);

    @Query("DELETE FROM occupation")
    void deletePurpose_Of_Tests();

    @Query("SELECT * FROM PurposeOfTest")
    List<PurposeOfTest> getAllPurpose_Of_Tests();

    @Query("SELECT * FROM PurposeOfTest WHERE id=:id")
    PurposeOfTest findPurpose_Of_TestsById(int id);

}
