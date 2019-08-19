package zw.gov.mohcc.mrs.ehr_mobile.persistance.dao;

import androidx.room.Dao;
import androidx.room.Insert;
import androidx.room.Query;

import java.util.List;

import zw.gov.mohcc.mrs.ehr_mobile.model.Occupation;
import zw.gov.mohcc.mrs.ehr_mobile.model.Purpose_Of_Tests;


@Dao
public interface Purpose_Of_TestsDao {

    @Insert
    void insertPurpose_Of_Tests(List<Purpose_Of_Tests> purpose_of_tests);

    @Insert
    void insertPurpose_Of_Tests(Purpose_Of_Tests purpose_of_tests);

    @Query("DELETE FROM occupation")
    void deletePurpose_Of_Tests();

    @Query("SELECT * FROM Purpose_Of_Tests")
    List<Purpose_Of_Tests> getAllPurpose_Of_Tests();

    @Query("SELECT * FROM Purpose_Of_Tests WHERE id=:id")
    Purpose_Of_Tests findPurpose_Of_TestsById(int id);

}
