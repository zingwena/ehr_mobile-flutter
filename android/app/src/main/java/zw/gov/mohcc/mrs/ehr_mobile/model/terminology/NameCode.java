package zw.gov.mohcc.mrs.ehr_mobile.model.terminology;

import java.io.Serializable;

public class NameCode implements Serializable {

    private final String code;
    private final String name;

    public NameCode(String code, String name) {
        this.code = code;
        this.name = name;
    }

    public String getCode() {
        return code;
    }

    public String getName() {
        return name;
    }
}
