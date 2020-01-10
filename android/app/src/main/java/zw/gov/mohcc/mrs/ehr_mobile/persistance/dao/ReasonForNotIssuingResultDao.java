package zw.gov.mohcc.mrs.ehr_mobile.persistance.dao;

import androidx.room.Dao;
import androidx.room.Insert;
import androidx.room.Query;

import java.util.List;

import zw.gov.mohcc.mrs.ehr_mobile.model.terminology.DisclosureMethod;
import zw.gov.mohcc.mrs.ehr_mobile.model.terminology.EntryPoint;
import zw.gov.mohcc.mrs.ehr_mobile.model.terminology.ReasonForNotIssuingResult;


@Dao
public interface ReasonForNotIssuingResultDao {

    @Insert
    void saveAll(List<ReasonForNotIssuingResult> reasonForNotIssuingResults);

    @Query("DELETE FROM reasonForNotIssuingResult")
    void deleteAll();

    @Insert
    void saveOne(ReasonForNotIssuingResult reasonForNotIssuingResult);

    @Query("SELECT * FROM ReasonForNotIssuingResult WHERE code=:id")
    EntryPoint findById(String id);

    @Query("SELECT * FROM ReasonForNotIssuingResult ORDER BY name DESC")
    List<ReasonForNotIssuingResult> findAll();
}
