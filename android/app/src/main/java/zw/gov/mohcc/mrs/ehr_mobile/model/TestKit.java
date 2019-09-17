package zw.gov.mohcc.mrs.ehr_mobile.model;

import androidx.room.Entity;
import androidx.room.Ignore;
import androidx.room.PrimaryKey;

/**
 * @author kombo on 8/21/19
 */
@Entity
public class TestKit extends BaseNameModel {

    private String description;
    private String level;

    public TestKit() {
    }

    @Ignore
    public TestKit(String code, String name, String description, String level) {
        super(code, name);
        this.description = description;
        this.level = level;
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

    @Override
    public String toString() {
        return "TestKit{" +
                "code='" + getCode() + '\'' +
                ", name='" + getName() + '\'' +
                ", description='" + description + '\'' +
                ", level='" + level + '\'' +
                '}';
    }
}
