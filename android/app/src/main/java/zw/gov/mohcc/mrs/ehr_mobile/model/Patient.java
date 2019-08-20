package zw.gov.mohcc.mrs.ehr_mobile.model;

import androidx.annotation.NonNull;
import androidx.room.ColumnInfo;
import androidx.room.Embedded;
import androidx.room.Entity;
import androidx.room.ForeignKey;
import androidx.room.Ignore;
import androidx.room.Index;
import androidx.room.PrimaryKey;
import androidx.room.TypeConverters;

import java.time.LocalDate;

import zw.gov.mohcc.mrs.ehr_mobile.util.DataConverter;
import zw.gov.mohcc.mrs.ehr_mobile.util.GenderConverter;
import zw.gov.mohcc.mrs.ehr_mobile.util.SelfIdentifiedGenderConverter;

import static androidx.room.ForeignKey.CASCADE;

@Entity(indices = {@Index("personId"), @Index("countryId"), @Index("educationLevelId"), @Index("religionId"), @Index("maritalStatusId"),
        @Index("nationalityId"), @Index("occupationId")},
        foreignKeys = {
                @ForeignKey(entity = Country.class, onDelete = CASCADE,
                        parentColumns = "code",
                        childColumns = "countryId"),
                @ForeignKey(entity = EducationLevel.class, onDelete = CASCADE,
                        parentColumns = "code",
                        childColumns = "educationLevelId"),
                @ForeignKey(entity = Religion.class, onDelete = CASCADE,
                        parentColumns = "code",
                        childColumns = "religionId")
                ,
                @ForeignKey(entity = MaritalStatus.class, onDelete = CASCADE,
                        parentColumns = "code",
                        childColumns = "maritalStatusId")
                ,
                @ForeignKey(entity = Nationality.class, onDelete = CASCADE,
                        parentColumns = "code",
                        childColumns = "nationalityId")
                ,
                @ForeignKey(entity = Occupation.class, onDelete = CASCADE,
                        parentColumns = "code",
                        childColumns = "occupationId")
        }
)
public class Patient {


    public String selfIdentifiedGender;

    public String sex;
    @PrimaryKey(autoGenerate = true)
    private int id;

    @NonNull
    private String firstName;
    @NonNull
    private String lastName;
    @ColumnInfo()
    private String personId;
    private String nationalId;
    private String religionId;
    private String occupationId;
    private String maritalStatusId;
    private String educationLevelId;
    @TypeConverters(DataConverter.class)
    private LocalDate birthDate;
    private String nationalityId;
    private String countryId;
    @Embedded
    private Address address;

    public Patient() {
    }



    @Ignore

    public Patient(@NonNull String firstName, @NonNull String lastName, String nationalId) {

        this.firstName = firstName;
        this.lastName = lastName;
        this.nationalId = nationalId;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    @NonNull
    public String getFirstName() {
        return firstName;
    }

    public void setFirstName(@NonNull String firstName) {
        this.firstName = firstName;
    }

    public String getSelfIdentifiedGender() {
        return selfIdentifiedGender;
    }

    public void setSelfIdentifiedGender(String selfIdentifiedGender) {
        this.selfIdentifiedGender = selfIdentifiedGender;
    }

    public String getSex() {
        return sex;
    }

    public void setSex(String sex) {
        this.sex = sex;
    }

    @NonNull
    public String getLastName() {
        return lastName;
    }

    public void setLastName(@NonNull String lastName) {
        this.lastName = lastName;
    }

    public String getPersonId() {
        return personId;
    }

    public void setPersonId(String personId) {
        this.personId = personId;
    }


    public String getNationalId() {
        return nationalId;
    }

    public void setNationalId(String nationalId) {
        this.nationalId = nationalId;
    }

    public LocalDate getBirthDate() {
        return birthDate;
    }

    public void setBirthDate(LocalDate birthDate) {
        this.birthDate = birthDate;
    }

    public Address getAddress() {
        return address;
    }

    public void setAddress(Address address) {
        this.address = address;
    }

    public String getReligionId() {
        return religionId;
    }

    public void setReligionId(String religionId) {
        this.religionId = religionId;
    }

    public String getOccupationId() {
        return occupationId;
    }

    public void setOccupationId(String occupationId) {
        this.occupationId = occupationId;
    }

    public String getMaritalStatusId() {
        return maritalStatusId;
    }

    public void setMaritalStatusId(String maritalStatusId) {
        this.maritalStatusId = maritalStatusId;
    }

    public String getEducationLevelId() {
        return educationLevelId;
    }

    public void setEducationLevelId(String educationLevelId) {
        this.educationLevelId = educationLevelId;
    }

    public String getNationalityId() {
        return nationalityId;
    }

    public void setNationalityId(String nationalityId) {
        this.nationalityId = nationalityId;
    }

    public String getCountryId() {
        return countryId;
    }

    public void setCountryId(String countryId) {
        this.countryId = countryId;
    }
}
