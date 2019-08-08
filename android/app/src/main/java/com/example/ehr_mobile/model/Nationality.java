package com.example.ehr_mobile.model;

import androidx.room.Entity;
import androidx.room.PrimaryKey;

@Entity
public class Nationality extends BaseNameModel {

    @PrimaryKey(autoGenerate = true)
    private int id;

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }
}
