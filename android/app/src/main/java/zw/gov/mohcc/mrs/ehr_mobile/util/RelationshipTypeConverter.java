package zw.gov.mohcc.mrs.ehr_mobile.util;

import androidx.room.TypeConverter;

import zw.gov.mohcc.mrs.ehr_mobile.model.RelationshipType;

public class RelationshipTypeConverter {
    @TypeConverter
    public static RelationshipType toRelationshipType(int relationshipType) {

        if (relationshipType == RelationshipType.CHILD.getRelationshipType()) {
            return RelationshipType.CHILD;
        } else if (relationshipType == RelationshipType.PARENT.getRelationshipType()) {
            return RelationshipType.PARENT;
        } else if (relationshipType == RelationshipType.SPOUSE.getRelationshipType()) {
            return RelationshipType.SPOUSE;
        } else if (relationshipType == RelationshipType.SIBLING.getRelationshipType()) {
            return RelationshipType.SIBLING;
        } else if (relationshipType == RelationshipType.SEXUAL_PARTNER.getRelationshipType()) {
            return RelationshipType.SEXUAL_PARTNER;
        } else if (relationshipType == RelationshipType.OTHER.getRelationshipType()) {
            return RelationshipType.OTHER;
        } else {
            throw new IllegalArgumentException("Illegal parameter passed to method : " + relationshipType);
        }
    }

    @TypeConverter
    public static int toInt(RelationshipType relationshipType) {
        return relationshipType.getRelationshipType();
    }
}