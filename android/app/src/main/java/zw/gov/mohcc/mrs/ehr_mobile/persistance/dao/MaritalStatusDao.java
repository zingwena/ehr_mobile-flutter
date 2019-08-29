package zw.gov.mohcc.mrs.ehr_mobile.persistance.dao;

import androidx.room.Dao;
import androidx.room.Insert;
import androidx.room.Query;

import zw.gov.mohcc.mrs.ehr_mobile.model.MaritalStatus;

import java.util.List;

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

    @Query("SELECT * FROM MaritalStatus WHERE id=:id")
    MaritalStatus findMaritalStateById(int id);

    @Query("SELECT name FROM maritalstatus WHERE code=:code")
    String getMaritalStatusNameByCode(String code);
}
