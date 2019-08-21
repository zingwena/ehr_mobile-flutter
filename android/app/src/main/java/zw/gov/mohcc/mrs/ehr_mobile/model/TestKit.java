package zw.gov.mohcc.mrs.ehr_mobile.model;

import androidx.room.Ignore;
import androidx.room.PrimaryKey;

/**
 * @author kombo on 8/21/19
 */
public class TestKit extends BaseNameModel {

    @PrimaryKey(autoGenerate = true)
    private int id;


    private String description;

    @Ignore
    public TestKit(String code, String name) {
        super(code, name);
    }

}
