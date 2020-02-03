package zw.gov.mohcc.mrs.ehr_mobile.converter;

import androidx.room.TypeConverter;

import zw.gov.mohcc.mrs.ehr_mobile.enumeration.ReasonOfNotDisclosing;

public class ReasonOfNotDisclosingConverter {

    @TypeConverter
    public static ReasonOfNotDisclosing toReasonOfNotDisclosing(String reasonOfNotDisclosing) {

        if (reasonOfNotDisclosing.equals(ReasonOfNotDisclosing.FEAR.getReasonOfNotDisclosing())) {
            return ReasonOfNotDisclosing.FEAR;
        } else if (reasonOfNotDisclosing.equals(ReasonOfNotDisclosing.NOT_READY.getReasonOfNotDisclosing())) {
            return ReasonOfNotDisclosing.NOT_READY;
        } else if (reasonOfNotDisclosing.equals(ReasonOfNotDisclosing.PHYSICAL_ABUSE.getReasonOfNotDisclosing())) {
            return ReasonOfNotDisclosing.PHYSICAL_ABUSE;
        }
        return null;
    }

    @TypeConverter
    public static String toString(ReasonOfNotDisclosing reasonOfNotDisclosing) {
        if (reasonOfNotDisclosing == null) {
            return null;
        }
        return reasonOfNotDisclosing.getReasonOfNotDisclosing();
    }
}
