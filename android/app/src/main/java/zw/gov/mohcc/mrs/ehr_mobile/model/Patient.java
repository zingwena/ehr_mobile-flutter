package zw.gov.mohcc.mrs.ehr_mobile.model;

import androidx.annotation.NonNull;
import androidx.room.ColumnInfo;
import androidx.room.Embedded;
import androidx.room.Entity;
import androidx.room.Ignore;
import androidx.room.PrimaryKey;
import androidx.room.TypeConverter;
import androidx.room.TypeConverters;

import java.util.Date;

import zw.gov.mohcc.mrs.ehr_mobile.util.GenderConverter;
import zw.gov.mohcc.mrs.ehr_mobile.util.SelfIdentifiedGenderConverter;

@Entity()
public class Patient {
    @PrimaryKey(autoGenerate = true)
    @ColumnInfo(name = "patient_id")
    private int id;

    @NonNull
    private String firstName;
    @NonNull
    private String lastName;
    private String personId;
    private String nationalId;
    @TypeConverters(SelfIdentifiedGenderConverter.class)
    public SelfIdentifiedGender selfIdentifiedGender;
    @Embedded

    private Religion religion;
    @Embedded

    private Occupation occupation;
    @Embedded

    private MaritalStatus maritalStatus;
    @Embedded

    private EducationLevel educationLevel;
    private Date birthDate;
    private int age;

    @TypeConverters(GenderConverter.class)
    public Gender sex;
    @Embedded

    private Nationality nationality;
    @Embedded

    private Country countryOfBirth;
    @Embedded
    private Address address;

    public Patient() {
    }

    @Ignore
    public Patient(@NonNull String firstName, @NonNull String lastName, @NonNull Gender sex) {
        this.firstName = firstName;
        this.lastName = lastName;
        this.sex = sex;
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

    public SelfIdentifiedGender getSelfIdentifiedGender() {
        return selfIdentifiedGender;
    }

    public void setSelfIdentifiedGender(SelfIdentifiedGender selfIdentifiedGender) {
        this.selfIdentifiedGender = selfIdentifiedGender;
    }

    public Gender getSex() {
        return sex;
    }

    public void setSex(Gender sex) {
        this.sex = sex;
    }

    public void setFirstName(@NonNull String firstName) {
        this.firstName = firstName;
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


    public Religion getReligion() {
        return religion;
    }

    public void setReligion(Religion religion) {
        this.religion = religion;
    }

    public Occupation getOccupation() {
        return occupation;
    }

    public void setOccupation(Occupation occupation) {
        this.occupation = occupation;
    }

    public MaritalStatus getMaritalStatus() {
        return maritalStatus;
    }

    public void setMaritalStatus(MaritalStatus maritalStatus) {
        this.maritalStatus = maritalStatus;
    }

    public EducationLevel getEducationLevel() {
        return educationLevel;
    }

    public void setEducationLevel(EducationLevel educationLevel) {
        this.educationLevel = educationLevel;
    }

    public Date getBirthDate() {
        return birthDate;
    }

    public void setBirthDate(Date birthDate) {
        this.birthDate = birthDate;
    }

    public int getAge() {
        return age;
    }

    public void setAge(int age) {
        this.age = age;
    }

    public Nationality getNationality() {
        return nationality;
    }

    public void setNationality(Nationality nationality) {
        this.nationality = nationality;
    }

    public Country getCountryOfBirth() {
        return countryOfBirth;
    }

    public void setCountryOfBirth(Country countryOfBirth) {
        this.countryOfBirth = countryOfBirth;
    }

    public Address getAddress() {
        return address;
    }

    public void setAddress(Address address) {
        this.address = address;
    }

    @Override
    public String toString() {
        return "Patient{" +
                "id=" + id +
                ", firstName='" + firstName + '\'' +
                ", lastName='" + lastName + '\'' +
                ", personId='" + personId + '\'' +
                ", nationalId='" + nationalId + '\'' +
                ", selfIdentifiedGender=" + selfIdentifiedGender +
                ", religion=" + religion +
                ", occupation=" + occupation +
                ", maritalStatus=" + maritalStatus +
                ", educationLevel=" + educationLevel +
                ", birthDate=" + birthDate +
                ", age=" + age +
                ", sex=" + sex +
                ", nationality=" + nationality +
                ", countryOfBirth=" + countryOfBirth +
                ", address=" + address +
                '}';
    }
}
