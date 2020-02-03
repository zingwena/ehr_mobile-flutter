package zw.gov.mohcc.mrs.ehr_mobile.converter;

import androidx.room.TypeConverter;

import zw.gov.mohcc.mrs.ehr_mobile.enumeration.RelationshipType;

public class RelationshipTypeConverter {
    @TypeConverter
    public static RelationshipType toRelationshipType(String relationshipType) {

        if (relationshipType == null) {
            return null;
        }
        if (relationshipType.equals(RelationshipType.CHILD.getRelationshipType())) {
            return RelationshipType.CHILD;
        } else if (relationshipType.equals(RelationshipType.PARENT.getRelationshipType())) {
            return RelationshipType.PARENT;
        } else if (relationshipType.equals(RelationshipType.SPOUSE.getRelationshipType())) {
            return RelationshipType.SPOUSE;
        } else if (relationshipType.equals(RelationshipType.SIBLING.getRelationshipType())) {
            return RelationshipType.SIBLING;
        } else if (relationshipType.equals(RelationshipType.SEXUAL_PARTNER.getRelationshipType())) {
            return RelationshipType.SEXUAL_PARTNER;
        } else if (relationshipType.equals(RelationshipType.OTHER.getRelationshipType())) {
            return RelationshipType.OTHER;
        } else {
            throw new IllegalArgumentException("Illegal parameter passed to method : " + relationshipType);
        }
    }

    @TypeConverter
    public static String toString(RelationshipType relationshipType) {
        if (relationshipType == null) {
            return null;
        }
        return relationshipType.getRelationshipType();
    }
}