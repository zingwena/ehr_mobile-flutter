package zw.gov.mohcc.mrs.ehr_mobile.util;

import androidx.room.TypeConverter;

import zw.gov.mohcc.mrs.ehr_mobile.enums.RecordStatus;

public class RecordStatusConvertor {

        @TypeConverter
        public static RecordStatus toRecordStatus(int status) {

            if (status == RecordStatus.IMPORTED.getStatus()) {
                return RecordStatus.IMPORTED;
            } else if (status == RecordStatus.SYNCED.getStatus()) {
                return RecordStatus.SYNCED;
            } else if (status == RecordStatus.DELETED.getStatus()) {
                return RecordStatus.DELETED;
            } else if (status == RecordStatus.CHANGED.getStatus()) {
                return RecordStatus.CHANGED;
            } else {
                return RecordStatus.NEW;
            }
        }

        @TypeConverter
        public static int toInt(RecordStatus status) {
            if (status == null) {
                return 0;
            }
            return status.getStatus();
        }
}
