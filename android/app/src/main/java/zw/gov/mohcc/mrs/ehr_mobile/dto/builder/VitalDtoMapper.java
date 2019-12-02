package zw.gov.mohcc.mrs.ehr_mobile.dto.builder;

import org.mapstruct.Mapper;
import org.mapstruct.Mapping;
import org.mapstruct.Mappings;

import zw.gov.mohcc.mrs.ehr_mobile.model.vitals.VitalsBaseEntityId;
import zw.gov.mohcc.mrs.sync.adapter.dto.VitalDto;

@Mapper
public interface VitalDtoMapper {
    /**
     *
     * @param vitalsBaseEntityId
     * @return VitalDto
     */
    @Mappings({@Mapping(target="dateTime", source = "dateTime", dateFormat = "yyyy-MM-dd")})
    VitalDto vitalToVitalDto(VitalsBaseEntityId vitalsBaseEntityId);
}
