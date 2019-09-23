package zw.gov.mohcc.mrs.ehr_mobile.persistance.dao;

import androidx.room.Dao;
import androidx.room.Insert;
import androidx.room.Query;

import java.util.List;

import zw.gov.mohcc.mrs.ehr_mobile.model.Investigation;
import zw.gov.mohcc.mrs.ehr_mobile.model.InvestigationResult;

@Dao
public interface InvestigationResultDao {

    @Insert
    void insertAll(List<InvestigationResult> investigationResults);

    @Query("DELETE FROM InvestigationResult")
    void delete();

    @Insert
    void insertOne(InvestigationResult investigationResult);

    @Query("SELECT * FROM InvestigationResult")
    List<InvestigationResult> getInvestigationResults();

    @Query("SELECT * FROM InvestigationResult WHERE id=:investigationResultId")
    InvestigationResult findById(String investigationResultId);

    @Query("SELECT * FROM InvestigationResult WHERE investigationId=:investigationId")
    Investigation findByInvestigationId(String investigationId);

}