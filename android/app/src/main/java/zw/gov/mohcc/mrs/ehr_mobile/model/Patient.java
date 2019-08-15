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

//@Entity(indices = {@Index("countryId"), @Index("educationLevelId"), @Index("nationalityId"), @Index("occupationId")},
//        foreignKeys = {
//                @ForeignKey(entity = Country.class, onDelete = CASCADE,
//                        parentColumns = "id",
//                        childColumns = "countryId"),
//                @ForeignKey(entity = EducationLevel.class, onDelete = CASCADE,
//                        parentColumns = "id",
//                        childColumns = "educationLevelId")
//                ,
//                @ForeignKey(entity = Religion.class, onDelete = CASCADE,
//                        parentColumns = "id",
//                        childColumns = "educationLevelId")
//                ,
//                @ForeignKey(entity = MaritalStatus.class, onDelete = CASCADE,
//                        parentColumns = "id",
//                        childColumns = "educationLevelId")
//                ,
//                @ForeignKey(entity = Nationality.class, onDelete = CASCADE,
//                        parentColumns = "id",
//                        childColumns = "nationalityId")
//                ,
//                @ForeignKey(entity = Occupation.class, onDelete = CASCADE,
//                        parentColumns = "id",
//                        childColumns = "occupationId")
//
//
//        }
//
//
//)
@Entity
public class Patient {
//    @TypeConverters(SelfIdentifiedGenderConverter.class)
//    public SelfIdentifiedGender selfIdentifiedGender;
//    @TypeConverters(GenderConverter.class)
//    public Gender sex;
    @PrimaryKey(autoGenerate = true)
    private int id;
    @NonNull
    private String firstName;
    @NonNull
    private String lastName;
    private String personId;
    private String nationalId;
//    @ColumnInfo(name = "religionId")
//    @NonNull
//    private String religionCode;
//    @ColumnInfo(name = "occupationId")
//    @NonNull
//    private String occupationCode;
//    @NonNull
//    @ColumnInfo(name = "maritalStatusId")
//    private String maritalStatusCode;
//    @ColumnInfo(name = "educationLevelId")
//    private String educationLevelCode;
//    @TypeConverters(DataConverter.class)
//    private LocalDate birthDate;
//    private int age;
//    @NonNull
//    @ColumnInfo(name = "nationalityId")
//    private String nationalityCode;
//    @NonNull
//    @ColumnInfo(name = "countryId")
//    private String countryOfBirthCode;
//    @Embedded
//    private Address address;
//

    public Patient() {
    }


    @Ignore
    public Patient(@NonNull String firstName, @NonNull String lastName) {
        this.firstName = firstName;
        this.lastName = lastName;

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

//    public SelfIdentifiedGender getSelfIdentifiedGender() {
//        return selfIdentifiedGender;
//    }
//
//    public void setSelfIdentifiedGender(SelfIdentifiedGender selfIdentifiedGender) {
//        this.selfIdentifiedGender = selfIdentifiedGender;
//    }
//
//    public Gender getSex() {
//        return sex;
//    }
//
//    public void setSex(Gender sex) {
//        this.sex = sex;
//    }

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

//
//    public LocalDate getBirthDate() {
//        return birthDate;
//    }
//
//    public void setBirthDate(LocalDate birthDate) {
//        this.birthDate = birthDate;
//    }
//
//    public int getAge() {
//        return age;
//    }
//
//    public void setAge(int age) {
//        this.age = age;
//    }
//
//
//    public Address getAddress() {
//        return address;
//    }
//
//    public void setAddress(Address address) {
//        this.address = address;
//    }
//
//    public String getReligionCode() {
//        return religionCode;
//    }
//
//    public void setReligionCode(String religionCode) {
//        this.religionCode = religionCode;//    @Ignore
//    public Patient(@NonNull String firstName, @NonNull String lastName, @NonNull Gender sex) {
//        this.firstName = firstName;
//        this.lastName = lastName;
//        this.sex = sex;
//    }

//    }
//
//    public String getOccupationCode() {
//        return occupationCode;
//    }
//
//    public void setOccupationCode(String occupationCode) {
//        this.occupationCode = occupationCode;
//    }
//
//    public String getMaritalStatusCode() {
//        return maritalStatusCode;
//    }
//
//    public void setMaritalStatusCode(String maritalStatusCode) {
//        this.maritalStatusCode = maritalStatusCode;
//    }
//
//    public String getEducationLevelCode() {
//        return educationLevelCode;
//    }
//
//    public void setEducationLevelCode(String educationLevelCode) {
//        this.educationLevelCode = educationLevelCode;
//    }
//
//    public String getNationalityCode() {
//        return nationalityCode;
//    }
//
//    public void setNationalityCode(String nationalityCode) {
//        this.nationalityCode = nationalityCode;
//    }
//
//    public String getCountryOfBirthCode() {
//        return countryOfBirthCode;
//    }
//
//    public void setCountryOfBirthCode(String countryOfBirthCode) {
//        this.countryOfBirthCode = countryOfBirthCode;
//
//    }


    @Override
    public String toString() {
        return "Patient{" +
                "id=" + id +
                ", firstName='" + firstName + '\'' +
                ", lastName='" + lastName + '\'' +
                ", personId='" + personId + '\'' +
                ", nationalId='" + nationalId + '\'' +
                '}';
    }
}
