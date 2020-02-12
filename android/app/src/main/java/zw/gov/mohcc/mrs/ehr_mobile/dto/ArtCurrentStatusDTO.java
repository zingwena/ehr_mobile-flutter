package zw.gov.mohcc.mrs.ehr_mobile.dto;

import androidx.annotation.NonNull;
import androidx.room.TypeConverters;

import java.io.Serializable;
import java.util.Date;
import java.util.UUID;

import zw.gov.mohcc.mrs.ehr_mobile.converter.ArvStatusConverter;
import zw.gov.mohcc.mrs.ehr_mobile.converter.DateConverter;
import zw.gov.mohcc.mrs.ehr_mobile.converter.RegimenTypeConverter;
import zw.gov.mohcc.mrs.ehr_mobile.enumeration.ArvStatus;
import zw.gov.mohcc.mrs.ehr_mobile.enumeration.RegimenType;
import zw.gov.mohcc.mrs.ehr_mobile.model.art.ArtCurrentStatus;
import zw.gov.mohcc.mrs.ehr_mobile.model.terminology.ArtReason;
import zw.gov.mohcc.mrs.ehr_mobile.model.terminology.ArvCombinationRegimen;
import zw.gov.mohcc.mrs.ehr_mobile.model.terminology.NameCode;

public class ArtCurrentStatusDTO implements Serializable {

    @NonNull
    @TypeConverters(DateConverter.class)
    private Date date;
    @NonNull
    private String artId;
    @TypeConverters(ArvStatusConverter.class)
    @NonNull
    private ArvStatus state;
    @NonNull
    private String regimen;
    @NonNull
    private String reason;
    @TypeConverters(RegimenTypeConverter.class)
    private RegimenType regimenType;

    public ArtCurrentStatusDTO() {
    }

    public ArtCurrentStatusDTO(@NonNull Date date, @NonNull String artId, @NonNull ArvStatus state, @NonNull String regimen, @NonNull String reason, RegimenType regimenType) {
        this.date = date;
        this.artId = artId;
        this.state = state;
        this.regimen = regimen;
        this.reason = reason;
        this.regimenType = regimenType;
    }

    public static ArtCurrentStatus getInstance(ArtCurrentStatusDTO artCurrentStatusDTO, ArtReason artReason, ArvCombinationRegimen arvCombinationRegimen) {

        ArtCurrentStatus artCurrentStatus = new ArtCurrentStatus(UUID.randomUUID().toString(), artCurrentStatusDTO.getArtId());
        artCurrentStatus.setDate(new Date());
        artCurrentStatus.setState(ArvStatus.START_ARV);
        artCurrentStatus.setReason(new NameCode(artReason.getCode(), artReason.getName()));
        artCurrentStatus.setRegimen(new NameCode(arvCombinationRegimen.getCode(), arvCombinationRegimen.getName()));
        artCurrentStatus.setRegimenType(artCurrentStatusDTO.getRegimenType());

        return artCurrentStatus;
    }

    public static ArtCurrentStatusDTO get(ArtCurrentStatus artCurrentStatus) {

        return new ArtCurrentStatusDTO(artCurrentStatus.getDate(), artCurrentStatus.getArtId(),
                artCurrentStatus.getState(),
                artCurrentStatus.getRegimen() != null ? artCurrentStatus.getRegimen().getName() : null,
                artCurrentStatus.getReason() != null ? artCurrentStatus.getReason().getName() : null,
                artCurrentStatus.getRegimenType());
    }

    @NonNull
    public Date getDate() {
        return date;
    }

    public void setDate(@NonNull Date date) {
        this.date = date;
    }

    @NonNull
    public String getArtId() {
        return artId;
    }

    public void setArtId(@NonNull String artId) {
        this.artId = artId;
    }

    @NonNull
    public ArvStatus getState() {
        return state;
    }

    public void setState(@NonNull ArvStatus state) {
        this.state = state;
    }

    @NonNull
    public String getRegimen() {
        return regimen;
    }

    public void setRegimen(@NonNull String regimen) {
        this.regimen = regimen;
    }

    @NonNull
    public String getReason() {
        return reason;
    }

    public void setReason(@NonNull String reason) {
        this.reason = reason;
    }

    public RegimenType getRegimenType() {
        return regimenType;
    }

    public void setRegimenType(RegimenType regimenType) {
        this.regimenType = regimenType;
    }

    @Override
    public String toString() {
        return "ArtCurrentStatusDTO{" +
                "date=" + date +
                ", artId='" + artId + '\'' +
                ", state=" + state +
                ", regimen='" + regimen + '\'' +
                ", reason='" + reason + '\'' +
                ", regimenType=" + regimenType +
                '}';
    }
}
