package zw.gov.mohcc.mrs.ehr_mobile.persistance.dao;

import androidx.room.Dao;
import androidx.room.Insert;
import androidx.room.Query;

import java.util.List;

import zw.gov.mohcc.mrs.ehr_mobile.model.terminology.HtsModel;


@Dao
public interface HtsModelDao {

    @Insert
    void saveAll(List<HtsModel> htsModels);

    @Query("DELETE FROM HtsModel")
    void deleteAll();

    @Insert
    void saveOne(HtsModel htsModel);

    @Query("SELECT * FROM HtsModel ORDER BY name ASC")
    List<HtsModel> findAll();

    @Query("SELECT * FROM HtsModel WHERE code=:code")
    HtsModel findById(String code);

    @Query("SELECT * FROM HtsModel where name=:name")
    HtsModel findByname(String name);

}
