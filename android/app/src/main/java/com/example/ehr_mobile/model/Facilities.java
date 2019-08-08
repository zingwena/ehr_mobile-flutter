package com.example.ehr_mobile.model;

import java.util.ArrayList;

public class Facilities extends BasePageable<Facilities>{
   private ArrayList content;
   private int totalElements;
   private int totalPages;
   private int numberOfElements;
   private int size;
   private int number;
   private boolean first;
   private boolean last;

    public Facilities(ArrayList content, int totalElements, int totalPages, int number, int numberOfElements, int size, boolean first, boolean last)
    {
        this.content=content;
        this.first=first;
        this.last=last;
        this.number=number;
        this.numberOfElements=numberOfElements;
        this.totalElements=totalElements;
        this.size=size;
        this.totalPages=totalPages;
    }
    public int getTotalElements()
    {
        return totalElements;
    }
    public  void setTotalElements(int totalElements)
    {
        this.totalElements=totalElements;
    }
    public int getTotalPages()
    {
        return totalPages;
    }
    public  void setTotalPages(int totalPages)
    {
        this.totalPages=totalPages;
    }
    public int getNumber()
    {
        return number;
    }
    public  void setNumber(int number)
    {
        this.number=number;
    }
    public int getSize()
    {
        return size;
    }
    public  void setSize(int size)
    {
        this.size=size;
    }
    public int getNumberOfElements()
    {
        return numberOfElements;
    }
    public  void setNumberOfElements(int numberOfElements)
    {
        this.numberOfElements=numberOfElements;
    }
    public boolean getFirst()
    {
        return first;
    }
    public  void setFirst(boolean first)
    {
        this.first=first;
    }
    public boolean getLast()
    {
        return last;
    }
    public  void setLast(boolean last)
    {
        this.last=last;
    }
    public ArrayList getContent()
    {
        return content;
    }
    public void setContent(ArrayList content)
    {
        this.content=content;
    }

}
