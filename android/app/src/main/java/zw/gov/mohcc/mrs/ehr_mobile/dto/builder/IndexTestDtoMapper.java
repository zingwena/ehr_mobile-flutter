package zw.gov.mohcc.mrs.ehr_mobile.dto.builder;

import org.mapstruct.Mapper;
import org.mapstruct.Mapping;
import org.mapstruct.Mappings;

import zw.gov.mohcc.mrs.ehr_mobile.model.hts.IndexTest;
import zw.gov.mohcc.mrs.sync.adapter.dto.IndexTestDto;

@Mapper
public interface IndexTestDtoMapper {

    /**
     *
     * @param indexTest
     * @return VitalDto
     */
    @Mappings({@Mapping(target="date", source = "date", dateFormat = "yyyy-MM-dd")})
    IndexTestDto indexTestToIndexTestDto(IndexTest indexTest);
}
