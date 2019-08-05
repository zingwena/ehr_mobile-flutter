package com.example.ehr_mobile.model;

import java.util.ArrayList;

public class MaritalStates {

    private ArrayList content;

    private int totalElements;
    private  boolean last;
    private int totalPages;
    private boolean sort;
    private boolean first;
    private int numberOfElements;
    private  int size;
    private int number;

    public MaritalStates(ArrayList content, int totalElements, boolean last, int totalPages, boolean sort, boolean first, int numberOfElements, int size, int number) {
        this.content = content;
        this.totalElements = totalElements;
        this.last = last;
        this.totalPages = totalPages;
        this.sort = sort;
        this.first = first;
        this.numberOfElements = numberOfElements;
        this.size = size;
        this.number = number;
    }

    public ArrayList getContent() {
        return content;
    }

    public void setContent(ArrayList content) {
        this.content = content;
    }

    public int getTotalElements() {
        return totalElements;
    }

    public void setTotalElements(int totalElements) {
        this.totalElements = totalElements;
    }

    public boolean isLast() {
        return last;
    }

    public void setLast(boolean last) {
        this.last = last;
    }

    public int getTotalPages() {
        return totalPages;
    }

    public void setTotalPages(int totalPages) {
        this.totalPages = totalPages;
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

    public int getNumberOfElements() {
        return numberOfElements;
    }

    public void setNumberOfElements(int numberOfElements) {
        this.numberOfElements = numberOfElements;
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
        return "MaritalStates{" +
                "content=" + content +
                ", totalElements=" + totalElements +
                ", last=" + last +
                ", totalPages=" + totalPages +
                ", sort=" + sort +
                ", first=" + first +
                ", numberOfElements=" + numberOfElements +
                ", size=" + size +
                ", number=" + number +
                '}';
    }

}
