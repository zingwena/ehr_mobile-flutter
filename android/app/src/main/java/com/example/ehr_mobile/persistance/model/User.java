package com.example.ehr_mobile.persistance.model;

import androidx.room.Entity;
import androidx.room.PrimaryKey;

@Entity
public class User {

    @PrimaryKey(autoGenerate = true)
    private int p_id;
    private int id;

    private String login;
    private String first_name;
    private String last_name;
    private String email;
    private String image_url;
    private String activated;
    private String lang_key;
    private String created_by;
    private String created_date;
    private String last_modified_by;
    private String last_modified_date;
    private String permissions;

    public int getP_id() {
        return p_id;
    }

    public void setP_id(int p_id) {
        this.p_id = p_id;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getLogin() {
        return login;
    }

    public void setLogin(String login) {
        this.login = login;
    }

    public String getFirst_name() {
        return first_name;
    }

    public void setFirst_name(String first_name) {
        this.first_name = first_name;
    }

    public String getLast_name() {
        return last_name;
    }

    public void setLast_name(String last_name) {
        this.last_name = last_name;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getImage_url() {
        return image_url;
    }

    public void setImage_url(String image_url) {
        this.image_url = image_url;
    }

    public String getActivated() {
        return activated;
    }

    public void setActivated(String activated) {
        this.activated = activated;
    }

    public String getLang_key() {
        return lang_key;
    }

    public void setLang_key(String lang_key) {
        this.lang_key = lang_key;
    }

    public String getCreated_by() {
        return created_by;
    }

    public void setCreated_by(String created_by) {
        this.created_by = created_by;
    }

    public String getCreated_date() {
        return created_date;
    }

    public void setCreated_date(String created_date) {
        this.created_date = created_date;
    }

    public String getLast_modified_by() {
        return last_modified_by;
    }

    public void setLast_modified_by(String last_modified_by) {
        this.last_modified_by = last_modified_by;
    }

    public String getLast_modified_date() {
        return last_modified_date;
    }

    public void setLast_modified_date(String last_modified_date) {
        this.last_modified_date = last_modified_date;
    }

    public String getPermissions() {
        return permissions;
    }

    public void setPermissions(String permissions) {
        this.permissions = permissions;
    }

    @Override
    public String toString() {
        return "User{" +
                "id=" + id +
                ", login='" + login + '\'' +
                ", first_name='" + first_name + '\'' +
                ", last_name='" + last_name + '\'' +
                ", email='" + email + '\'' +
                ", image_url='" + image_url + '\'' +
                ", activated='" + activated + '\'' +
                ", lang_key='" + lang_key + '\'' +
                ", created_by='" + created_by + '\'' +
                ", created_date='" + created_date + '\'' +
                ", last_modified_by='" + last_modified_by + '\'' +
                ", last_modified_date='" + last_modified_date + '\'' +
                ", permissions='" + permissions + '\'' +
                '}';
    }
}
