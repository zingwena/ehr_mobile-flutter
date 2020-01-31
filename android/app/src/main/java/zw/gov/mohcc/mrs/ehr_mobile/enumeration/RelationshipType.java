package zw.gov.mohcc.mrs.ehr_mobile.enumeration;


public enum RelationshipType {
    CHILD("CHILD"), PARENT("PARENT"), SPOUSE("SPOUSE"), SIBLING("SIBLING"), SEXUAL_PARTNER("SEXUAL_PARTNER"), OTHER("OTHER");

    private final String relationshipType;

    RelationshipType(String relationshipType) {
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

    public String getRelationshipType() {
        return relationshipType;
    }
}
