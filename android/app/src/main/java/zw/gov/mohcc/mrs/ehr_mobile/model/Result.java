package zw.gov.mohcc.mrs.ehr_mobile.model;

import androidx.room.Entity;
import androidx.room.Ignore;
import androidx.room.PrimaryKey;

@Entity
public class Result {

    @PrimaryKey(autoGenerate = true)
    private int id;
    private  String code ;
    private  String name ;

     @Ignore
    public Result( String code, String name) {
        this.code = code;
        this.name = name;
    }

    public Result() {

    }
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
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
}
