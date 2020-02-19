package zw.gov.mohcc.mrs.ehr_mobile.model.art;

import androidx.annotation.NonNull;
import androidx.room.Entity;
import androidx.room.ForeignKey;
import androidx.room.Ignore;
import androidx.room.Index;
import androidx.room.TypeConverters;

import java.util.Date;

import zw.gov.mohcc.mrs.ehr_mobile.converter.NormalityConverter;
import zw.gov.mohcc.mrs.ehr_mobile.converter.ReasonOfNotDisclosingConverter;
import zw.gov.mohcc.mrs.ehr_mobile.converter.RelationshipTypeConverter;
import zw.gov.mohcc.mrs.ehr_mobile.enumeration.Normality;
import zw.gov.mohcc.mrs.ehr_mobile.enumeration.ReasonOfNotDisclosing;
import zw.gov.mohcc.mrs.ehr_mobile.enumeration.RelationshipType;
import zw.gov.mohcc.mrs.ehr_mobile.model.BaseEntity;
import zw.gov.mohcc.mrs.ehr_mobile.model.person.Person;
import zw.gov.mohcc.mrs.ehr_mobile.converter.DateConverter;

import static androidx.room.ForeignKey.CASCADE;
@Entity(indices = {@Index(value = "personId", unique = true)},
foreignKeys = @ForeignKey(entity = Person.class, onDelete = CASCADE,
        parentColumns = "id",
        childColumns = "personId"))
public class Art extends BaseEntity {

    @NonNull
    private String personId;
    //@NonNull
    @TypeConverters(DateConverter.class)
    private Date date;
    @NonNull
    private String artNumber;
    private Boolean enlargedLymphNode;
    private Boolean pallor;
    private Boolean jaundice;
    private Boolean cyanosis;
    @TypeConverters(NormalityConverter.class)
    private Normality mentalStatus;
    @TypeConverters(NormalityConverter.class)
    private Normality centralNervousSystem;
    @TypeConverters(DateConverter.class)
    @NonNull
    private Date dateOfHivTest;
    @TypeConverters(DateConverter.class)
    //@NonNull
    private Date dateEnrolled;
    private Boolean tracing;
    private Boolean followUp;
    private Boolean hivStatus;
    @TypeConverters(RelationshipTypeConverter.class)
    private RelationshipType relation;
    @TypeConverters(DateConverter.class)
    private Date dateOfDisclosure;
    @TypeConverters(ReasonOfNotDisclosingConverter.class)
    private ReasonOfNotDisclosing reason;

    public Art() {
    }

    @Ignore
    public Art(@NonNull String id, @NonNull String personId) {
        super(id);
        this.personId = personId;
    }

    @NonNull
    public String getPersonId() {
        return personId;
    }

    public void setPersonId(@NonNull String personId) {
        this.personId = personId;
    }

    @NonNull
    public Date getDate() {
        return date;
    }

    public void setDate(@NonNull Date date) {
        this.date = date;
    }

    @NonNull
    public String getArtNumber() {
        return artNumber;
    }

    public void setArtNumber(@NonNull String artNumber) {
        this.artNumber = artNumber;
    }

    public Boolean getEnlargedLymphNode() {
        return enlargedLymphNode;
    }

    public void setEnlargedLymphNode(Boolean enlargedLymphNode) {
        this.enlargedLymphNode = enlargedLymphNode;
    }

    public Boolean getPallor() {
        return pallor;
    }

    public void setPallor(Boolean pallor) {
        this.pallor = pallor;
    }

    public Boolean getJaundice() {
        return jaundice;
    }

    public void setJaundice(Boolean jaundice) {
        this.jaundice = jaundice;
    }

    public Boolean getCyanosis() {
        return cyanosis;
    }

    public void setCyanosis(Boolean cyanosis) {
        this.cyanosis = cyanosis;
    }

    public Normality getMentalStatus() {
        return mentalStatus;
    }

    public void setMentalStatus(Normality mentalStatus) {
        this.mentalStatus = mentalStatus;
    }

    public Normality getCentralNervousSystem() {
        return centralNervousSystem;
    }

    public void setCentralNervousSystem(Normality centralNervousSystem) {
        this.centralNervousSystem = centralNervousSystem;
    }

    public Date getDateOfHivTest() {
        return dateOfHivTest;
    }

    public void setDateOfHivTest(Date dateOfHivTest) {
        this.dateOfHivTest = dateOfHivTest;
    }

    public Date getDateEnrolled() {
        return dateEnrolled;
    }

    public void setDateEnrolled(Date dateEnrolled) {
        this.dateEnrolled = dateEnrolled;
    }

    public Boolean getTracing() {
        return tracing;
    }

    public void setTracing(Boolean tracing) {
        this.tracing = tracing;
    }

    public Boolean getFollowUp() {
        return followUp;
    }

    public void setFollowUp(Boolean followUp) {
        this.followUp = followUp;
    }

    public Boolean getHivStatus() {
        return hivStatus;
    }

    public void setHivStatus(Boolean hivStatus) {
        this.hivStatus = hivStatus;
    }

    public RelationshipType getRelation() {
        return relation;
    }

    public void setRelation(RelationshipType relation) {
        this.relation = relation;
    }

    public Date getDateOfDisclosure() {
        return dateOfDisclosure;
    }

    public void setDateOfDisclosure(Date dateOfDisclosure) {
        this.dateOfDisclosure = dateOfDisclosure;
    }

    public ReasonOfNotDisclosing getReason() {
        return reason;
    }

    public void setReason(ReasonOfNotDisclosing reason) {
        this.reason = reason;
    }

    @Override
    public String toString() {
        return "Art{" +
                "personId='" + personId + '\'' +
                ", date=" + date +
                ", artNumber='" + artNumber + '\'' +
                ", enlargedLymphNode=" + enlargedLymphNode +
                ", pallor=" + pallor +
                ", jaundice=" + jaundice +
                ", cyanosis=" + cyanosis +
                ", mentalStatus=" + mentalStatus +
                ", centralNervousSystem=" + centralNervousSystem +
                ", dateOfHivTest=" + dateOfHivTest +
                ", dateEnrolled=" + dateEnrolled +
                ", tracing=" + tracing +
                ", followUp=" + followUp +
                ", hivStatus=" + hivStatus +
                ", relation=" + relation +
                ", dateOfDisclosure=" + dateOfDisclosure +
                ", reason=" + reason +
                '}';
    }
}
