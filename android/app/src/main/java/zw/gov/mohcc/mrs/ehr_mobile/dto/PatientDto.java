package zw.gov.mohcc.mrs.ehr_mobile.dto;

import java.time.LocalDateTime;

public class PatientDto {

    private int id;
    private String firstName;
    private String lastName;
    private String sex;
    private String identifier;
    private String nationalId;

    private int age;
    private LocalDateTime birthDate;
    private String selfIdentifiedGender;
    private String religion;
    private String occupation;
    private String maritalStatus;
    private String educationLevel;

    private String schoolHouse;
    private String suburbVillage;
    private String town;


    public PatientDto(int id, String firstName, String lastName, String sex, String identifier, String nationalId, int age, LocalDateTime birthDate, String selfIdentifiedGender, String religion, String occupation, String maritalStatus, String educationLevel, String schoolHouse, String suburbVillage, String town) {
        this.id = id;
        this.firstName = firstName;
        this.lastName = lastName;
        this.sex = sex;
        this.identifier = identifier;
        this.nationalId = nationalId;
        this.age = age;
        this.birthDate = birthDate;
        this.selfIdentifiedGender = selfIdentifiedGender;
        this.religion = religion;
        this.occupation = occupation;
        this.maritalStatus = maritalStatus;
        this.educationLevel = educationLevel;
        this.schoolHouse = schoolHouse;
        this.suburbVillage = suburbVillage;
        this.town = town;
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

    public String getLastName() {
        return lastName;
    }

    public void setLastName(String lastName) {
        this.lastName = lastName;
    }

    public String getSex() {
        return sex;
    }

    public void setSex(String sex) {
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

    public int getAge() {
        return age;
    }

    public void setAge(int age) {
        this.age = age;
    }

    public LocalDateTime getBirthDate() {
        return birthDate;
    }

    public void setBirthDate(LocalDateTime birthDate) {
        this.birthDate = birthDate;
    }

    public String getSelfIdentifiedGender() {
        return selfIdentifiedGender;
    }

    public void setSelfIdentifiedGender(String selfIdentifiedGender) {
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

    public String getSchoolHouse() {
        return schoolHouse;
    }

    public void setSchoolHouse(String schoolHouse) {
        this.schoolHouse = schoolHouse;
    }

    public String getSuburbVillage() {
        return suburbVillage;
    }

    public void setSuburbVillage(String suburbVillage) {
        this.suburbVillage = suburbVillage;
    }

    public String getTown() {
        return town;
    }

    public void setTown(String town) {
        this.town = town;
    }

    @Override
    public String toString() {
        return "PatientDto{" +
                "id=" + id +
                ", firstName='" + firstName + '\'' +
                ", lastName='" + lastName + '\'' +
                ", sex='" + sex + '\'' +
                ", identifier='" + identifier + '\'' +
                ", nationalId='" + nationalId + '\'' +
                ", age=" + age +
                ", birthDate=" + birthDate +
                ", selfIdentifiedGender='" + selfIdentifiedGender + '\'' +
                ", religion='" + religion + '\'' +
                ", occupation='" + occupation + '\'' +
                ", maritalStatus='" + maritalStatus + '\'' +
                ", educationLevel='" + educationLevel + '\'' +
                ", schoolHouse='" + schoolHouse + '\'' +
                ", suburbVillage='" + suburbVillage + '\'' +
                ", town='" + town + '\'' +
                '}';
    }
}
