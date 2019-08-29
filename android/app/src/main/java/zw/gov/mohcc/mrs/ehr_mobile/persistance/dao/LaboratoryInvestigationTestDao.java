package zw.gov.mohcc.mrs.ehr_mobile.persistance.dao;

import androidx.room.Insert;
import androidx.room.Query;

import java.util.List;

import zw.gov.mohcc.mrs.ehr_mobile.model.LaboratoryInvestigationTest;

public interface LaboratoryInvestigationTestDao {


    @Insert
    void insertLaboratoryInvestTests(List<LaboratoryInvestigationTest> laboratoryInvestTests);

    @Query("DELETE FROM LaboratoryInvestigationTest")
    void deleteLaboratoryInvestTests();

    @Insert
    void insertLaboratoryInvestTest(LaboratoryInvestigationTest laboratoryInvestTest);

    @Query("SELECT * FROM LaboratoryInvestigationTest ")
    List<LaboratoryInvestigationTest> getLaboratoryInvestTests();

    @Query("SELECT * FROM LaboratoryInvestigationTest WHERE id=:id")
    LaboratoryInvestigationTest findByLaboratoryInvestTestId(int id);
    @Query("SELECT * FROM LaboratoryInvestigationTest ")
    List<LaboratoryInvestigationTest>  findAll();
}
