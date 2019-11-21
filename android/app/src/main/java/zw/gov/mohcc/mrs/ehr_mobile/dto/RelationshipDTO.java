package zw.gov.mohcc.mrs.ehr_mobile.dto;

import androidx.annotation.NonNull;
import androidx.room.TypeConverters;

import zw.gov.mohcc.mrs.ehr_mobile.converter.RelationshipTypeConverter;
import zw.gov.mohcc.mrs.ehr_mobile.converter.TypeOfContactConverter;
import zw.gov.mohcc.mrs.ehr_mobile.enumeration.RelationshipType;
import zw.gov.mohcc.mrs.ehr_mobile.enumeration.TypeOfContact;

public class RelationshipDTO {

    private String personId;

    private String memberId;

    private RelationshipType relation;

    private TypeOfContact typeOfContact;

    RelationshipDTO(String personId, String memberId, RelationshipType relation,
                    TypeOfContact typeOfContact){
        this.personId = personId;
        this.memberId = memberId;
        this.relation = relation;
        this.typeOfContact = typeOfContact;
    }

    public String getPersonId() {
        return personId;
    }

    public void setPersonId(String personId) {
        this.personId = personId;
    }

    public String getMemberId() {
        return memberId;
    }

    public void setMemberId(String memberId) {
        this.memberId = memberId;
    }

    public RelationshipType getRelation() {
        return relation;
    }

    public void setRelation( RelationshipType relation) {
        this.relation = relation;
    }

    public TypeOfContact getTypeOfContact() {
        return typeOfContact;
    }

    public void setTypeOfContact(TypeOfContact typeOfContact) {
        this.typeOfContact = typeOfContact;
    }
}
