package com.example.ehr_mobile.model;

import androidx.annotation.NonNull;
import androidx.room.Entity;
import androidx.room.Ignore;
import androidx.room.PrimaryKey;

import java.time.LocalDate;
import java.util.Date;

@Entity
public class Patient {
    @PrimaryKey(autoGenerate = true)
    private int id;

    @NonNull
    private String firstName;
    @NonNull
    private String lastName;

    @NonNull
    private String sex;


    private String identifier;
    private String number;


    private String selfIdentifiedGender;
    private String religion;
    private String occupation;
    private String maritalStatus;
    private String educationLevel;

    private String birthDate;
    private int age;


    private String schoolHouse;
    private String suburbVillage;
    private String town;

    public Patient() {
    }

    @Ignore
    public Patient(@NonNull String firstName, @NonNull String lastName, @NonNull String sex) {
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

    public String getIdentifier() {
        return identifier;
    }

    public void setIdentifier(String identifier) {
        this.identifier = identifier;
    }

    public String getNumber() {
        return number;
    }

    public void setNumber(String number) {
        this.number = number;
    }


    @NonNull
    public String getFirstName() {
        return firstName;
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


    @NonNull
    public String getSex() {
        return sex;
    }

    public void setSex(@NonNull String sex) {
        this.sex = sex;
    }

    @NonNull
    public String getBirthDate() {
        return birthDate;
    }

    public void setBirthDate(@NonNull String birthDate) {
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

    public int getAge() {
        return age;
    }

    public void setAge(int age) {
        this.age = age;
    }

    @Override
    public String toString() {
        return "Patient{" +
                "id=" + id +
                ", firstName='" + firstName + '\'' +
                ", lastName='" + lastName + '\'' +
                ", sex='" + sex + '\'' +
                ", identifier='" + identifier + '\'' +
                ", number='" + number + '\'' +
                ", selfIdentifiedGender='" + selfIdentifiedGender + '\'' +
                ", religion='" + religion + '\'' +
                ", occupation='" + occupation + '\'' +
                ", maritalStatus='" + maritalStatus + '\'' +
                ", educationLevel='" + educationLevel + '\'' +
                ", birthDate=" + birthDate +
                ", age=" + age +
                ", schoolHouse='" + schoolHouse + '\'' +
                ", suburbVillage='" + suburbVillage + '\'' +
                ", town='" + town + '\'' +
                '}';
    }
}
