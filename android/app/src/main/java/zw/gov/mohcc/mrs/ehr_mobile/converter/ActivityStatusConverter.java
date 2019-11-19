package zw.gov.mohcc.mrs.ehr_mobile.converter;

import androidx.room.TypeConverter;

import zw.gov.mohcc.mrs.ehr_mobile.enumeration.ActivityStatus;

public class ActivityStatusConverter {

    @TypeConverter
    public static ActivityStatus toActivityStatus(int activityStatus) {

        if (activityStatus == ActivityStatus.DONE.getActivityStatus()) {
            return ActivityStatus.DONE;
        } else if (activityStatus == ActivityStatus.NOT_DONE.getActivityStatus()) {
            return ActivityStatus.NOT_DONE;
        } else if (activityStatus == ActivityStatus.UNKNOWN.getActivityStatus()) {
            return ActivityStatus.UNKNOWN;
        } else {
            return ActivityStatus.UNKNOWN;
        }
    }

    @TypeConverter
    public static int toInt(ActivityStatus activityStatus) {
        if (activityStatus == null) {
            return -1;
        }
        return activityStatus.getActivityStatus();
    }
}
