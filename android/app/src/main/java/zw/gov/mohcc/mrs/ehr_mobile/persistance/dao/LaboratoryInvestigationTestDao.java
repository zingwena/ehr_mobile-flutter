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

    @Query("SELECT * FROM LaboratoryInvestigationTest WHERE laboratoryInvestigationId=:id")
    LaboratoryInvestigationTest findByLaboratoryInvestId(String id);

    @Query("SELECT * FROM LaboratoryInvestigationTest ")
    List<LaboratoryInvestigationTest>  findAll();

    @Query("SELECT * FROM LaboratoryInvestigationTest WHERE visitId=:visitId")
    List<LaboratoryInvestigationTest> findAllByVisitId(String visitId);

    @Query("SELECT count(id) FROM LaboratoryInvestigationTest WHERE laboratoryInvestigationId=:laboratoryInvestigationId")
    int countByLaboratoryInvestigation(String laboratoryInvestigationId);

    @Query("SELECT * FROM LaboratoryInvestigationTest WHERE laboratoryInvestigationId=:laboratoryInvestigationId order by startTime ASC")
    List<LaboratoryInvestigationTest> findEarliestTests(String laboratoryInvestigationId);
}
