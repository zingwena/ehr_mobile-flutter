package com.example.ehr_mobile.model;

import androidx.room.Entity;
import androidx.room.PrimaryKey;

import java.util.ArrayList;

@Entity
public class MaritalState {

    @PrimaryKey(autoGenerate = true)
    private int id;

    private String code;
    private String name;

    public MaritalState(String code, String name) {
        this.id = id;
        this.code = code;
        this.name = name;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

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
        return "MaritalState{" +
                "id=" + id +
                ", code='" + code + '\'' +
                ", name='" + name + '\'' +
                '}';
    }

    //    private ArrayList content;
//
//    private int totalElements;
//     private  boolean last;
//     private int totalPages;
//     private boolean sort;
//      private boolean first;
//      private int numberOfElements;
//       private  int size;
//       private int number;
//
//    public MaritalState(ArrayList content, int totalElements, boolean last, int totalPages, boolean sort, boolean first, int numberOfElements, int size, int number) {
//        this.content = content;
//        this.totalElements = totalElements;
//        this.last = last;
//        this.totalPages = totalPages;
//        this.sort = sort;
//        this.first = first;
//        this.numberOfElements = numberOfElements;
//        this.size = size;
//        this.number = number;


}
