package zw.gov.mohcc.mrs.ehr_mobile.converter;

import androidx.room.TypeConverter;

import zw.gov.mohcc.mrs.ehr_mobile.enumeration.FollowUpType;

public class FollowUpTypeConverter {

    @TypeConverter
    public static FollowUpType toFollowUpType(String followUpType) {

        if (followUpType == null) {
            return null;
        }
        if (followUpType.equals(FollowUpType.VISIT.getFollowUpType())) {
            return FollowUpType.VISIT;
        } else if (followUpType.equals(FollowUpType.VISIT.getFollowUpType())) {
            return FollowUpType.VISIT;
        }
        return null;
    }

    @TypeConverter
    public static String toString(FollowUpType followUpType) {
        if (followUpType == null) {
            return null;
        }
        return followUpType.getFollowUpType();
    }
}