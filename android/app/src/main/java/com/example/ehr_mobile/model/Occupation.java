package com.example.ehr_mobile.model;



//@Data
public class Occupation extends BasePageable<Occupation> {

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
        return super.toString()+ " Occupation{" +
                "code='" + code + '\'' +
                ", name='" + name + '\'' +
                '}';
    }
}
