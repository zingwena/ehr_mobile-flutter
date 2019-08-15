package zw.gov.mohcc.mrs.ehr_mobile.model;

import androidx.room.ColumnInfo;

import java.io.Serializable;

public class BaseNameModel implements Serializable {


    private String code;
    private String name;

    public BaseNameModel() {
    }

    public BaseNameModel(String code, String name) {
        this.code = code;
        this.name = name;
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
        return "BaseNameModel{" +
                "code='" + code + '\'' +
                ", name='" + name + '\'' +
                '}';
    }
}
