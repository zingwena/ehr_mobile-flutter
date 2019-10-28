package zw.gov.mohcc.mrs.ehr_mobile.util;

import java.util.Calendar;
import java.util.Date;

public class DateUtil {

    private DateUtil() {
        throw new IllegalArgumentException("Class not meant for construction of objects");
    }

    public static Date getDateFromAge(Integer age) {
        Calendar cal = Calendar.getInstance();
        cal.setTime(new Date());
        cal.add(Calendar.YEAR, -age);
        cal.set(Calendar.MONTH, cal.get(Calendar.MONTH) - 11);
        cal.set(Calendar.DAY_OF_MONTH, getMonthEndDate(cal.getTime()) - 1);
        return cal.getTime();
    }

    public static Date getDateDiff() {
        Calendar cal = Calendar.getInstance();
        cal.setTime(new Date());
        cal.add(Calendar.MINUTE, -20);
        return cal.getTime();
    }

    private static Integer getMonthEndDate(Date date) {
        Calendar cal = Calendar.getInstance();
        cal.setTime(date);
        return cal.getActualMaximum(Calendar.DAY_OF_MONTH);
    }

    public static Date getStartOfDay(Date date) {
        Calendar cal = Calendar.getInstance();
        cal.setTime(date);
        cal.set(Calendar.HOUR_OF_DAY, cal.getActualMinimum(Calendar.HOUR_OF_DAY));
        return cal.getTime();
    }

    public static Date getEndOfDay(Date date) {
        Calendar cal = Calendar.getInstance();
        cal.setTime(date);
        cal.set(Calendar.HOUR_OF_DAY, cal.getActualMaximum(Calendar.HOUR_OF_DAY));
        return cal.getTime();
    }
}
