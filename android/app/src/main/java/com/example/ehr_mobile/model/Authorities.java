package com.example.ehr_mobile.model;


import androidx.room.Entity;
import androidx.room.ForeignKey;
import androidx.room.PrimaryKey;
import androidx.room.Relation;

import static androidx.room.ForeignKey.CASCADE;

@Entity(foreignKeys = @ForeignKey(entity = User.class,
        parentColumns = "userId",
        childColumns = "userId",
        onDelete = CASCADE))


public class Authorities {

    @PrimaryKey(autoGenerate = true)
    private int id;
    private int userId;
    private String authority;

    public Authorities(int userId, String authority) {
        this.userId = userId;
        this.authority = authority;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public String getAuthority() {
        return authority;
    }

    public void setAuthority(String authority) {
        this.authority = authority;
    }

    @Override
    public String toString() {
        return "Authorities{" +
                "id=" + id +
                ", userId=" + userId +
                ", authority='" + authority + '\'' +
                '}';
    }
}
