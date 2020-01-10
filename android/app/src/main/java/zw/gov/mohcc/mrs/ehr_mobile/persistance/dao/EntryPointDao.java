package zw.gov.mohcc.mrs.ehr_mobile.persistance.dao;

import androidx.room.Dao;
import androidx.room.Insert;
import androidx.room.Query;

import java.util.List;

import zw.gov.mohcc.mrs.ehr_mobile.model.terminology.EntryPoint;


@Dao
public interface EntryPointDao {

    @Insert
    void saveAll(List<EntryPoint> entryPoints);

    @Query("DELETE FROM entryPoint")
    void deleteAll();

    @Insert
    void saveOne(EntryPoint entryPoint);

    @Query("SELECT * FROM EntryPoint ORDER BY name ASC")
    List<EntryPoint> findAll();

    @Query("SELECT * FROM EntryPoint WHERE code=:code")
    EntryPoint findById(String code);

}
