package zw.gov.mohcc.mrs.ehr_mobile.persistance.dao;

import androidx.room.Dao;
import androidx.room.Insert;
import androidx.room.Query;

import java.util.List;

import zw.gov.mohcc.mrs.ehr_mobile.model.terminology.LaboratoryTest;

@Dao
public interface LaboratoryTestDao {

    @Insert
    void saveAll(List<LaboratoryTest> laboratoryTests);

    @Query("DELETE FROM LaboratoryTest")
    void deleteAll();

    @Insert
    void saveOne(LaboratoryTest laboratoryTest);

    @Query("SELECT * FROM LaboratoryTest WHERE code=:id")
    LaboratoryTest findById(String id);

    @Query("SELECT * FROM LaboratoryTest Order By name ASC")
    List<LaboratoryTest>  findAll();

}
