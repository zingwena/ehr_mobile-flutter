package zw.gov.mohcc.mrs.ehr_mobile.model;

import androidx.annotation.NonNull;
import androidx.room.Embedded;
import androidx.room.Entity;
import androidx.room.Ignore;
import androidx.room.PrimaryKey;
import androidx.room.TypeConverters;

import java.util.Date;

import zw.gov.mohcc.mrs.ehr_mobile.util.GenderConverter;
import zw.gov.mohcc.mrs.ehr_mobile.util.SelfIdentifiedGenderConverter;

@Entity()
public class Patient {
    @TypeConverters(SelfIdentifiedGenderConverter.class)
    public SelfIdentifiedGender selfIdentifiedGender;
    @TypeConverters(GenderConverter.class)
    public Gender sex;
    @PrimaryKey(autoGenerate = true)
    private int id;
    @NonNull
    private String firstName;
    @NonNull
    private String lastName;
    private String personId;
    private String nationalId;
    /*private Religion religion;


    private Occupation occupation;


    private MaritalStatus maritalStatus;


    private EducationLevel educationLevel;*/
    private Date birthDate;
    private int age;
    /*@Embedded
    private Nationality nationality;

    @Embedded
    private Country countryOfBirth;*/
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

    public void setFirstName(@NonNull String firstName) {
        this.firstName = firstName;
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
                ", birthDate=" + birthDate +
                ", age=" + age +
                ", sex=" + sex +
                ", address=" + address +
                '}';
    }
}
