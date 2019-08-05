package com.example.ehr_mobile.model;

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

    public String getPassword() {
        return password;
    }


    @Override
    public String toString() {
        return "DataSync{" +

                " username='" + username + '\'' +
                ", password='" + password + '\'' +
                '}';
    }
}
