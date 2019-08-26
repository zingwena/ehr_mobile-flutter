package zw.gov.mohcc.mrs.ehr_mobile.persistance.dao;

import androidx.room.Dao;
import androidx.room.Insert;
import androidx.room.Query;

import java.util.List;

import zw.gov.mohcc.mrs.ehr_mobile.model.LaboratoryTest;

@Dao
public interface LaboratoryTestDao {

    @Insert
    void insertLaboratoryTests(List<LaboratoryTest> laboratoryTests);

    @Query("DELETE FROM LaboratoryTest")
    void deleteLaboratoryTests();

    @Insert
    void insertLaboratoryTest(LaboratoryTest laboratoryTest);

    @Query("SELECT * FROM EducationLevel ")
    List<LaboratoryTest> getLaboratoryTests();

    @Query("SELECT * FROM LaboratoryTest WHERE id=:id")
    LaboratoryTest findByLaboratoryTestId(int id);

}
