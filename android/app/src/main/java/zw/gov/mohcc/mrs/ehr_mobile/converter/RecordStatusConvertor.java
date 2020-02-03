package zw.gov.mohcc.mrs.ehr_mobile.converter;

import android.util.Log;

import androidx.room.TypeConverter;

import zw.gov.mohcc.mrs.ehr_mobile.enumeration.RecordStatus;


public class RecordStatusConvertor {

        @TypeConverter
        public static RecordStatus toRecordStatus(String status) {

            if (status == null) {
                return null;
            }
            if (RecordStatus.IMPORTED.getStatus().equals(status)) {
                return RecordStatus.IMPORTED;
            } else if (RecordStatus.SYNCED.getStatus().equals(status)) {
                return RecordStatus.SYNCED;
            } else if (RecordStatus.DELETED.getStatus().equals(status)) {
                return RecordStatus.DELETED;
            } else if (RecordStatus.CHANGED.getStatus().equals(status)) {
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
