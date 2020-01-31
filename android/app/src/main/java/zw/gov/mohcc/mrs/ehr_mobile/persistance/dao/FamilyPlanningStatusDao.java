package zw.gov.mohcc.mrs.ehr_mobile.persistance.dao;

import androidx.room.Dao;
import androidx.room.Insert;
import androidx.room.Query;

import java.util.List;

import zw.gov.mohcc.mrs.ehr_mobile.model.terminology.FamilyPlanningStatus;


@Dao
public interface FamilyPlanningStatusDao {

    @Insert
    void saveAll(List<FamilyPlanningStatus> familyPlanningStatuses);

    @Query("DELETE FROM FamilyPlanningStatus")
    void deleteAll();

    @Insert
    void saveOne(FamilyPlanningStatus familyPlanningStatus);

    @Query("SELECT * FROM FamilyPlanningStatus ORDER BY name ASC")
    List<FamilyPlanningStatus> findAll();

    @Query("SELECT * FROM FamilyPlanningStatus WHERE code=:code")
    FamilyPlanningStatus findById(String code);

}
