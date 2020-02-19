package zw.gov.mohcc.mrs.ehr_mobile.dto;

import androidx.annotation.NonNull;

import java.util.Date;

import zw.gov.mohcc.mrs.ehr_mobile.model.person.Address;
import zw.gov.mohcc.mrs.ehr_mobile.enumeration.Gender;

public class PatientDto {

    private int id;
    @NonNull
    private String firstName;
    @NonNull
    private String lastName;
    private String personId;
    @NonNull
    private Gender sex;
    private String identifier;
    private String nationalId;
    @NonNull
    private Date birthDate;
    @NonNull
    private Gender selfIdentifiedGender;
    @NonNull
    private String religionId;
    @NonNull
    private String occupationId;
    @NonNull
    private String maritalStatusId;
    @NonNull
    private String educationLevelId;
    @NonNull
    private String nationalityId;
    @NonNull
    private String countryOfBirthId;
    @NonNull
    private Address address;

    public PatientDto() {
    }

    public PatientDto(int id, String firstName, String lastName, Gender sex, String identifier, String nationalId, Gender selfIdentifiedGender, String religionId, String occupationId, String maritalStatusId, String educationLevelId, String nationalityId, String countryOfBirthId, Address address) {
        this.id = id;
        this.firstName = firstName;
        this.lastName = lastName;
        this.sex = sex;
        this.identifier = identifier;
        this.nationalId = nationalId;
        this.selfIdentifiedGender = selfIdentifiedGender;
        this.religionId = religionId;
        this.occupationId = occupationId;
        this.maritalStatusId = maritalStatusId;
        this.educationLevelId = educationLevelId;
        this.nationalityId = nationalityId;
        this.countryOfBirthId = countryOfBirthId;
        this.address = address;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getFirstName() {
        return firstName;
    }

    public void setFirstName(String firstName) {
        this.firstName = firstName;
    }

    public String getNationality() {
        return nationalityId;
    }

    public void setNationality(String nationalityId) {
        this.nationalityId = nationalityId;
    }

    public String getCountryOfBirth() {
        return countryOfBirthId;
    }

    public void setCountryOfBirth(String countryOfBirthId) {
        this.countryOfBirthId = countryOfBirthId;
    }

    public String getLastName() {
        return lastName;
    }

    public void setLastName(String lastName) {
        this.lastName = lastName;
    }

    public Gender getSex() {
        return sex;
    }

    public void setSex(Gender sex) {
        this.sex = sex;
    }

    public String getIdentifier() {
        return identifier;
    }

    public void setIdentifier(String identifier) {
        this.identifier = identifier;
    }

    public String getNationalId() {
        return nationalId;
    }

    public void setNationalId(String nationalId) {
        this.nationalId = nationalId;
    }


    public Gender getSelfIdentifiedGender() {
        return selfIdentifiedGender;
    }

    public void setSelfIdentifiedGender(Gender selfIdentifiedGender) {
        this.selfIdentifiedGender = selfIdentifiedGender;
    }

    public String getReligion() {
        return religionId;
    }

    public void setReligion(String religionId) {
        this.religionId = religionId;
    }

    public String getOccupation() {
        return occupationId;
    }

    public void setOccupation(String occupationId) {
        this.occupationId = occupationId;
    }

    public String getMaritalStatus() {
        return maritalStatusId;
    }

    public void setMaritalStatus(String maritalStatusId) {
        this.maritalStatusId = maritalStatusId;
    }

    public String getEducationLevel() {
        return educationLevelId;
    }

    public void setEducationLevel(String educationLevelId) {
        this.educationLevelId = educationLevelId;
    }

    public Address getAddress() {
        return address;
    }

    public void setAddress(Address address) {
        this.address = address;
    }

    public Date getBirthDate() {
        return birthDate;
    }

    public void setBirthDate(PastDate birthDate) {
        this.birthDate = birthDate != null ? birthDate.getPastDate() : null;
    }

    public String getPersonId() {
        return personId;
    }

    public void setPersonId(String personId) {
        this.personId = personId;
    }

    @Override
    public String toString() {
        return "PatientDto{" +
                "id=" + id +
                ", firstName='" + firstName + '\'' +
                ", lastName='" + lastName + '\'' +
                ", sex=" + sex +
                ", identifier='" + identifier + '\'' +
                ", nationalId='" + nationalId + '\'' +
                ", birthDate=" + birthDate +
                ", selfIdentifiedGender=" + selfIdentifiedGender +
                ", religionId='" + religionId + '\'' +
                ", occupationId='" + occupationId + '\'' +
                ", maritalStatusId='" + maritalStatusId + '\'' +
                ", educationLevelId='" + educationLevelId + '\'' +
                ", nationalityId='" + nationalityId + '\'' +
                ", countryOfBirthId='" + countryOfBirthId + '\'' +
                ", address=" + address +
                '}';
    }
}
