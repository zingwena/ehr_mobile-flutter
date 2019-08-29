package zw.gov.mohcc.mrs.ehr_mobile.model;

import androidx.room.Entity;

@Entity
public class Result {

    private String _01 = "NEGATIVE";
    private  String _02 = "POSITIVE";
    private  String _03 = "INCONCLUSIVE";

    public String get_01() {
        return _01;
    }

    public void set_01(String _01) {
        this._01 = _01;
    }

    public String get_02() {
        return _02;
    }

    public void set_02(String _02) {
        this._02 = _02;
    }

    public String get_03() {
        return _03;
    }

    public void set_03(String _03) {
        this._03 = _03;
    }
}
