package zw.gov.mohcc.mrs.ehr_mobile.persistance.dao;

import androidx.room.Dao;
import androidx.room.Insert;
import androidx.room.Query;

import java.util.List;

import zw.gov.mohcc.mrs.ehr_mobile.model.IndexContact;
import zw.gov.mohcc.mrs.ehr_mobile.model.IndexTest;


@Dao
public interface IndexContactDao {

    @Insert
    void saveAll(List<IndexContact> indexContacts);

    @Query("DELETE FROM IndexContact")
    void deleteAll();

    @Insert
    void saveOne(IndexContact indexContact);

    @Query("SELECT * FROM IndexContact Where personId=:personId")
    List<IndexContact> findByPersonId(String personId);

    @Query("SELECT * FROM IndexContact Where indexTestId=:indexTestId")
    List<IndexContact> findByIndexTestId(String indexTestId);

    @Query("SELECT * FROM IndexContact WHERE id=:id")
    IndexContact findById(String id);

}
