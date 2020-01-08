package zw.gov.mohcc.mrs.ehr_mobile.dto;

import androidx.room.Ignore;
import androidx.room.TypeConverters;

import java.io.Serializable;

import zw.gov.mohcc.mrs.ehr_mobile.converter.BinTypeConverter;
import zw.gov.mohcc.mrs.ehr_mobile.enumeration.BinType;

public class BinTypeIdName implements Serializable {

    @TypeConverters(BinTypeConverter.class)
    private BinType binType;
    private String name;
    private String id;

    public BinTypeIdName() {
    }

    @Ignore
    public BinTypeIdName(BinType binType, String name, String id) {
        this.binType = binType;
        this.name = name;
        this.id = id;
    }

    public BinType getBinType() {
        return binType;
    }

    public void setBinType(BinType binType) {
        this.binType = binType;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }
}
