package zw.gov.mohcc.mrs.ehr_mobile.model;

public class Token {

    private String id_token;

    public Token(String id_token) {
        this.id_token = id_token;
    }

    public String getId_token() {
        return id_token;
    }

    public void setId_token(String id_token) {
        this.id_token = id_token;
    }

    @Override
    public String toString() {
        return "Token{" +
                "id_token='" + id_token + '\'' +
                '}';
    }
}
