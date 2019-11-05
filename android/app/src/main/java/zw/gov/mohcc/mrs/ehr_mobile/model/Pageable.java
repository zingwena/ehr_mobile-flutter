package zw.gov.mohcc.mrs.ehr_mobile.model;

public class Pageable extends BasePageable {

    @Override
    public String getSort() {
        return super.getSort() + "name, asc";
    }

    @Override
    public int getSize() {
        return super.getSize() + 10000;
    }
}
