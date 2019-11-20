package zw.gov.mohcc.mrs.ehr_mobile.enumeration;


public enum RelationshipType {
    CHILD(0), PARENT(1), SPOUSE(2), SIBLING(3), SEXUAL_PARTNER(4), OTHER(5);

    private final int relationshipType;

    RelationshipType(int relationshipType) {
        this.relationshipType = relationshipType;
    }

    public static RelationshipType get(String name) {
        switch (name) {
            case "CHILD":
                return CHILD;
            case "PARENT":
                return PARENT;
            case "SPOUSE":
                return SPOUSE;
            case "SIBLING":
                return SIBLING;
            case "SEXUAL_PARTNER":
                return SEXUAL_PARTNER;
            case "OTHER":
                return OTHER;

            default:
                throw new IllegalArgumentException("Unknown argument passes to method : " + name);
        }
    }

    public int getRelationshipType() {
        return relationshipType;
    }
}
