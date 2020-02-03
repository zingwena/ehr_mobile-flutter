package zw.gov.mohcc.mrs.ehr_mobile.converter;

import androidx.room.TypeConverter;

import zw.gov.mohcc.mrs.ehr_mobile.enumeration.TestLevel;

public class TestLevelConverter {

    @TypeConverter
    public static TestLevel toTestLevel(String testLevel) {

        if (testLevel == null) {
            return null;
        }
        if (testLevel.equals(TestLevel.FIRST.getTestLevel())) {
            return TestLevel.FIRST;
        } else if (testLevel.equals(TestLevel.SECOND.getTestLevel())) {
            return TestLevel.SECOND;
        } else if (testLevel.equals(TestLevel.THIRD.getTestLevel())) {
            return TestLevel.THIRD;
        } else if (testLevel.equals(TestLevel.PARALLEL_ONE.getTestLevel())) {
            return TestLevel.PARALLEL_ONE;
        } else if (testLevel.equals(TestLevel.PARALLEL_TWO.getTestLevel())) {
            return TestLevel.PARALLEL_TWO;
        } else if (testLevel.equals(TestLevel.SELF.getTestLevel())) {
            return TestLevel.SELF;
        } else if (testLevel.equals(TestLevel.DNA_PCR.getTestLevel())) {
            return TestLevel.DNA_PCR;
        }
        return null;
    }

    @TypeConverter
    public static String toString(TestLevel testLevel) {
        if (testLevel == null) {
            return null;
        }
        return testLevel.getTestLevel();
    }
}