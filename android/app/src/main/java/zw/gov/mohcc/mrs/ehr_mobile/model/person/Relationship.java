package zw.gov.mohcc.mrs.ehr_mobile.model.person;

import androidx.annotation.NonNull;
import androidx.room.Entity;
import androidx.room.ForeignKey;
import androidx.room.Ignore;
import androidx.room.Index;
import androidx.room.TypeConverters;

import zw.gov.mohcc.mrs.ehr_mobile.converter.TypeOfContactConverter;
import zw.gov.mohcc.mrs.ehr_mobile.enumeration.RelationshipType;
import zw.gov.mohcc.mrs.ehr_mobile.enumeration.TypeOfContact;
import zw.gov.mohcc.mrs.ehr_mobile.model.BaseEntity;
import zw.gov.mohcc.mrs.ehr_mobile.converter.RelationshipTypeConverter;

import static androidx.room.ForeignKey.CASCADE;

@Entity(indices = {@Index(value = "personId"), @Index(value = "memberId")},
foreignKeys = {@ForeignKey(entity = Person.class, onDelete = CASCADE,
        parentColumns = "id",
        childColumns = "personId"),
        @ForeignKey(entity = Person.class, onDelete = CASCADE,
                parentColumns = "id",
                childColumns = "memberId")})
public class Relationship extends BaseEntity {

    @NonNull
    private String personId;
    @NonNull
    private String memberId;
    @TypeConverters(RelationshipTypeConverter.class)
    @NonNull
    private RelationshipType relation;
    @TypeConverters(TypeOfContactConverter.class)
    private TypeOfContact typeOfContact;

    public Relationship() {
    }

    @Ignore
    public Relationship(@NonNull String id, @NonNull String personId, @NonNull String memberId, @NonNull RelationshipType relation, TypeOfContact typeOfContact) {
        super(id);
        this.personId = personId;
        this.memberId = memberId;
        this.relation = relation;
        this.typeOfContact = typeOfContact;
    }

    @NonNull
    public String getPersonId() {
        return personId;
    }

    public void setPersonId(@NonNull String personId) {
        this.personId = personId;
    }

    @NonNull
    public String getMemberId() {
        return memberId;
    }

    public void setMemberId(@NonNull String memberId) {
        this.memberId = memberId;
    }

    @NonNull
    public RelationshipType getRelation() {
        return relation;
    }

    public void setRelation(@NonNull RelationshipType relation) {
        this.relation = relation;
    }

    public TypeOfContact getTypeOfContact() {
        return typeOfContact;
    }

    public void setTypeOfContact(TypeOfContact typeOfContact) {
        this.typeOfContact = typeOfContact;
    }

    @Override
    public String toString() {
        return "Relationship{" +
                "id='" + getId() + '\'' +
                "personId='" + personId + '\'' +
                ", memberId='" + memberId + '\'' +
                ", relation=" + relation +
                ", typeOfContact=" + typeOfContact +
                '}';
    }
}
