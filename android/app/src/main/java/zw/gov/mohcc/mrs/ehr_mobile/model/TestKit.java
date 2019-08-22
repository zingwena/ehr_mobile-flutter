package zw.gov.mohcc.mrs.ehr_mobile.model;

import androidx.room.Entity;
import androidx.room.Ignore;
import androidx.room.PrimaryKey;

/**
 * @author kombo on 8/21/19
 */
@Entity
public class TestKit extends BaseNameModel {

    public TestKit() {
    }

    @PrimaryKey(autoGenerate = true)
    private int id;


    private String description;

    @Ignore
    public TestKit(String code, String name) {
        super(code, name);
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }
}
