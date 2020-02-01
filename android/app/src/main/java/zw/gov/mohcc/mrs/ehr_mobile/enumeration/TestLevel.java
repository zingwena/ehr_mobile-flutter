package zw.gov.mohcc.mrs.ehr_mobile.enumeration;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

public enum TestLevel {

    FIRST("FIRST"), SECOND("SECOND"), THIRD("THIRD"), PARALLEL_ONE("PARALLEL_ONE"),
    PARALLEL_TWO("PARALLEL_TWO"), SELF("SELF"), DNA_PCR("DNA_PCR");

    private final String testLevel;

    TestLevel(String testLevel) {
        this.testLevel = testLevel;
    }

    public static TestLevel get(String name) {

        for (TestLevel item : values()) {
            if (item.getTestLevel().equals(name)) {
                return item;
            }
        }
        throw new IllegalArgumentException("Unknown argument passes to method : " + name);
    }

    public static List<TestLevel> getEhrTestLevels() {
        return new ArrayList<>(Arrays.asList(FIRST, SECOND, THIRD));
    }

    public String getTestLevel() {
        return testLevel;
    }

    @Override
    public String toString() {
        return this.name();
    }
}
