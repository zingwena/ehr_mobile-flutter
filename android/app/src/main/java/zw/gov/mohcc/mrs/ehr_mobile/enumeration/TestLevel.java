package zw.gov.mohcc.mrs.ehr_mobile.enumeration;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

public enum TestLevel {

    FIRST("FIRST"), SECOND("SECOND"), THIRD("THIRD"), PARALLEL_ONE("PARALLEL_ONE"),
    PARALLEL_TWO("PARALLEL_TWO"), SELF("SELF"), DNA_PCR("DNA_PCR");

    private final String testLevel;

    private TestLevel(String testLevel) {
        this.testLevel = testLevel;
    }

    public static TestLevel get(String name) {
        switch (name) {
            case "FIRST":
                return FIRST;
            case "SECOND":
                return SECOND;
            case "THIRD":
                return THIRD;
            case "PARALLEL_ONE":
                return PARALLEL_ONE;
            case "PARALLEL_TWO":
                return PARALLEL_TWO;
            case "SELF":
                return SELF;
            case "DNA_PCR":
                return DNA_PCR;
            default:
                throw new IllegalArgumentException("Unknown argument passed to method : " + name);
        }
    }

    public static List<TestLevel> getEhrTestLevels() {
        return new ArrayList<>(Arrays.asList(new TestLevel[] {FIRST, SECOND, THIRD}));
    }

    public String getTestLevel() {
        return testLevel;
    }

    @Override
    public String toString() {
        return this.name();
    }
}
