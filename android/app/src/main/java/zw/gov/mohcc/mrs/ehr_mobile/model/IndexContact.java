package zw.gov.mohcc.mrs.ehr_mobile.model;

import androidx.annotation.NonNull;
import androidx.room.Entity;
import androidx.room.TypeConverters;

import java.util.Date;

import zw.gov.mohcc.mrs.ehr_mobile.util.DateConverter;
import zw.gov.mohcc.mrs.ehr_mobile.util.RelationshipTypeConverter;

@Entity
public class IndexContact extends BaseEntity {

    @NonNull
    private String indexTestId;
    @NonNull
    private String personId;
    @NonNull
    @TypeConverters(RelationshipTypeConverter.class)
    private RelationshipType relation;
    private String hivStatus;
    @TypeConverters(DateConverter.class)
    private Date dateOfHivStatus;
    private boolean fearOfIpv;
    private String disclosureMethodPlanId;
    private String testingPlanId;
    private Boolean disclosureStatus;
    private String disclosureMethodId;


    @NonNull
    public String getIndexTestId() {
        return indexTestId;
    }

    public void setIndexTestId(@NonNull String indexTestId) {
        this.indexTestId = indexTestId;
    }

    @NonNull
    public String getPersonId() {
        return personId;
    }

    public void setPersonId(@NonNull String personId) {
        this.personId = personId;
    }

    @NonNull
    public RelationshipType getRelation() {
        return relation;
    }

    public void setRelation(@NonNull RelationshipType relation) {
        this.relation = relation;
    }

    public String getHivStatus() {
        return hivStatus;
    }

    public void setHivStatus(String hivStatus) {
        this.hivStatus = hivStatus;
    }

    public Date getDateOfHivStatus() {
        return dateOfHivStatus;
    }

    public void setDateOfHivStatus(Date dateOfHivStatus) {
        this.dateOfHivStatus = dateOfHivStatus;
    }

    public boolean isFearOfIpv() {
        return fearOfIpv;
    }

    public void setFearOfIpv(boolean fearOfIpv) {
        this.fearOfIpv = fearOfIpv;
    }

    public String getDisclosureMethodPlanId() {
        return disclosureMethodPlanId;
    }

    public void setDisclosureMethodPlanId(String disclosureMethodPlanId) {
        this.disclosureMethodPlanId = disclosureMethodPlanId;
    }

    public String getTestingPlanId() {
        return testingPlanId;
    }

    public void setTestingPlanId(String testingPlanId) {
        this.testingPlanId = testingPlanId;
    }

    public Boolean getDisclosureStatus() {
        return disclosureStatus;
    }

    public void setDisclosureStatus(Boolean disclosureStatus) {
        this.disclosureStatus = disclosureStatus;
    }

    public String getDisclosureMethodId() {
        return disclosureMethodId;
    }

    public void setDisclosureMethodId(String disclosureMethodId) {
        this.disclosureMethodId = disclosureMethodId;
    }
}
