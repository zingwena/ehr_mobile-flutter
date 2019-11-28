package zw.gov.mohcc.mrs.ehr_mobile.persistance.dao;

import androidx.room.Dao;
import androidx.room.Insert;
import androidx.room.Query;

import java.util.List;

import zw.gov.mohcc.mrs.ehr_mobile.enumeration.AgeGroup;
import zw.gov.mohcc.mrs.ehr_mobile.enumeration.RegimenType;
import zw.gov.mohcc.mrs.ehr_mobile.model.terminology.ArvCombinationRegimen;


@Dao
public interface ArvCombinationRegimenDao {

    @Insert
    void insertAll(List<ArvCombinationRegimen> arvCombinationRegimens);

    @Insert
    void insertOne(ArvCombinationRegimen arvCombinationRegimen);

    @Query("DELETE FROM ArvCombinationRegimen")
    void deleteAll();

    @Query("SELECT * FROM ArvCombinationRegimen")
    List<ArvCombinationRegimen> findAll();

    @Query("SELECT * FROM ArvCombinationRegimen WHERE code=:id")
    ArvCombinationRegimen findById(String id);

    @Query("SELECT * FROM ArvCombinationRegimen WHERE name=:name")
    ArvCombinationRegimen findByName(String name);

    @Query("SELECT * FROM ArvCombinationRegimen WHERE regimenType =:regimenType and ageGroup=:ageGroup")
    List<ArvCombinationRegimen> findByLineAndAgeGrouprion(RegimenType regimenType, AgeGroup ageGroup);
}
