package zw.gov.mohcc.mrs.ehr_mobile.enumeration;

public enum Line {

    FIRST_LINE(0),
    SECOND_LINE(1),
    THIRD_LINE(2);
    private final int line;


    private Line(int line) {
        this.line = line;
    }

    public int getLine() {
        return line;
    }

    public static Line get(String name){

        switch (name){
            case "FIRST LINE":
                return FIRST_LINE;

            case "SECOND LINE":
                return SECOND_LINE;

            case "THIRD LINE":
                return THIRD_LINE;

            default:
                throw new IllegalArgumentException("Unknown argument passes to method : " + name);
        }
    }


}
