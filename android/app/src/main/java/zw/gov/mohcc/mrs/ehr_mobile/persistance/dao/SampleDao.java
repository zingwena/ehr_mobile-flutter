package zw.gov.mohcc.mrs.ehr_mobile.persistance.dao;

import androidx.room.Dao;
import androidx.room.Insert;
import androidx.room.Query;

import java.util.List;

import zw.gov.mohcc.mrs.ehr_mobile.model.terminology.Sample;

@Dao
public interface SampleDao {

    @Insert
    void saveAll(List<Sample> samples);

    @Query("DELETE FROM Sample")
    void deleteAll();

    @Insert
    void saveOne(Sample sample);

    @Query("SELECT * FROM Sample Order By name ASC")
    List<Sample> findAll();

    @Query("SELECT * FROM Sample WHERE code=:id")
    Sample findById(String id);


}
