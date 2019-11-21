package zw.gov.mohcc.mrs.ehr_mobile.enumeration;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

public enum TestLevel {

    FIRST(0), SECOND(1), THIRD(2), PARALLEL_ONE(3), PARALLEL_TWO(4), SELF(5), DNA_PCR(6);

    private final int testLevel;

    private TestLevel(int testLevel) {
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

    public int getTestLevel() {
        return testLevel;
    }

    @Override
    public String toString() {
        return this.name();
    }
}
