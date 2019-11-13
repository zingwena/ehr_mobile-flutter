package zw.gov.mohcc.mrs.ehr_mobile.model;

import androidx.annotation.NonNull;
import androidx.room.Entity;
import androidx.room.ForeignKey;
import androidx.room.Index;
import androidx.room.TypeConverters;

import java.util.Date;

import zw.gov.mohcc.mrs.ehr_mobile.util.DateConverter;

import static androidx.room.ForeignKey.CASCADE;

@Entity(indices = {@Index(value = "personId", unique = true)},
        foreignKeys = {@ForeignKey(entity = Person.class, parentColumns = "id", childColumns = "personId", onDelete = CASCADE)})
public class IndexTest extends BaseEntity {

    @NonNull
    private String personId;
    @TypeConverters(DateConverter.class)
    @NonNull
    private Date date;

    @NonNull
    public String getPersonId() {
        return personId;
    }

    public void setPersonId(@NonNull String personId) {
        this.personId = personId;
    }

    public Date getDate() {
        return date;
    }

    public void setDate(Date date) {
        this.date = date;
    }
}
