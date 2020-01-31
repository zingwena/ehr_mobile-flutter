package zw.gov.mohcc.mrs.ehr_mobile.converter;

import androidx.room.TypeConverter;

import zw.gov.mohcc.mrs.ehr_mobile.enumeration.Gender;
import zw.gov.mohcc.mrs.ehr_mobile.enumeration.TypeOfContact;

public class TypeOfContactConverter {

    @TypeConverter
    public static TypeOfContact toTypeOfContact(String typeOfContact) {

        if (typeOfContact.equals(TypeOfContact.PRIMARY.getTypeOfContact())) {
            return TypeOfContact.PRIMARY;
        } else if (typeOfContact.equals(TypeOfContact.SECONDARY.getTypeOfContact())) {
            return TypeOfContact.SECONDARY;
        }
        return null;
    }

    @TypeConverter
    public static String toString(TypeOfContact typeOfContact) {
        if (typeOfContact == null) {
            return null;
        }
        return typeOfContact.getTypeOfContact();
    }
}