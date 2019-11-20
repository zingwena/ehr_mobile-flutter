package zw.gov.mohcc.mrs.ehr_mobile.model.terminology;

import androidx.room.Entity;
import androidx.room.Ignore;
import androidx.room.PrimaryKey;

import zw.gov.mohcc.mrs.ehr_mobile.model.BaseNameModel;

/**
 * @author kombo on 8/21/19
 */
@Entity
public class TestKit extends BaseNameModel {

    private String description;

    public TestKit() {
    }

    @Ignore
    public TestKit(String code, String name, String description) {
        super(code, name);
        this.description = description;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    @Override
    public String toString() {
        return "TestKit{" +
                "code='" + getCode() + '\'' +
                ", name='" + getName() + '\'' +
                ", description='" + description + '\'' +
                '}';
    }
}
