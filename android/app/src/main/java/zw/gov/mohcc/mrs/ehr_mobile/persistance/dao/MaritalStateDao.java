package zw.gov.mohcc.mrs.ehr_mobile.persistance.dao;

import androidx.room.Dao;
import androidx.room.Insert;
import androidx.room.Query;

import zw.gov.mohcc.mrs.ehr_mobile.model.MaritalState;

import java.util.List;

@Dao
public interface MaritalStateDao {

    @Insert
    void insertMaritalStates(List<MaritalState> maritalStates);

    @Insert
    void insertMAritalState(MaritalState maritalState);

    @Query("SELECT * FROM maritalstate")
    List<MaritalState> getAllMaritalStates();

    @Query("SELECT * FROM maritalstate WHERE id=:id")
    MaritalState findMaritalStateById(int id);
}
