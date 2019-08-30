package zw.gov.mohcc.mrs.ehr_mobile.persistance.dao;


import androidx.room.Dao;
import androidx.room.Insert;
import androidx.room.Query;

import java.util.List;

import zw.gov.mohcc.mrs.ehr_mobile.model.LaboratoryInvestigation;

@Dao
public interface LaboratoryInvestigationDao {


    @Insert
    void createLaboratoryInvestigation(LaboratoryInvestigation laboratoryInvestigation);

    @Query("SELECT * FROM laboratoryinvestigation")
    List<LaboratoryInvestigation> getAllLaboratoryInvestigations();

    @Query("SELECT * from laboratoryinvestigation WHERE id=:id")
    LaboratoryInvestigation findLaboratoryInvestigationById(int id);
}
