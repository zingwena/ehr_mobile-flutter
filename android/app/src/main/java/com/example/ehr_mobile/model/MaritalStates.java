package com.example.ehr_mobile.model;



public class MaritalStates extends  BasePageable<MaritalStates> {

   private String code;
   private String name;

    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code;
    }

    public String getName() {
        return name;
    }


    public void setName(String name) {
        this.name = name;
    }


    @Override
    public String toString() {
        return "MaritalStates{" +
                "code='" + code + '\'' +
                ", name='" + name + '\'' +
                '}';
    }
}
