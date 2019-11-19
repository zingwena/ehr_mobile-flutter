package zw.gov.mohcc.mrs.ehr_mobile.dto;

import androidx.room.TypeConverters;

import java.util.Date;

import zw.gov.mohcc.mrs.ehr_mobile.converter.DateConverter;

public class IndexTestDto {

    private String personId;

    @TypeConverters(DateConverter.class)
    private Date date;

    public String getPersonId() {
        return personId;
    }

    public void setPersonId(String personId) {
        this.personId = personId;
    }

    public Date getDate() {
        return date;
    }

    public void setDate(Date dateOfEnrolmentIntoCare) {
        this.date = dateOfEnrolmentIntoCare;
    }
}
