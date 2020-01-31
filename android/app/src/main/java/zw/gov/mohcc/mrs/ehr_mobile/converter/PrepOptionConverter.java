package zw.gov.mohcc.mrs.ehr_mobile.converter;

import androidx.room.TypeConverter;

import zw.gov.mohcc.mrs.ehr_mobile.enumeration.PrepOption;

public class PrepOptionConverter {

    @TypeConverter
    public static PrepOption toPrepOption(String prepOption) {

        if (prepOption.equals(PrepOption.INFANT.getPrepOption())) {
            return PrepOption.INFANT;
        } else if (prepOption.equals(PrepOption.PRE_EXPOSURE.getPrepOption())) {
            return PrepOption.PRE_EXPOSURE;
        } else if (prepOption.equals(PrepOption.POST_EXPOSURE.getPrepOption())) {
            return PrepOption.POST_EXPOSURE;
        } else if (prepOption.equals(PrepOption.NONE.getPrepOption())) {
            return PrepOption.NONE;
        } else {
            return PrepOption.NONE;
        }
    }

    @TypeConverter
    public static String toString(PrepOption prepOption) {
        if (prepOption == null) {
            return null;
        }
        return prepOption.getPrepOption();
    }
}
