package zw.gov.mohcc.mrs.ehr_mobile.model.laboratory;

import androidx.annotation.NonNull;
import androidx.room.Entity;
import androidx.room.ForeignKey;
import androidx.room.Ignore;
import androidx.room.Index;
import androidx.room.TypeConverters;

import java.util.Date;

import zw.gov.mohcc.mrs.ehr_mobile.model.BaseEntity;
import zw.gov.mohcc.mrs.ehr_mobile.model.terminology.Facility;
import zw.gov.mohcc.mrs.ehr_mobile.converter.DateConverter;

import static androidx.room.ForeignKey.CASCADE;


@Entity(indices = {@Index("facilityId"), @Index(value = "personInvestigationId", unique = true)},
        foreignKeys = {@ForeignKey(entity = Facility.class, parentColumns = "code", childColumns = "facilityId", onDelete = CASCADE),
                @ForeignKey(entity = PersonInvestigation.class, parentColumns = "id", childColumns = "personInvestigationId", onDelete = CASCADE)})
public class LaboratoryInvestigation extends BaseEntity {

    @NonNull
    private String facilityId;
    @NonNull
    private String personInvestigationId;
    @TypeConverters(DateConverter.class)
    private Date resultDate;

    public LaboratoryInvestigation() {
    }

    @Ignore
    public LaboratoryInvestigation(@NonNull String id, @NonNull String facilityId, @NonNull String personInvestigationId) {
        super(id);
        this.facilityId = facilityId;
        this.personInvestigationId = personInvestigationId;
    }

    @NonNull
    public String getFacilityId() {
        return facilityId;
    }

    public void setFacilityId(@NonNull String facilityId) {
        this.facilityId = facilityId;
    }

    @NonNull
    public String getPersonInvestigationId() {
        return personInvestigationId;
    }

    public void setPersonInvestigationId(@NonNull String personInvestigationId) {
        this.personInvestigationId = personInvestigationId;
    }

    public Date getResultDate() {
        return resultDate;
    }

    public void setResultDate(Date resultDate) {
        this.resultDate = resultDate;
    }

    @Override
    public String toString() {
        return "LaboratoryInvestigation{" +
                "id='" + getId() + '\'' +
                "facilityId='" + facilityId + '\'' +
                ", personInvestigationId='" + personInvestigationId + '\'' +
                ", resultDate=" + resultDate +
                '}';
    }
}
