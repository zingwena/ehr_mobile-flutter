package zw.gov.mohcc.mrs.ehr_mobile.converter;

import androidx.room.TypeConverter;

import zw.gov.mohcc.mrs.ehr_mobile.enumeration.PrepOption;

public class PrepOptionConverter {

    @TypeConverter
    public static PrepOption toPrepOption(int prepOption) {

        if (prepOption == PrepOption.INFANT.getPrepOption()) {
            return PrepOption.INFANT;
        } else if (prepOption == PrepOption.PRE_EXPOSURE.getPrepOption()) {
            return PrepOption.PRE_EXPOSURE;
        } else if (prepOption == PrepOption.POST_EXPOSURE.getPrepOption()) {
            return PrepOption.POST_EXPOSURE;
        } else if (prepOption == PrepOption.NONE.getPrepOption()) {
            return PrepOption.NONE;
        } else {
            return PrepOption.NONE;
        }
    }

    @TypeConverter
    public static int toInt(PrepOption prepOption) {
        if (prepOption == null) {
            return -1;
        }
        return prepOption.getPrepOption();
    }
}
