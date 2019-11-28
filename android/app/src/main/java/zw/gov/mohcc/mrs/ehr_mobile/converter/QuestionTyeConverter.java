package zw.gov.mohcc.mrs.ehr_mobile.converter;

import androidx.room.TypeConverter;

import zw.gov.mohcc.mrs.ehr_mobile.enumeration.QuestionType;

public class QuestionTyeConverter {

    @TypeConverter
    public static QuestionType toQuestionTye(int questionTye) {

        if (questionTye == QuestionType.BOOLEAN.getQuestionTye()) {
            return QuestionType.BOOLEAN;
        } else if (questionTye == QuestionType.TEXT.getQuestionTye()) {
            return QuestionType.TEXT;
        } else if (questionTye == QuestionType.SET.getQuestionTye()) {
            return QuestionType.SET;
        } else if (questionTye == QuestionType.NUMERIC.getQuestionTye()) {
            return QuestionType.NUMERIC;
        } else if (questionTye == QuestionType.SKIN_PINCH.getQuestionTye()) {
            return QuestionType.SKIN_PINCH;
        } else if (questionTye == QuestionType.VITAL.getQuestionTye()) {
            return QuestionType.VITAL;
        } else if (questionTye == QuestionType.INVESTIGATION.getQuestionTye()) {
            return QuestionType.INVESTIGATION;
        }
        return null;
    }

    @TypeConverter
    public static int toInt(QuestionType questionTye) {
        return questionTye.getQuestionTye();
    }
}

