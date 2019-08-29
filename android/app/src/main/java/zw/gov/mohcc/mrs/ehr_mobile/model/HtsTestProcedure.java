package zw.gov.mohcc.mrs.ehr_mobile.model;

/**
 * @author kombo on 8/27/19
 */
public class HtsTestProcedure {

    private int testCount=0;

    public HtsTestProcedure(InvestigationEhr investigation) {
    }


    public Integer getTestCount() {
        return testCount;
    }

    public void getTestKits(int testCount) {
        this.testCount=testCount;


    }
}
