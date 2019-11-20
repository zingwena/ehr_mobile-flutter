package zw.gov.mohcc.mrs.ehr_mobile.converter;

import androidx.room.TypeConverter;

import zw.gov.mohcc.mrs.ehr_mobile.enumeration.TestLevel;

public class TestLevelConverter {

    @TypeConverter
    public static TestLevel toTestLevel(int testLevel) {

        if (testLevel == TestLevel.FIRST.getTestLevel()) {
            return TestLevel.FIRST;
        } else if (testLevel == TestLevel.SECOND.getTestLevel()) {
            return TestLevel.SECOND;
        } else if (testLevel == TestLevel.THIRD.getTestLevel()) {
            return TestLevel.THIRD;
        } else if (testLevel == TestLevel.PARALLEL_ONE.getTestLevel()) {
            return TestLevel.PARALLEL_ONE;
        } else if (testLevel == TestLevel.PARALLEL_TWO.getTestLevel()) {
            return TestLevel.PARALLEL_TWO;
        } else if (testLevel == TestLevel.SELF.getTestLevel()) {
            return TestLevel.SELF;
        } else if (testLevel == TestLevel.DNA_PCR.getTestLevel()) {
            return TestLevel.DNA_PCR;
        }
        return null;
    }

    @TypeConverter
    public static int toInt(TestLevel testLevel) {
        if (testLevel == null) {
            return -1;
        }
        return testLevel.getTestLevel();
    }
}