package zw.gov.mohcc.mrs.ehr_mobile.persistance.dao;

import androidx.room.Dao;
import androidx.room.Delete;
import androidx.room.Insert;
import androidx.room.Query;

import java.util.List;

import zw.gov.mohcc.mrs.ehr_mobile.model.Authorities;

@Dao
public interface AuthoritiesDao {
    @Insert
    void insertAuthority(Authorities authority);

    @Insert
    void insertAuthorities(List<Authorities> authorities);

    @Delete
    void delete(Authorities authority);

    @Query("DELETE FROM authorities")
    void deleteAuthorities();

    @Query("SELECT * FROM authorities")
    List<Authorities> getAllAuthorities();

    @Query("SELECT * FROM Authorities WHERE userId=:userId")
    List<Authorities> findAuthoritiesByUserId(final int userId);
}
