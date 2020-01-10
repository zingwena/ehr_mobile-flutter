package zw.gov.mohcc.mrs.ehr_mobile.model;

import androidx.annotation.NonNull;
import androidx.room.PrimaryKey;

import org.apache.commons.lang3.StringUtils;

import java.io.Serializable;

public class BaseNameModel implements Serializable {


    @PrimaryKey
    @NonNull
    private String code;
    @NonNull
    private String name;

    public BaseNameModel() {
    }

    public BaseNameModel(@NonNull String code, @NonNull String name) {
        this.code = code;
        this.name = name;
    }

    @NonNull
    public String getCode() {
        return code;
    }

    public void setCode(@NonNull String code) {
        this.code = code;
    }

    @NonNull
    public String getName() {

        if (StringUtils.isNoneBlank(name)) {
            return name.replaceAll("/", " ");
        }
        return name;
    }

    public void setName(@NonNull String name) {
        this.name = name;
    }

    @Override
    public boolean equals(Object obj) {
        if (obj == null) {
            return false;
        }
        if (!(obj instanceof BaseNameModel)) {
            return false;
        }
        return this.getName().equals(((BaseNameModel) obj).getName());
    }

    @Override
    public int hashCode() {
        int hash = 7;
        hash = 19 * hash + (this.name != null ? this.name.hashCode() : 0);
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
