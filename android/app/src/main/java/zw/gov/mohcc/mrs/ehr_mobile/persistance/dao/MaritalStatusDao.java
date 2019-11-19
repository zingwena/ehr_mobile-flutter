package zw.gov.mohcc.mrs.ehr_mobile.persistance.dao;

import androidx.room.Dao;
import androidx.room.Insert;
import androidx.room.Query;

import java.util.List;

import zw.gov.mohcc.mrs.ehr_mobile.model.terminology.MaritalStatus;

@Dao
public interface MaritalStatusDao {

    @Insert
    void insertMaritalStates(List<MaritalStatus> maritalStatuses);

    @Query("DELETE FROM maritalstatus")
    void deleteMaritalStatuses();

    @Insert
    void insertMAritalState(MaritalStatus maritalStatus);

    @Query("SELECT * FROM MaritalStatus ")
    List<MaritalStatus> getAllMaritalStates();

    @Query("SELECT * FROM MaritalStatus WHERE code=:id")
    MaritalStatus findMaritalStateById(String id);

    @Query("SELECT name FROM maritalstatus WHERE code=:code")
    String getMaritalStatusNameByCode(String code);
}
