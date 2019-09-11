package zw.gov.mohcc.mrs.ehr_mobile.model;

import androidx.annotation.NonNull;
import androidx.room.Ignore;
import androidx.room.PrimaryKey;

import java.io.Serializable;

public class BaseNameModel implements Serializable {


    @PrimaryKey
    @NonNull
    private String code;
    private String name;

    public BaseNameModel() {
    }

    @Ignore
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
    public boolean equals(Object obj) {
        if (obj == null) {
            return false;
        }
        if (!(obj instanceof BaseEntity)) {
            return false;
        }
        return this.getCode().equals(((BaseNameModel) obj).getCode());
    }

    @Override
    public int hashCode() {
        int hash = 7;
        hash = 19 * hash + (this.code != null ? this.code.hashCode() : 0);
        return hash;
    }

    @Override
    public String toString() {
        return "BaseNameModel{" +
                "code='" + code + '\'' +
                ", name='" + name + '\'' +
                '}';
    }
}
