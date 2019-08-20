package zw.gov.mohcc.mrs.ehr_mobile.persistance.dao;

import androidx.room.Dao;
import androidx.room.Insert;
import androidx.room.Query;

import java.util.List;

import zw.gov.mohcc.mrs.ehr_mobile.model.EntryPoint;
import zw.gov.mohcc.mrs.ehr_mobile.model.Occupation;


@Dao
public interface EntryPointDao {

    @Insert
    void insertEntryPoints(List<EntryPoint> entryPoints);

    @Query("DELETE FROM entryPoint")
    void deleteEntryPoints();

    @Insert
    void insertEntryPoint(EntryPoint entryPoint);

    @Query("SELECT * FROM EntryPoint ORDER BY name ASC")
    List<EntryPoint> getAllEntryPoints();

    @Query("SELECT * FROM EntryPoint WHERE id=:id")
    EntryPoint findEntryPointById(int id);

}
