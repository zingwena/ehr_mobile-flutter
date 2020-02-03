package zw.gov.mohcc.mrs.ehr_mobile.converter;

import androidx.room.TypeConverter;

import zw.gov.mohcc.mrs.ehr_mobile.enumeration.QuestionType;

public class QuestionTyeConverter {

    @TypeConverter
    public static QuestionType toQuestionTye(String questionTye) {

        if (questionTye == null) {
            return null;
        }
        if (questionTye.equals(QuestionType.BOOLEAN.getQuestionTye())) {
            return QuestionType.BOOLEAN;
        } else if (questionTye.equals(QuestionType.TEXT.getQuestionTye())) {
            return QuestionType.TEXT;
        } else if (questionTye.equals(QuestionType.SET.getQuestionTye())) {
            return QuestionType.SET;
        } else if (questionTye.equals(QuestionType.NUMERIC.getQuestionTye())) {
            return QuestionType.NUMERIC;
        } else if (questionTye.equals(QuestionType.SKIN_PINCH.getQuestionTye())) {
            return QuestionType.SKIN_PINCH;
        } else if (questionTye.equals(QuestionType.VITAL.getQuestionTye())) {
            return QuestionType.VITAL;
        } else if (questionTye.equals(QuestionType.INVESTIGATION.getQuestionTye())) {
            return QuestionType.INVESTIGATION;
        }
        return null;
    }

    @TypeConverter
    public static String toInt(QuestionType questionTye) {
        return questionTye.getQuestionTye();
    }
}

