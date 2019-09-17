package zw.gov.mohcc.mrs.ehr_mobile.persistance.dao;

import androidx.room.Dao;
import androidx.room.Insert;
import androidx.room.Query;

import java.util.List;

import zw.gov.mohcc.mrs.ehr_mobile.model.Sample;

@Dao
public interface SampleDao {

    @Insert
    void insertSamples(List<Sample> samples);

    @Query("DELETE FROM Sample")
    void deleteSamples();

    @Insert
    void insertSample(Sample sample);

    @Query("SELECT * FROM EducationLevel ")
    List<Sample> getSamples();


    @Query("SELECT * FROM Sample WHERE code=:id")
    Sample findBySampleId(String id);


}
