package zw.gov.mohcc.mrs.ehr_mobile.persistance.dao;

import androidx.room.Dao;
import androidx.room.Insert;
import androidx.room.Query;

import java.util.List;

import zw.gov.mohcc.mrs.ehr_mobile.model.terminology.FollowUpReason;

@Dao
public interface FollowUpReasonDao {

    @Insert
    void saveOne(FollowUpReason followUpReason);

    @Query("DELETE FROM FollowUpReason")
    void deleteAll();

    @Insert
    void saveAll(List<FollowUpReason> followUpReasons);

    @Query("SELECT * FROM FollowUpReason ORDER BY name DESC")
    List<FollowUpReason> findAll();
}
