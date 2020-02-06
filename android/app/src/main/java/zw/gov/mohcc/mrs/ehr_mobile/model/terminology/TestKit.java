package zw.gov.mohcc.mrs.ehr_mobile.model.terminology;

import androidx.room.Entity;
import androidx.room.Ignore;
import androidx.room.Index;

import zw.gov.mohcc.mrs.ehr_mobile.model.BaseNameModel;

/**
 * @author kombo on 8/21/19
 */
@Entity(indices = {@Index(value = "code", unique = true)})
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
