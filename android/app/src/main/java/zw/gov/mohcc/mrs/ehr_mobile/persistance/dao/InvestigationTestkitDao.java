package zw.gov.mohcc.mrs.ehr_mobile.persistance.dao;

import androidx.room.Dao;
import androidx.room.Insert;
import androidx.room.Query;

import java.util.List;

import zw.gov.mohcc.mrs.ehr_mobile.model.terminology.InvestigationTestkit;
import zw.gov.mohcc.mrs.ehr_mobile.model.terminology.TestKit;

@Dao
public interface InvestigationTestkitDao {

    @Insert
    void saveAll(List<InvestigationTestkit> investigationTestkits);

    @Query("DELETE FROM InvestigationTestkit")
    void deleteAll();

    @Insert
    void saveOne(InvestigationTestkit investigationTestkit);

    @Query("SELECT * FROM InvestigationTestkit")
    List<InvestigationTestkit> findAll();

    @Query("SELECT t.* FROM InvestigationTestkit i inner join TestKit t on t.code=i.testKitId WHERE i.investigationId=:investigationId")
    List<TestKit> findByInvestigationId(String investigationId);

}
