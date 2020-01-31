package zw.gov.mohcc.mrs.ehr_mobile.converter;

import androidx.room.TypeConverter;

import zw.gov.mohcc.mrs.ehr_mobile.enumeration.RecordStatus;


public class RecordStatusConvertor {

        @TypeConverter
        public static RecordStatus toRecordStatus(String status) {

            if (status.equals(RecordStatus.IMPORTED.getStatus())) {
                return RecordStatus.IMPORTED;
            } else if (status.equals(RecordStatus.SYNCED.getStatus())) {
                return RecordStatus.SYNCED;
            } else if (status.equals(RecordStatus.DELETED.getStatus())) {
                return RecordStatus.DELETED;
            } else if (status.equals(RecordStatus.CHANGED.getStatus())) {
                return RecordStatus.CHANGED;
            } else {
                return RecordStatus.NEW;
            }
        }

        @TypeConverter
        public static String toString(RecordStatus status) {
            if (status == null) {
                return null;
            }
            return status.getStatus();
        }
}
