package zw.gov.mohcc.mrs.ehr_mobile.persistance.dao;

import androidx.room.Dao;
import androidx.room.Insert;
import androidx.room.Query;

import java.util.List;

import zw.gov.mohcc.mrs.ehr_mobile.model.terminology.FollowUpOutcome;

@Dao
public interface FollowupOutcomeDao {

    @Insert
    void saveOne(FollowUpOutcome followUpOutcome);

    @Query("DELETE FROM FollowupOutcome")
    void deleteAll();

    @Insert
    void saveAll(List<FollowUpOutcome> followupOutcomes);

    @Query("SELECT * FROM FollowupOutcome ORDER BY name DESC")
    List<FollowUpOutcome> findAll();
}
