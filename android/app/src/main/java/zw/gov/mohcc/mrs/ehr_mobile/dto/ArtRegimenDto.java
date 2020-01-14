package zw.gov.mohcc.mrs.ehr_mobile.dto;

import androidx.room.TypeConverters;

import zw.gov.mohcc.mrs.ehr_mobile.converter.RegimenTypeConverter;
import zw.gov.mohcc.mrs.ehr_mobile.enumeration.RegimenType;

public class ArtRegimenDto {
    private String personId;
    @TypeConverters(RegimenTypeConverter.class)
    private RegimenType line;

    public ArtRegimenDto(String personId, RegimenType line) {
        this.personId = personId;
        this.line = line;
    }

    public String getPersonId() {
        return personId;
    }

    public void setPersonId(String personId) {
        this.personId = personId;
    }

    public RegimenType getLine() {
        return line;
    }

    public void setLine(RegimenType line) {
        this.line = line;
    }
}
