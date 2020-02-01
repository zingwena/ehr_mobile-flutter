package zw.gov.mohcc.mrs.ehr_mobile.persistance.dao;

import androidx.room.Dao;
import androidx.room.Insert;
import androidx.room.Query;

import java.util.List;

import zw.gov.mohcc.mrs.ehr_mobile.model.terminology.ArtVisitStatus;
import zw.gov.mohcc.mrs.ehr_mobile.model.terminology.IptReason;

@Dao
public interface IptReasonDao {

    @Insert
    void saveAll(List<IptReason> iptReasons);

    @Query("DELETE FROM IptReason")
    void deleteAll();

    @Insert
    void saveOne(IptReason iptReason);

    @Query("SELECT * FROM IptReason Order By name ASC")
    List<IptReason> findAll();

    @Query("SELECT * FROM IptReason WHERE code=:code")
    IptReason findById(String code);

}
