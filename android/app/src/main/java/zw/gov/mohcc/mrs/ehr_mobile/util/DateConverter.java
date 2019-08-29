package zw.gov.mohcc.mrs.ehr_mobile.util;

import androidx.room.TypeConverter;

import java.text.SimpleDateFormat;
import java.time.Instant;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.ZoneId;
import java.util.Date;
import java.util.TimeZone;
import java.util.logging.SimpleFormatter;

public class DateConverter {
    @TypeConverter
    public static Date fromTimestamp(Long value) {

        return value == null ? null : new Date(value);
    }

    @TypeConverter
    public static Long dateToTimestamp(Date dateTime) {
        return dateTime == null ? null : dateTime.getTime();
    }
}
