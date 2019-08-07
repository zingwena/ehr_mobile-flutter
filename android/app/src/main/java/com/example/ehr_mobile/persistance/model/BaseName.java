package com.example.ehr_mobile.persistance.model;

import java.io.Serializable;

import lombok.Data;

@Data
public class BaseName implements Serializable {

    private String id;
    private String name;
}
