package zw.gov.mohcc.mrs.ehr_mobile.dto;

import java.io.Serializable;

public class Page implements Serializable {

    public int size = 20000;
    public boolean first = true;
    public boolean last = true;
    public int number = 0;
    public int numberOfElements = 0;
    public int totalElements = 0;
    public int totalPages = 0;
}
