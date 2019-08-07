package com.example.ehr_mobile.model;


import com.google.gson.annotations.SerializedName;

import java.lang.reflect.Array;
import java.util.ArrayList;

public class Occupation {

    @SerializedName("code")
    private String code;
    @SerializedName("name")
    private String name;
    private ArrayList content;
    private int totalElements;
    private int totakPages;
    private boolean last;
    private boolean sort;
    private boolean first;
    private int numberofElements;
    private int size;
    private int number;

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


    public ArrayList getContent() {
        return content;
    }

    public void setContent(ArrayList content) {
        content = content;
    }

    public int getTotalElements() {
        return totalElements;
    }

    public void setTotalElements(int totalElements) {
        this.totalElements = totalElements;
    }

    public int getTotakPages() {
        return totakPages;
    }

    public void setTotakPages(int totakPages) {
        this.totakPages = totakPages;
    }

    public boolean isLast() {
        return last;
    }

    public void setLast(boolean last) {
        this.last = last;
    }

    public boolean isSort() {
        return sort;
    }

    public void setSort(boolean sort) {
        this.sort = sort;
    }

    public boolean isFirst() {
        return first;
    }

    public void setFirst(boolean first) {
        this.first = first;
    }

    public int getNumberofElements() {
        return numberofElements;
    }

    public void setNumberofElements(int numberofElements) {
        this.numberofElements = numberofElements;
    }

    public int getSize() {
        return size;
    }

    public void setSize(int size) {
        this.size = size;
    }

    public int getNumber() {
        return number;
    }

    public void setNumber(int number) {
        this.number = number;
    }


    @Override
    public String toString() {
        return "Occupation{" +
                "code='" + code + '\'' +
                ", name='" + name + '\'' +
                ", Content=" + content +
                ", totalElements=" + totalElements +
                ", totakPages=" + totakPages +
                ", last=" + last +
                ", sort=" + sort +
                ", first=" + first +
                ", numberofElements=" + numberofElements +
                ", size=" + size +
                ", number=" + number +
                '}';
    }
}