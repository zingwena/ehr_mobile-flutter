package zw.gov.mohcc.mrs.ehr_mobile.persistance.dao;

import androidx.room.Dao;
import androidx.room.Insert;
import androidx.room.Query;

import java.util.List;

import zw.gov.mohcc.mrs.ehr_mobile.model.LaboratoryInvestigationTest;
@Dao
public interface LaboratoryInvestigationTestDao {


    @Insert
    void insertLaboratoryInvestTests(List<LaboratoryInvestigationTest> laboratoryInvestTests);

    @Query("DELETE FROM LaboratoryInvestigationTest")
    void deleteLaboratoryInvestTests();

    @Insert
    Long insertLaboratoryInvestTest(LaboratoryInvestigationTest laboratoryInvestTest);

    @Query("SELECT * FROM LaboratoryInvestigationTest ")
    List<LaboratoryInvestigationTest> getLaboratoryInvestTests();

    @Query("SELECT * FROM LaboratoryInvestigationTest WHERE id=:id")
    LaboratoryInvestigationTest findByLaboratoryInvestTestId(String id);

    @Query("SELECT * FROM LaboratoryInvestigationTest ")
    List<LaboratoryInvestigationTest>  findAll();
}
