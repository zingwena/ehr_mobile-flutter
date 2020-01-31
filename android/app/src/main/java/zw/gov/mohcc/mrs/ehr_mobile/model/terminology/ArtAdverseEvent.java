package zw.gov.mohcc.mrs.ehr_mobile.model.terminology;

import androidx.annotation.NonNull;
import androidx.room.Entity;
import androidx.room.Ignore;

import zw.gov.mohcc.mrs.ehr_mobile.model.BaseEntity;
import zw.gov.mohcc.mrs.ehr_mobile.model.BaseNameModel;

@Entity
public class ArtAdverseEvent extends BaseEntity {

    private String statusId;

    private String code;

    private String name;

    public ArtAdverseEvent() {
    }

    @Ignore
    public ArtAdverseEvent(@NonNull String id, String statusId, String code, String name) {
        super(id);
        this.statusId = statusId;
        this.code = code;
        this.name = name;
    }

    public String getStatusId() {
        return statusId;
    }

    public void setStatusId(String statusId) {
        this.statusId = statusId;
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
