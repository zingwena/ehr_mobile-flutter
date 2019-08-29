package zw.gov.mohcc.mrs.ehr_mobile.dto;

import java.util.Date;

import zw.gov.mohcc.mrs.ehr_mobile.model.Address;
import zw.gov.mohcc.mrs.ehr_mobile.model.Gender;
import zw.gov.mohcc.mrs.ehr_mobile.model.SelfIdentifiedGender;

public class PatientDto {

    private int id;
    private String firstName;
    private String lastName;
    private String personId;
    private Gender sex;
    private String identifier;
    private String nationalId;
    private Date birthDate;
    private SelfIdentifiedGender selfIdentifiedGender;
    private String religion;
    private String occupation;
    private String maritalStatus;
    private String educationLevel;
    private String nationality;
    private String countryOfBirth;
    private Address address;

    public PatientDto() {
    }

    public PatientDto(int id, String firstName, String lastName, Gender sex, String identifier, String nationalId, SelfIdentifiedGender selfIdentifiedGender, String religion, String occupation, String maritalStatus, String educationLevel, String nationality, String countryOfBirth, Address address) {
        this.id = id;
        this.firstName = firstName;
        this.lastName = lastName;
        this.sex = sex;
        this.identifier = identifier;
        this.nationalId = nationalId;
        this.selfIdentifiedGender = selfIdentifiedGender;
        this.religion = religion;
        this.occupation = occupation;
        this.maritalStatus = maritalStatus;
        this.educationLevel = educationLevel;
        this.nationality = nationality;
        this.countryOfBirth = countryOfBirth;
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
        return nationality;
    }

    public void setNationality(String nationality) {
        this.nationality = nationality;
    }

    public String getCountryOfBirth() {
        return countryOfBirth;
    }

    public void setCountryOfBirth(String countryOfBirth) {
        this.countryOfBirth = countryOfBirth;
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


    public SelfIdentifiedGender getSelfIdentifiedGender() {
        return selfIdentifiedGender;
    }

    public void setSelfIdentifiedGender(SelfIdentifiedGender selfIdentifiedGender) {
        this.selfIdentifiedGender = selfIdentifiedGender;
    }

    public String getReligion() {
        return religion;
    }

    public void setReligion(String religion) {
        this.religion = religion;
    }

    public String getOccupation() {
        return occupation;
    }

    public void setOccupation(String occupation) {
        this.occupation = occupation;
    }

    public String getMaritalStatus() {
        return maritalStatus;
    }

    public void setMaritalStatus(String maritalStatus) {
        this.maritalStatus = maritalStatus;
    }

    public String getEducationLevel() {
        return educationLevel;
    }

    public void setEducationLevel(String educationLevel) {
        this.educationLevel = educationLevel;
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

    public void setBirthDate(Date birthDate) {
        this.birthDate = birthDate;
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
                ", religion='" + religion + '\'' +
                ", occupation='" + occupation + '\'' +
                ", maritalStatus='" + maritalStatus + '\'' +
                ", educationLevel='" + educationLevel + '\'' +
                ", nationality='" + nationality + '\'' +
                ", countryOfBirth='" + countryOfBirth + '\'' +
                ", address=" + address +
                '}';
    }
}
