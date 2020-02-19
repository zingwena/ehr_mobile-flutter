package zw.gov.mohcc.mrs.ehr_mobile.dto;

import android.util.Log;

import java.util.Date;

public class PastDate extends Date {

    private final Date pastDate;
    private final String TAG = "Past Date";

    public PastDate(Date pastDate) {
        super();
        if (pastDate.after(new Date())) {
            throw new IllegalStateException("Date cannot be in the future");
        }
        Log.d(TAG, "Past date being called here : " + pastDate);
        this.pastDate = pastDate;
    }

    public Date getPastDate() {
        return pastDate;
    }
}
