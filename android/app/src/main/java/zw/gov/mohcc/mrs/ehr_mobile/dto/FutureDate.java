package zw.gov.mohcc.mrs.ehr_mobile.dto;

import java.util.Date;

public class FutureDate extends Date {

    private final Date futureDate;

    public FutureDate(Date futureDate) {

        if (futureDate.before(new Date())) {
            throw new IllegalStateException("Date cannot be in the past");
        }
        this.futureDate = futureDate;
    }

    public Date getFutureDate() {
        return futureDate;
    }
}
