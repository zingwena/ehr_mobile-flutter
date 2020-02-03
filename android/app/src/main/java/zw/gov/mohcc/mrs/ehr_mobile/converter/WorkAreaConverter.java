package zw.gov.mohcc.mrs.ehr_mobile.converter;

import androidx.room.TypeConverter;

import zw.gov.mohcc.mrs.ehr_mobile.enumeration.WorkArea;

public class WorkAreaConverter {

    @TypeConverter
    public static WorkArea toWorkArea(String workArea) {

        if (workArea == null) {
            return null;
        }
        if (workArea.equals(WorkArea.PNC.getWorkArea())) {
            return WorkArea.PNC;
        } else if (workArea.equals(WorkArea.IMNCI.getWorkArea())) {
            return WorkArea.IMNCI;
        } else if (workArea.equals(WorkArea.ART.getWorkArea())) {
            return WorkArea.ART;
        } else if (workArea.equals(WorkArea.TB.getWorkArea())) {
            return WorkArea.TB;
        } else if (workArea.equals(WorkArea.ANC.getWorkArea())) {
            return WorkArea.ANC;
        } else if (workArea.equals(WorkArea.PNC_MOTHER.getWorkArea())) {
            return WorkArea.PNC_MOTHER;
        } else if (workArea.equals(WorkArea.PNC_CHILD.getWorkArea())) {
            return WorkArea.PNC_CHILD;
        } else if (workArea.equals(WorkArea.ART_SIGN.getWorkArea())) {
            return WorkArea.ART_SIGN;
        } else if (workArea.equals(WorkArea.ART_SYMPTOM.getWorkArea())) {
            return WorkArea.ART_SYMPTOM;
        } else if (workArea.equals(WorkArea.ART_NEWOI.getWorkArea())) {
            return WorkArea.ART_NEWOI;
        } else if (workArea.equals(WorkArea.ESSENTIAL_BABY_CARE.getWorkArea())) {
            return WorkArea.ESSENTIAL_BABY_CARE;
        } else if (workArea.equals(WorkArea.MATERNAL.getWorkArea())) {
            return WorkArea.MATERNAL;
        } else if (workArea.equals(WorkArea.HISTORY.getWorkArea())) {
            return WorkArea.HISTORY;
        } else if (workArea.equals(WorkArea.MOTHER_PREGNANCY_DANGER_SIGNS.getWorkArea())) {
            return WorkArea.MOTHER_PREGNANCY_DANGER_SIGNS;
        } else if (workArea.equals(WorkArea.BABY_PREGNANCY_DANGER_SIGNS.getWorkArea())) {
            return WorkArea.BABY_PREGNANCY_DANGER_SIGNS;
        } else if (workArea.equals(WorkArea.HTS.getWorkArea())) {
            return WorkArea.HTS;
        } else if (workArea.equals(WorkArea.SEXUAL_HISTORY.getWorkArea())) {
            return WorkArea.SEXUAL_HISTORY;
        }
        return null;
    }

    @TypeConverter
    public static String toString(WorkArea workArea) {
        if (workArea == null) {
            return null;
        }
        return workArea.getWorkArea();
    }
}