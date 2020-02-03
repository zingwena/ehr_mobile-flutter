package zw.gov.mohcc.mrs.ehr_mobile.converter;

import androidx.room.TypeConverter;

import zw.gov.mohcc.mrs.ehr_mobile.enumeration.WhoStage;

public class WhoStageConverter {

    @TypeConverter
    public static WhoStage toWhoStage(String whoStage) {

        if (whoStage == null) {
            return null;
        }
        if (whoStage.equals(WhoStage.ONE.getWhoStage())) {
            return WhoStage.ONE;
        } else if (whoStage.equals(WhoStage.TWO.getWhoStage())) {
            return WhoStage.TWO;
        } else if (whoStage.equals(WhoStage.THREE.getWhoStage())) {
            return WhoStage.THREE;
        } else if (whoStage.equals(WhoStage.FOUR.getWhoStage())) {
            return WhoStage.FOUR;
        }
        return null;
    }

    @TypeConverter
    public static String toString(WhoStage whoStage) {
        if (whoStage == null) {
            return null;
        }
        return whoStage.getWhoStage();
    }
}
