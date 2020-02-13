package zw.gov.mohcc.mrs.ehr_mobile.persistance.dao;


import androidx.room.Dao;
import androidx.room.Insert;
import androidx.room.Query;
import androidx.room.Update;

import java.util.List;

import zw.gov.mohcc.mrs.ehr_mobile.model.laboratory.LaboratoryInvestigation;

@Dao
public interface LaboratoryInvestigationDao {


    @Insert
    void save(LaboratoryInvestigation laboratoryInvestigation);

    @Update
    void update(LaboratoryInvestigation laboratoryInvestigation);

    @Query("SELECT * FROM laboratoryinvestigation")
    List<LaboratoryInvestigation> findAll();

    @Query("SELECT * from laboratoryinvestigation WHERE id=:id")
    LaboratoryInvestigation findById(String id);

    @Query("SELECT * from laboratoryinvestigation WHERE personInvestigationId=:personInvestigationId")
    LaboratoryInvestigation findByPersonInvestigationId(String personInvestigationId);

    @Query("DELETE FROM LaboratoryInvestigation")
    void deleteAll();
}
