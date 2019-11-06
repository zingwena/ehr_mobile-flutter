package zw.gov.mohcc.mrs.ehr_mobile.persistance.dao;

import androidx.room.Dao;
import androidx.room.Insert;
import androidx.room.Query;

import java.util.List;

import zw.gov.mohcc.mrs.ehr_mobile.model.DisclosureMethod;

@Dao
public interface DisclosureMethodDao {

    @Insert
    void save(DisclosureMethod disclosureMethod);

    @Query("DELETE FROM DisclosureMethod")
    void deleteALl();

    @Insert
    void saveAll(List<DisclosureMethod> disclosureMethods);

    @Query("SELECT * FROM DisclosureMethod ORDER BY name DESC")
    List<DisclosureMethod> findAll();
}
