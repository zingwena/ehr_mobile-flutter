package zw.gov.mohcc.mrs.ehr_mobile.enumeration;


public enum RelationshipType {
    CHILD("CHILD"), PARENT("PARENT"), SPOUSE("SPOUSE"), SIBLING("SIBLING"), SEXUAL_PARTNER("SEXUAL_PARTNER"), OTHER("OTHER");

    private final String relationshipType;

    RelationshipType(String relationshipType) {
        this.relationshipType = relationshipType;
    }

    public static RelationshipType get(String name) {

        for (RelationshipType item : values()) {
            if (item.getRelationshipType().equals(name)) {
                return item;
            }
        }
        throw new IllegalArgumentException("Unknown argument passes to method : " + name);
    }

    public String getRelationshipType() {
        return relationshipType;
    }
}
