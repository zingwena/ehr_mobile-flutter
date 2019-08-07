package com.example.ehr_mobile.model;

import lombok.Data;

@Data
public class Occupation extends BasePageable<Occupation> {

    private String code;
    private String name;
}
