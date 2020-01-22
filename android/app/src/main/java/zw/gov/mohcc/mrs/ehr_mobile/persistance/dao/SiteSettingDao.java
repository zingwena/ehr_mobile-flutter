package zw.gov.mohcc.mrs.ehr_mobile.persistance.dao;

import androidx.room.Dao;
import androidx.room.Insert;
import androidx.room.Query;
import androidx.room.Update;

import java.util.List;

import zw.gov.mohcc.mrs.ehr_mobile.model.terminology.SiteSetting;

@Dao
public interface SiteSettingDao {

    @Insert
    void saveOne(SiteSetting siteSetting);

    @Update
    void update(SiteSetting siteSetting);

    @Query("SELECT * FROM SiteSetting")
    List<SiteSetting> findAll();

    @Query("DELETE FROM SiteSetting")
    void deleteAll();

    @Query("SELECT * FROM SiteSetting WHERE id=:id")
    SiteSetting findById(String id);

    @Query("SELECT * FROM SiteSetting limit 1")
    SiteSetting findSiteSetting();
}
