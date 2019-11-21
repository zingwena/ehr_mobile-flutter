package zw.gov.mohcc.mrs.ehr_mobile.dto;

import zw.gov.mohcc.mrs.ehr_mobile.model.person.Person;

public class Age {

    private int years;

    private int months;

    private int totalMonths;

    private Person person;

    private Age (Person person) {
        this.person = person;
    }

    private Age(int years, int months, int totalMonths) {
        this.years = years;
        this.months = months;
        this.totalMonths = totalMonths;
    }

    public static Age getInstance(Person person) {
        Age age = new Age(person);

        return age;
    }

    public int getYears() {
        return years;
    }

    public int getMonths() {
        return months;
    }

    public int getTotalMonths() {
        return totalMonths;
    }
}
