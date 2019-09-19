package zw.gov.mohcc.mrs.ehr_mobile.model;

import androidx.room.Entity;
import androidx.room.Ignore;
import androidx.room.PrimaryKey;
import androidx.room.TypeConverters;

import java.util.Date;

import zw.gov.mohcc.mrs.ehr_mobile.model.vitals.TestForPregnantLactatingMother;
import zw.gov.mohcc.mrs.ehr_mobile.util.DateConverter;
import zw.gov.mohcc.mrs.ehr_mobile.util.HtsApproachConverter;
import zw.gov.mohcc.mrs.ehr_mobile.util.HtsTypeConverter;
import zw.gov.mohcc.mrs.ehr_mobile.util.TestForPregnantLactatingMotherConverter;

@Entity
public class Hts extends BaseEntity {
    private String personId;
    private String visitId;
    private String htsType;
    @TypeConverters(DateConverter.class)
    private Date dateOfHivTest;
    private String entryPointId;
    private String htsApproach;
    private String reasonForHivTestingId;
    private String htsModelId;
    private boolean preTestInformationGiven;
    private boolean newTestInClientLife;
    private boolean newTestPregLact;
    private boolean coupleCounselling;
    private boolean optOutOfTest;
    private boolean resultReceived;
    private String reasonForNotIssuingResultId;
    private boolean postTestCounselled;
    @TypeConverters(DateConverter.class)
    private Date datePostTestCounselled;
    private boolean consentToIndexTesting;

    public Hts() {
    }

    @Ignore
    public Hts(String visitId) {
        this.visitId = visitId;
    }

    public String getVisitId() {
        return visitId;
    }

    public void setVisitId(String visitId) {
        this.visitId = visitId;
    }

    public String getPersonId() {
        return personId;
    }

    public void setPersonId(String personId) {
        this.personId = personId;
    }

    public boolean isNewTestPregLact() {
        return newTestPregLact;
    }

    public String getHtsType() {
        return htsType;
    }

    public void setHtsType(String htsType) {
        this.htsType = htsType;
    }

    public Date getDateOfHivTest() {
        return dateOfHivTest;
    }

    public void setDateOfHivTest(Date dateOfHivTest) {
        this.dateOfHivTest = dateOfHivTest;
    }

    public String getEntryPointId() {
        return entryPointId;
    }

    public void setEntryPointId(String entryPointId) {
        this.entryPointId = entryPointId;
    }

    public String getHtsApproach() {
        return htsApproach;
    }

    public void setHtsApproach(String htsApproach) {
        this.htsApproach = htsApproach;
    }

    public String getReasonForHivTestingId() {
        return reasonForHivTestingId;
    }

    public void setReasonForHivTestingId(String reasonForHivTestingId) {
        this.reasonForHivTestingId = reasonForHivTestingId;
    }

    public String getHtsModelId() {
        return htsModelId;
    }

    public void setHtsModelId(String htsModelId) {
        this.htsModelId = htsModelId;
    }

    public boolean isPreTestInformationGiven() {
        return preTestInformationGiven;
    }

    public void setPreTestInformationGiven(boolean preTestInformationGiven) {
        this.preTestInformationGiven = preTestInformationGiven;
    }

    public boolean isNewTestInClientLife() {
        return newTestInClientLife;
    }

    public void setNewTestInClientLife(boolean newTestInClientLife) {
        this.newTestInClientLife = newTestInClientLife;
    }


    public void setNewTestPregLact(boolean newTestPregLact) {
        this.newTestPregLact = newTestPregLact;
    }

    public boolean isCoupleCounselling() {
        return coupleCounselling;
    }

    public void setCoupleCounselling(boolean coupleCounselling) {
        this.coupleCounselling = coupleCounselling;
    }

    public boolean isOptOutOfTest() {
        return optOutOfTest;
    }

    public void setOptOutOfTest(boolean optOutOfTest) {
        this.optOutOfTest = optOutOfTest;
    }

    public boolean isResultReceived() {
        return resultReceived;
    }

    public void setResultReceived(boolean resultReceived) {
        this.resultReceived = resultReceived;
    }

    public String getReasonForNotIssuingResultId() {
        return reasonForNotIssuingResultId;
    }

    public void setReasonForNotIssuingResultId(String reasonForNotIssuingResultId) {
        this.reasonForNotIssuingResultId = reasonForNotIssuingResultId;
    }

    public boolean isPostTestCounselled() {
        return postTestCounselled;
    }

    public void setPostTestCounselled(boolean postTestCounselled) {
        this.postTestCounselled = postTestCounselled;
    }

    public Date getDatePostTestCounselled() {
        return datePostTestCounselled;
    }

    public void setDatePostTestCounselled(Date datePostTestCounselled) {
        this.datePostTestCounselled = datePostTestCounselled;
    }

    public boolean isConsentToIndexTesting() {
        return consentToIndexTesting;
    }

    public void setConsentToIndexTesting(boolean consentToIndexTesting) {
        this.consentToIndexTesting = consentToIndexTesting;
    }
}
