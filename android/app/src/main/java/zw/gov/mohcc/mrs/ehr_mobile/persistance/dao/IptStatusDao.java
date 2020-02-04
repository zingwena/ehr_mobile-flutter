package zw.gov.mohcc.mrs.ehr_mobile.persistance.dao;

import androidx.room.Dao;
import androidx.room.Insert;
import androidx.room.Query;

import java.util.List;

import zw.gov.mohcc.mrs.ehr_mobile.model.terminology.IptStatus;

@Dao
public interface IptStatusDao {

    @Insert
    void saveOne(IptStatus iptStatus);

    @Query("DELETE FROM IptStatus")
    void deleteAll();

    @Insert
    void saveAll(List<IptStatus> iptStatuses);

    @Query("SELECT * FROM IptStatus ORDER BY name DESC")
    List<IptStatus> findAll();

    @Query("SELECT * FROM IptStatus Where code=:code")
    IptStatus findById(String code);
}
