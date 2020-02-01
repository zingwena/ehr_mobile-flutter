package zw.gov.mohcc.mrs.ehr_mobile.model;

import androidx.annotation.NonNull;
import androidx.room.PrimaryKey;
import androidx.room.TypeConverters;

import java.io.Serializable;

import zw.gov.mohcc.mrs.ehr_mobile.converter.RecordStatusConvertor;
import zw.gov.mohcc.mrs.ehr_mobile.enumeration.RecordStatus;

public class BaseEntity implements Serializable {

    @PrimaryKey
    @NonNull
    private String id;

    @TypeConverters(RecordStatusConvertor.class)
    private RecordStatus recordStatus;

    public BaseEntity() {
    }

    public BaseEntity(@NonNull String id) {
        this.id = id;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public RecordStatus getRecordStatus() {
        return recordStatus;
    }

    public void setRecordStatus(RecordStatus recordStatus) {
        this.recordStatus = recordStatus;
    }

    @Override
    public boolean equals(Object obj) {
        if (obj == null) {
            return false;
        }
        if (!(obj instanceof BaseEntity)) {
            return false;
        }
        return this.getId().equals(((BaseEntity) obj).getId());
    }

    @Override
    public int hashCode() {
        int hash = 7;
        hash = 19 * hash + (this.id != null ? this.id.hashCode() : 0);
        return hash;
    }

    @Override
    public String toString() {
        return "BaseEntity{" +
                "id='" + id + '\'' +
                ", recordStatus=" + recordStatus +
                '}';
    }
}
