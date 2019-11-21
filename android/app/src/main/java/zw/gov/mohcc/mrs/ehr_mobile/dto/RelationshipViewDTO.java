package zw.gov.mohcc.mrs.ehr_mobile.dto;

import zw.gov.mohcc.mrs.ehr_mobile.enumeration.RelationshipType;
import zw.gov.mohcc.mrs.ehr_mobile.enumeration.TypeOfContact;

public class RelationshipViewDTO {

    private String personId;
    private String firstName;
    private String lastName;
    private RelationshipType relation;

    public RelationshipViewDTO(String personId, String firstName, String lastName, RelationshipType relation) {
        this.personId = personId;
        this.firstName = firstName;
        this.lastName = lastName;
        this.relation = relation;
    }

    public String getPersonId() {
        return personId;
    }

    public void setPersonId(String personId) {
        this.personId = personId;
    }

    public String getFirstName() {
        return firstName;
    }

    public void setFirstName(String firstName) {
        this.firstName = firstName;
    }

    public String getLastName() {
        return lastName;
    }

    public void setLastName(String lastName) {
        this.lastName = lastName;
    }

    public RelationshipType getRelation() {
        return relation;
    }

    public void setRelation(RelationshipType relation) {
        this.relation = relation;
    }
}
