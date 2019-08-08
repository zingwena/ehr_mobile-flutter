package zw.gov.mohcc.mrs.ehr_mobile.model;

import java.io.Serializable;
import java.util.List;



//@Data
abstract public class BasePageable <T> implements Serializable {

    private int totalElements;
    private  boolean last;
    private int totalPages;
    private boolean sort;
    private boolean first;
    private int numberOfElements;
    private  int size;
    private int number;
    private List<T> content;

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

    public List<T> getContent() {
        return content;
    }

    public void setContent(List<T> content) {
        this.content = content;
    }

    @Override
    public String toString() {
        return "BasePageable{" +
                "totalElements=" + totalElements +
                ", last=" + last +
                ", totalPages=" + totalPages +
                ", sort=" + sort +
                ", first=" + first +
                ", numberOfElements=" + numberOfElements +
                ", size=" + size +
                ", number=" + number +
                ", content=" + content +
                '}';
    }
}
