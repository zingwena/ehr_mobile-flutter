package zw.gov.mohcc.mrs.ehr_mobile.persistance.dao;

import androidx.room.Dao;
import androidx.room.Insert;
import androidx.room.Query;

import java.util.List;

import zw.gov.mohcc.mrs.ehr_mobile.model.Investigation;

@Dao
public interface InvestigationDao {

    @Insert
    void insertInvestigations(List<Investigation> investigations);

    @Query("DELETE FROM Investigation")
    void deleteInvestigations();

    @Insert
    void insertInvestigation(Investigation investigation);

    @Query("SELECT * FROM Investigation")
    List<Investigation> getInvestigations();

    @Query("SELECT * FROM Investigation WHERE id=:investigationId")
    Investigation findByInvestigationId(String investigationId);

    @Query("SELECT * FROM Investigation WHERE laboratoryTestId=:laboratoryTestId and sampleId =:sampleId")
    Investigation findByLaboratoryTestIdAndSampleId(String laboratoryTestId, String sampleId);

}
