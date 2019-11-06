package zw.gov.mohcc.mrs.ehr_mobile.persistance.dao;

import androidx.room.Dao;
import androidx.room.Insert;
import androidx.room.Query;

import java.util.List;

import zw.gov.mohcc.mrs.ehr_mobile.model.TestingPlan;

@Dao
public interface TestingPlanDao {

    @Insert
    void save(TestingPlan testingPlan);

    @Query("DELETE FROM TestingPlan")
    void deleteALl();

    @Insert
    void saveAll(List<TestingPlan> testingPlans);

    @Query("SELECT * FROM TestingPlan ORDER BY name DESC")
    List<TestingPlan> findAll();
}
