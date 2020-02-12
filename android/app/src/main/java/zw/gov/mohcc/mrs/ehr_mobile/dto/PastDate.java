package zw.gov.mohcc.mrs.ehr_mobile.dto;

import java.util.Date;

public class PastDate extends Date {

    private final Date pastDate;

    public PastDate(Date pastDate) {

        if (pastDate.after(new Date())) {
            throw new IllegalStateException("Date cannot be in the future");
        }
        this.pastDate = pastDate;
    }

    public Date getPastDate() {
        return pastDate;
    }
}
