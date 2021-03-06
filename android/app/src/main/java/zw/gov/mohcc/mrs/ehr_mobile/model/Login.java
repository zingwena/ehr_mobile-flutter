package zw.gov.mohcc.mrs.ehr_mobile.model;

public class Login {

    private String username;
    private String password;

    public Login( String username, String password) {

        this.username = username;
        this.password = password;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    @Override
    public String toString() {
        return "DataSync{" +

                " username='" + username + '\'' +
                ", password='" + password + '\'' +
                '}';
    }
}
