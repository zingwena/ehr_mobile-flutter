package zw.gov.mohcc.mrs.ehr_mobile.dto;

import android.util.Log;

import androidx.annotation.NonNull;
import androidx.room.Ignore;

import java.io.Serializable;
import java.util.Date;

import zw.gov.mohcc.mrs.ehr_mobile.model.art.ArtIpt;
import zw.gov.mohcc.mrs.ehr_mobile.model.terminology.IptReason;
import zw.gov.mohcc.mrs.ehr_mobile.model.terminology.IptStatus;
import zw.gov.mohcc.mrs.ehr_mobile.model.terminology.NameCode;

public class ArtIptDTO implements Serializable {

    @NonNull
    private String artId;
    @NonNull
    private Date date;
    @NonNull
    private String iptStatus;
    @NonNull
    private String reason;
    private final String TAG = "ART Channel";


    public ArtIptDTO() {
    }

    @Ignore
    public ArtIptDTO(@NonNull String artId, @NonNull Date date, String iptStatus, String reason) {
        this.artId = artId;
        this.date = date;
        this.iptStatus = iptStatus;
        this.reason = reason;
    }

    public static ArtIptDTO get(ArtIpt artIpt) {

        return new ArtIptDTO(artIpt.getArtId(), artIpt.getDate(),
                artIpt.getIptStatus() != null ? artIpt.getIptStatus().getName() : null,
                artIpt.getReason() != null ? artIpt.getReason().getName() : null);
    }

    @NonNull
    public String getArtId() {
        return artId;
    }

    public void setArtId(@NonNull String artId) {
        this.artId = artId;
    }

    @NonNull
    public Date getDate() {
        return date;
    }

    public void setDate(@NonNull Date date) {
        this.date = date;
    }

    @NonNull
    public String getIptStatus() {
        return iptStatus;
    }

    public void setIptStatus(@NonNull String iptStatus) {
        this.iptStatus = iptStatus;
    }

    @NonNull
    public String getReason() {
        return reason;
    }

    public void setReason(@NonNull String reason) {
        this.reason = reason;
    }

    public ArtIpt getInstance(ArtIptDTO dto, IptStatus iptStatus, IptReason iptReason) {
        Log.d(TAG, "ART DTO :  "+ dto.toString());
        Log.d(TAG, "IPT STATUS :  "+ iptStatus.toString());
        Log.d(TAG, "IPT REASON in get ARTIPTDTO:  "+ iptReason.toString());



        return new ArtIpt(dto.getArtId(),dto.getArtId(),dto.getDate(),
                new NameCode(iptStatus.getCode(), iptStatus.getName()), new NameCode(iptReason.getCode(), iptReason.getName()));
    }

    @Override
    public String toString() {
        return "ArtIptDTO{" +
                "artId='" + artId + '\'' +
                ", date='" + date + '\'' +
                ", iptStatus='" + iptStatus + '\'' +
                ", reason='" + reason + '\'' +
                '}';
    }
}
