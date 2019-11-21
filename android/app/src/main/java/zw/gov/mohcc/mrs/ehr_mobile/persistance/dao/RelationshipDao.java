package zw.gov.mohcc.mrs.ehr_mobile.persistance.dao;

import androidx.room.Dao;
import androidx.room.Insert;
import androidx.room.OnConflictStrategy;
import androidx.room.Query;
import androidx.room.RawQuery;
import androidx.room.Update;
import androidx.sqlite.db.SimpleSQLiteQuery;

import java.util.List;

import zw.gov.mohcc.mrs.ehr_mobile.dto.RelationshipViewDTO;
import zw.gov.mohcc.mrs.ehr_mobile.enumeration.Gender;
import zw.gov.mohcc.mrs.ehr_mobile.enumeration.RelationshipType;
import zw.gov.mohcc.mrs.ehr_mobile.model.hts.Hts;
import zw.gov.mohcc.mrs.ehr_mobile.model.person.Relationship;

@Dao
public interface RelationshipDao {


    @Insert
    void saveAll(List<Relationship> relationships);

    @Query("DELETE FROM Relationship")
    void deleteAll();


    @Insert
    void saveOne(Relationship relationship);

    @Query("SELECT p.id, p.firstName, p.lastName, r.relation  FROM Relationship r inner join Person p on p.id=r.memberId WHERE personId=:personId")
    List<RelationshipViewDTO> findByPersonId(String personId);

    @Query("SELECT * FROM Relationship WHERE personId=:personId and memberId=:memberId")
    Relationship findByPersonIdAndMemberId(String personId, String memberId);


    @Query("SELECT * FROM Relationship WHERE memberId=:memberId")
    List<Relationship> findByMemberId(String memberId);


    @Query("SELECT count(*) FROM Relationship WHERE personId=:personId and memberId=:memberId")
    int existsByPersonIdAndMemberId(String personId, String memberId);

    @Query("SELECT * FROM Relationship WHERE personId=:personId and relation=:relation")
    List<Relationship> findByPersonIdAndRelation(String personId, RelationshipType relation);

    @Query("SELECT * FROM Relationship WHERE memberId=:memberId and relation=:relation")
    List<Relationship> findByMemberIdAndRelation(String memberId, RelationshipType relation);

    @Query("SELECT r.* FROM Relationship r inner join Person p on p.id=r.memberId WHERE personId=:personId and memberId=:memberId and relation=:relation and p.sex=:memberSex")
    List<Relationship> findByPersonIdAndMemberAndRelationAndMemberSex(
            String personId, String memberId, RelationshipType relation, Gender memberSex);
}
