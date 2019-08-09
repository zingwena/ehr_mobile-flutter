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

    @Insert
    void insertMAritalState(MaritalStatus maritalStatus);

    @Query("SELECT * FROM MaritalStatus")
    List<MaritalStatus> getAllMaritalStates();

    @Query("SELECT * FROM MaritalStatus WHERE marital_status_id=:id")
    MaritalStatus findMaritalStateById(int id);
}
