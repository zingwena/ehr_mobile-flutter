package zw.gov.mohcc.mrs.ehr_mobile.converter;

import androidx.room.TypeConverter;

import zw.gov.mohcc.mrs.ehr_mobile.enumeration.ActivityStatus;

public class ActivityStatusConverter {

    @TypeConverter
    public static ActivityStatus toActivityStatus(String activityStatus) {

        if (activityStatus.equals(ActivityStatus.DONE.getActivityStatus())) {
            return ActivityStatus.DONE;
        } else if (activityStatus.equals(ActivityStatus.NOT_DONE.getActivityStatus())) {
            return ActivityStatus.NOT_DONE;
        } else if (activityStatus.equals(ActivityStatus.UNKNOWN.getActivityStatus())) {
            return ActivityStatus.UNKNOWN;
        } else {
            return ActivityStatus.UNKNOWN;
        }
    }

    @TypeConverter
    public static String toString(ActivityStatus activityStatus) {
        if (activityStatus == null) {
            return null;
        }
        return activityStatus.getActivityStatus();
    }
}
