package com.example.ehr_mobile.model;

import java.io.Serializable;
import java.util.List;

import lombok.Data;

@Data
public class BasePageable <T> implements Serializable {

    private int totalElements;
    private  boolean last;
    private int totalPages;
    private boolean sort;
    private boolean first;
    private int numberOfElements;
    private  int size;
    private int number;
    private List<T> content;
}
