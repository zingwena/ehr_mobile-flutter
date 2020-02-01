package zw.gov.mohcc.mrs.ehr_mobile.persistance.dao;

import androidx.room.Dao;
import androidx.room.Insert;
import androidx.room.Query;

import java.util.List;

import zw.gov.mohcc.mrs.ehr_mobile.model.terminology.ArtVisitType;

@Dao
public interface ArtVisitTypeDao {

    @Insert
    void saveAll(List<ArtVisitType> artVisitTypes);

    @Query("DELETE FROM ArtVisitType")
    void deleteAll();

    @Insert
    void saveOne(ArtVisitType artVisitType);

    @Query("SELECT * FROM ArtVisitType Order By name ASC")
    List<ArtVisitType> findAll();

    @Query("SELECT * FROM ArtVisitType WHERE code=:code")
    ArtVisitType findById(String code);

}
