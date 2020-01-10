package zw.gov.mohcc.mrs.ehr_mobile.persistance.dao;

import androidx.room.Dao;
import androidx.room.Insert;
import androidx.room.Query;

import java.util.List;

import zw.gov.mohcc.mrs.ehr_mobile.model.terminology.MaritalStatus;

@Dao
public interface MaritalStatusDao {

    @Insert
    void saveAll(List<MaritalStatus> maritalStatuses);

    @Query("DELETE FROM maritalstatus")
    void deleteALl();

    @Insert
    void saveOne(MaritalStatus maritalStatus);

    @Query("SELECT * FROM MaritalStatus Order By name ASC")
    List<MaritalStatus> findAll();

    @Query("SELECT * FROM MaritalStatus WHERE code=:id")
    MaritalStatus findById(String id);
}
