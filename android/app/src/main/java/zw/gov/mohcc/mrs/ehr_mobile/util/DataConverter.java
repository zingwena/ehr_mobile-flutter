package zw.gov.mohcc.mrs.ehr_mobile.util;

import android.os.Build;

import androidx.annotation.RequiresApi;
import androidx.room.TypeConverter;

import java.time.LocalDate;
import java.time.LocalDateTime;



public class DataConverter {
    @RequiresApi(api = Build.VERSION_CODES.O)
    @TypeConverter
    public static LocalDate toDate(String dateString) {
        if (dateString == null) {
            return null;
        } else {
            System.out.println("dateString = " + dateString);
            return LocalDate.parse(dateString);
        }
    }

    @TypeConverter
    public static String fromDateString(LocalDate date) {
        if (date == null) {
            return null;
        } else {
            return date.toString();
        }
    }



}