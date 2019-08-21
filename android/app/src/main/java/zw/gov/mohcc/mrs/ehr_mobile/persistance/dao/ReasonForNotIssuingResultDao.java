package zw.gov.mohcc.mrs.ehr_mobile.persistance.dao;

import androidx.room.Dao;
import androidx.room.Insert;
import androidx.room.Query;

import java.util.List;

import zw.gov.mohcc.mrs.ehr_mobile.model.EntryPoint;
import zw.gov.mohcc.mrs.ehr_mobile.model.ReasonForNotIssuingResult;


@Dao
public interface ReasonForNotIssuingResultDao {

    @Insert
    void insertReasonForNotIssuingResults(List<ReasonForNotIssuingResult> reasonForNotIssuingResults);

    @Query("DELETE FROM reasonForNotIssuingResult")
    void deleteReasonForNotIssuingResults();

    @Insert
    void insertReasonForNotIssuingResult(ReasonForNotIssuingResult reasonForNotIssuingResult);

    @Query("SELECT * FROM ReasonForNotIssuingResult ORDER BY name ASC")
    List<ReasonForNotIssuingResult> getAllReasonForNotIssuingResults();

    @Query("SELECT * FROM ReasonForNotIssuingResult WHERE id=:id")
    EntryPoint findReasonForNotIssuingResultById(int id);

}