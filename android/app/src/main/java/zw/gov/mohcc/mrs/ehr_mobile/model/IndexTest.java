package zw.gov.mohcc.mrs.ehr_mobile.model;

import androidx.annotation.NonNull;
import androidx.room.Entity;

import java.util.Date;

@Entity
public class IndexTest extends BaseEntity {

    @NonNull
    private String personId;
    private Date date;
}
