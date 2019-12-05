package zw.gov.mohcc.mrs.ehr_mobile.service;


import android.util.Log;

import androidx.room.Transaction;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.UUID;

import zw.gov.mohcc.mrs.ehr_mobile.dto.RelationshipViewDTO;
import zw.gov.mohcc.mrs.ehr_mobile.enumeration.Gender;
import zw.gov.mohcc.mrs.ehr_mobile.enumeration.RelationshipType;
import zw.gov.mohcc.mrs.ehr_mobile.model.person.Relationship;
import zw.gov.mohcc.mrs.ehr_mobile.persistance.database.EhrMobileDatabase;

public class RelationshipService {

    private final String TAG = "Relationship Service";
    private EhrMobileDatabase ehrMobileDatabase;

    public RelationshipService(EhrMobileDatabase ehrMobileDatabase) {
        this.ehrMobileDatabase = ehrMobileDatabase;
    }

    public boolean relationshipExists(String personId, String memberId) {
        return ehrMobileDatabase.relationshipDao().existsByPersonIdAndMemberId(personId, memberId) >= 1;
    }

    public Relationship getRelationshipByPersonIdAndMemberId(String personId, String memberId) {
        return ehrMobileDatabase.relationshipDao().findByPersonIdAndMemberId(personId, memberId);
    }

    public List<RelationshipViewDTO> getPersonRelations(String personId) {
        return ehrMobileDatabase.relationshipDao().findByPersonId(personId);
    }

    public List<Relationship> getByPersonIdAndMemberIdRelationAndSex(String personId, String memberId,
                                                                     RelationshipType relation, Gender sex) {
        return ehrMobileDatabase.relationshipDao().findByPersonIdAndMemberAndRelationAndMemberSex(
                personId, memberId, relation, sex);
    }

    public RelationshipType getOpposiiteRelationshipType(Relationship relationship) {

        switch (relationship.getRelation()) {
            case CHILD:
                return RelationshipType.PARENT;
            case PARENT:
                return RelationshipType.CHILD;
            case SPOUSE:
                return RelationshipType.SPOUSE;
            case SIBLING:
                return RelationshipType.SIBLING;
            case OTHER:
                return RelationshipType.OTHER;
            default:
                throw new IllegalArgumentException("Illegal parameter passed to method ");
        }
    }

    @Transaction
    public String createRelationShip(Relationship relationship) {

        if (relationshipExists(relationship.getPersonId(), relationship.getMemberId())) {
            Log.i(TAG, "Relationship already exists for current person and member");
            return getRelationshipByPersonIdAndMemberId(relationship.getPersonId(), relationship.getMemberId()).getPersonId();
        }
        // add checks to ensure child only has one mother
        Log.d(TAG, "Checking that a child is assigned to only one mother");
        List<Relationship> relationships = getByPersonIdAndMemberIdRelationAndSex(relationship.getPersonId(),
                        relationship.getMemberId(), relationship.getRelation(), Gender.FEMALE);

        if (relationships != null && !relationships.isEmpty()) {
            Log.e(TAG, "Attempting to add child to more than 1 mother : operation failed ");

            throw new IllegalStateException("Child cannot have more than 1 mother");
        }

        Relationship person = null;

        Relationship member = null;

        RelationshipType memberType = getOpposiiteRelationshipType(relationship);

        if (!relationshipExists(relationship.getPersonId(), relationship.getMemberId())) {

            person = new Relationship(UUID.randomUUID().toString(), relationship.getPersonId(),
                    relationship.getMemberId(), relationship.getRelation(), relationship.getTypeOfContact());

            member = new Relationship(UUID.randomUUID().toString(), relationship.getMemberId(),
                    relationship.getPersonId(), memberType, null);
        }
        Relationship [] items = {person, member};
        ehrMobileDatabase.relationshipDao().saveAll(new ArrayList<>(Arrays.asList(items)));
        return person.getId();
    }
}
