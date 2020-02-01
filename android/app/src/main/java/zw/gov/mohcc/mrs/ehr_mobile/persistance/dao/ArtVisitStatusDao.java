package zw.gov.mohcc.mrs.ehr_mobile.persistance.dao;

import androidx.room.Dao;
import androidx.room.Insert;
import androidx.room.Query;

import java.util.List;

import zw.gov.mohcc.mrs.ehr_mobile.model.terminology.ArtVisitStatus;

@Dao
public interface ArtVisitStatusDao {

    @Insert
    void saveAll(List<ArtVisitStatus> artVisitStatuses);

    @Query("DELETE FROM ArtVisitStatus")
    void deleteAll();

    @Insert
    void saveOne(ArtVisitStatus artVisitStatus);

    @Query("SELECT * FROM ArtVisitStatus Order By name ASC")
    List<ArtVisitStatus> findAll();

    @Query("SELECT * FROM ArtVisitStatus WHERE code=:code")
    ArtVisitStatus findById(String code);

}
