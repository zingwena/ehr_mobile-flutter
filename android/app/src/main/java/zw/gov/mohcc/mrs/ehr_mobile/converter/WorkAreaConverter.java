package zw.gov.mohcc.mrs.ehr_mobile.converter;

import androidx.room.TypeConverter;

import zw.gov.mohcc.mrs.ehr_mobile.enumeration.WorkArea;

public class WorkAreaConverter {

    @TypeConverter
    public static WorkArea toWorkArea(int workArea) {

        if (workArea == WorkArea.PNC.getWorkArea()) {
            return WorkArea.PNC;
        } else if (workArea == WorkArea.IMNCI.getWorkArea()) {
            return WorkArea.IMNCI;
        } else if (workArea == WorkArea.ART.getWorkArea()) {
            return WorkArea.ART;
        } else if (workArea == WorkArea.TB.getWorkArea()) {
            return WorkArea.TB;
        } else if (workArea == WorkArea.ANC.getWorkArea()) {
            return WorkArea.ANC;
        } else if (workArea == WorkArea.PNC_MOTHER.getWorkArea()) {
            return WorkArea.PNC_MOTHER;
        } else if (workArea == WorkArea.PNC_CHILD.getWorkArea()) {
            return WorkArea.PNC_CHILD;
        } else if (workArea == WorkArea.ART_SIGN.getWorkArea()) {
            return WorkArea.ART_SIGN;
        } else if (workArea == WorkArea.ART_SYMPTOM.getWorkArea()) {
            return WorkArea.ART_SYMPTOM;
        } else if (workArea == WorkArea.ART_NEWOI.getWorkArea()) {
            return WorkArea.ART_NEWOI;
        } else if (workArea == WorkArea.ESSENTIAL_BABY_CARE.getWorkArea()) {
            return WorkArea.ESSENTIAL_BABY_CARE;
        } else if (workArea == WorkArea.MATERNAL.getWorkArea()) {
            return WorkArea.MATERNAL;
        } else if (workArea == WorkArea.HISTORY.getWorkArea()) {
            return WorkArea.HISTORY;
        } else if (workArea == WorkArea.MOTHER_PREGNANCY_DANGER_SIGNS.getWorkArea()) {
            return WorkArea.MOTHER_PREGNANCY_DANGER_SIGNS;
        } else if (workArea == WorkArea.BABY_PREGNANCY_DANGER_SIGNS.getWorkArea()) {
            return WorkArea.BABY_PREGNANCY_DANGER_SIGNS;
        } else if (workArea == WorkArea.HTS.getWorkArea()) {
            return WorkArea.HTS;
        } else if (workArea == WorkArea.SEXUAL_HISTORY.getWorkArea()) {
            return WorkArea.SEXUAL_HISTORY;
        }
        return null;
    }

    @TypeConverter
    public static int toInt(WorkArea workArea) {
        if (workArea == null) {
            return -1;
        }
        return workArea.getWorkArea();
    }
}