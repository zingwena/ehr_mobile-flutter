package com.example.ehr_mobile.model;

import androidx.room.Entity;
import androidx.room.PrimaryKey;

@Entity
public class Nationality extends BaseNameModel {

    @PrimaryKey
    @Override
    public String getCode () {
        return super.getCode();
    }
}
