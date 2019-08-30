package zw.gov.mohcc.mrs.ehr_mobile.model;

import androidx.room.Entity;
import androidx.room.Ignore;
import androidx.room.PrimaryKey;

/**
 * @author kombo on 8/21/19
 */
@Entity
public class TestKit {

    public TestKit() {
    }

    @PrimaryKey(autoGenerate = true)
    private int id;
    private String code;
    private String name;
    private String description;
    private String level;


    @Ignore
    public TestKit(String code, String name, String description, String level) {
        this.code = code;
        this.name = name;
        this.description = description;
        this.level = level;
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

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getLevel() {
        return level;
    }

    public void setLevel(String level) {
        this.level = level;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    @Override
    public String toString() {
        return "TestKit{" +
                "code='" + code + '\'' +
                ", name='" + name + '\'' +
                ", description='" + description + '\'' +
                ", level='" + level + '\'' +
                '}';
    }
}
