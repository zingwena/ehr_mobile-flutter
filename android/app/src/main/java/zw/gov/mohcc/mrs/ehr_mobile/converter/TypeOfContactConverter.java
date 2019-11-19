package zw.gov.mohcc.mrs.ehr_mobile.converter;

import androidx.room.TypeConverter;

import zw.gov.mohcc.mrs.ehr_mobile.enumeration.Gender;
import zw.gov.mohcc.mrs.ehr_mobile.enumeration.TypeOfContact;

public class TypeOfContactConverter {

    @TypeConverter
    public static TypeOfContact toTypeOfContact(int typeOfContact) {

        if (typeOfContact == TypeOfContact.PRIMARY.getTypeOfContact()) {
            return TypeOfContact.PRIMARY;
        } else if (typeOfContact == TypeOfContact.SECONDARY.getTypeOfContact()) {
            return TypeOfContact.SECONDARY;
        }
        return null;
    }

    @TypeConverter
    public static int toInt(TypeOfContact typeOfContact) {
        if (typeOfContact == null) {
            return -1;
        }
        return typeOfContact.getTypeOfContact();
    }
}