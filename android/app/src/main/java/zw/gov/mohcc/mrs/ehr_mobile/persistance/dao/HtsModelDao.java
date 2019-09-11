package zw.gov.mohcc.mrs.ehr_mobile.persistance.dao;

import androidx.room.Dao;
import androidx.room.Insert;
import androidx.room.Query;

import java.util.List;

import zw.gov.mohcc.mrs.ehr_mobile.model.HtsModel;


@Dao
public interface HtsModelDao {

    @Insert
    void insertHtsModels(List<HtsModel> htsModels);

    @Query("DELETE FROM HtsModel")
    void deleteHtsModels();

    @Insert
    void insertHtsModel(HtsModel htsModel);

    @Query("SELECT * FROM HtsModel ORDER BY name ASC")
    List<HtsModel> getAllHtsModels();

    @Query("SELECT * FROM HtsModel WHERE code=:code")
    HtsModel findHtsModelById(String code);

}
