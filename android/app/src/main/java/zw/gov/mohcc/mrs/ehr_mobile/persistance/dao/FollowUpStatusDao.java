package zw.gov.mohcc.mrs.ehr_mobile.persistance.dao;

import androidx.room.Dao;
import androidx.room.Insert;
import androidx.room.Query;

import java.util.List;

import zw.gov.mohcc.mrs.ehr_mobile.model.terminology.FollowUpStatus;


@Dao
public interface FollowUpStatusDao {

    @Insert
    void saveAll(List<FollowUpStatus> followUpStatuses);

    @Query("DELETE FROM FollowUpStatus")
    void deleteAll();

    @Insert
    void saveOne(FollowUpStatus followUpStatus);

    @Query("SELECT * FROM FollowUpStatus ORDER BY name ASC")
    List<FollowUpStatus> findAll();

    @Query("SELECT * FROM FollowUpStatus WHERE code=:code")
    FollowUpStatus findById(String code);

}
