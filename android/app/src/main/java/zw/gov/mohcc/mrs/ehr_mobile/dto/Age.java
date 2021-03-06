package zw.gov.mohcc.mrs.ehr_mobile.dto;

import android.util.Log;

import java.util.Calendar;
import java.util.Date;

import zw.gov.mohcc.mrs.ehr_mobile.model.person.Person;

public class Age {

    private int years;

    private int months;

    private int days;

    private Person person;

    private Age(Person person) {
        this.person = person;
    }

    private Age(int years, int months, int days) {
        this.years = years;
        this.months = months;
        this.days = days;
    }

    public static Age getInstance(Person person) {

        Log.d("Age Calculator", "This is person object : " + person);
        return AgeCalculator.calculateAge(person.getBirthDate());
    }

    public int getYears() {
        return years;
    }

    public int getMonths() {
        return months;
    }

    public int getDays() {
        return days;
    }

    private static class AgeCalculator {

        private static Age calculateAge(Date birthDate) {
            int years = 0;
            int months = 0;
            int days = 0;

            //create calendar object for birth day
            Calendar birthDay = Calendar.getInstance();
            birthDay.setTimeInMillis(birthDate.getTime());

            //create calendar object for current day
            long currentTime = System.currentTimeMillis();
            Calendar now = Calendar.getInstance();
            now.setTimeInMillis(currentTime);

            //Get difference between years
            years = now.get(Calendar.YEAR) - birthDay.get(Calendar.YEAR);
            int currMonth = now.get(Calendar.MONTH) + 1;
            int birthMonth = birthDay.get(Calendar.MONTH) + 1;

            //Get difference between months
            months = currMonth - birthMonth;

            //if month difference is in negative then reduce years by one
            //and calculate the number of months.
            if (months < 0) {
                years--;
                months = 12 - birthMonth + currMonth;
                if (now.get(Calendar.DATE) < birthDay.get(Calendar.DATE))
                    months--;
            } else if (months == 0 && now.get(Calendar.DATE) < birthDay.get(Calendar.DATE)) {
                years--;
                months = 11;
            }

            //Calculate the days
            if (now.get(Calendar.DATE) > birthDay.get(Calendar.DATE))
                days = now.get(Calendar.DATE) - birthDay.get(Calendar.DATE);
            else if (now.get(Calendar.DATE) < birthDay.get(Calendar.DATE)) {
                int today = now.get(Calendar.DAY_OF_MONTH);
                now.add(Calendar.MONTH, -1);
                days = now.getActualMaximum(Calendar.DAY_OF_MONTH) - birthDay.get(Calendar.DAY_OF_MONTH) + today;
            } else {
                days = 0;
                if (months == 12) {
                    years++;
                    months = 0;
                }
            }
            //Create new Age object
            return new Age(years, months, days);
        }

    }

    @Override
    public String toString() {
        return "Age{" +
                "years=" + years +
                ", months=" + months +
                ", days=" + days +
                '}';
    }
}
