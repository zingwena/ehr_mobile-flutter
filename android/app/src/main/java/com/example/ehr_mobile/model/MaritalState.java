package com.example.ehr_mobile.model;

import androidx.room.Entity;
import androidx.room.PrimaryKey;

import java.util.ArrayList;

@Entity
public class MaritalState extends BaseNameModel {

    @PrimaryKey
    @Override
    public String getCode () {
        return super.getCode();
    }
}
