package zw.gov.mohcc.mrs.ehr_mobile.util;

import com.google.gson.JsonDeserializationContext;
import com.google.gson.JsonDeserializer;
import com.google.gson.JsonElement;
import com.google.gson.JsonParseException;

import java.lang.reflect.Type;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.TimeZone;

public class DateDeserializer implements JsonDeserializer<Date> {

    @Override
    public Date deserialize(JsonElement element, Type arg1, JsonDeserializationContext arg2) throws JsonParseException {
        String date = element.getAsString();

        SimpleDateFormat format = new SimpleDateFormat("yyyy/MM/dd kk:mm:ss Z");
//        format.setTimeZone(TimeZone.getTimeZone("GMT"));

        try {
            return format.parse(date);
        } catch (ParseException exp) {
            System.err.println("Failed to parse Date:" + exp);
            return null;
        }
    }


}

