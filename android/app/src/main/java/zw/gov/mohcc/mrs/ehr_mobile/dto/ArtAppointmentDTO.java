package zw.gov.mohcc.mrs.ehr_mobile.dto;

import androidx.annotation.NonNull;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.UUID;

import zw.gov.mohcc.mrs.ehr_mobile.model.art.ArtAppointment;
import zw.gov.mohcc.mrs.ehr_mobile.model.terminology.FollowUpReason;
import zw.gov.mohcc.mrs.ehr_mobile.model.terminology.NameCode;

public class ArtAppointmentDTO implements Serializable {

    private String id;

    @NonNull
    private final String artId;
    @NonNull
    private final String reason;
    @NonNull
    private final Date date;

    public ArtAppointmentDTO(String id, @NonNull String artId, @NonNull String reason, @NonNull FutureDate date) {
        this.id = id;
        this.artId = artId;
        this.reason = reason;
        this.date = date != null ? date.getFutureDate() : null;
    }

    public static ArtAppointmentDTO get(ArtAppointment artAppointment) {

        return new ArtAppointmentDTO(artAppointment.getId(), artAppointment.getArtId(),
                artAppointment.getReason() != null ? artAppointment.getReason().getName() : null,
                artAppointment.getDate() != null ? new FutureDate(artAppointment.getDate()) : null);
    }

    public static List<ArtAppointmentDTO> get(List<ArtAppointment> artAppointments) {

        List<ArtAppointmentDTO> items = new ArrayList<>();
        for(ArtAppointment artAppointment : artAppointments){
            items.add(get(artAppointment));
        }
        return items;
    }

    @NonNull
    public String getArtId() {
        return artId;
    }

    @NonNull
    public String getReason() {
        return reason;
    }

    @NonNull
    public Date getDate() {
        return date;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public ArtAppointment getInstance(ArtAppointmentDTO dto, FollowUpReason followUpReason) {

        ArtAppointment artAppointment = new ArtAppointment(UUID.randomUUID().toString(), dto.getArtId());
        artAppointment.setReason(followUpReason != null ? new NameCode(followUpReason.getCode(), followUpReason.getName()) : null);
        artAppointment.setDate(dto.getDate());

        return artAppointment;
    }

    @Override
    public String toString() {
        return "ArtAppointmentDTO{" +
                "artId='" + artId + '\'' +
                ", reason='" + reason + '\'' +
                ", date=" + date +
                '}';
    }
}
