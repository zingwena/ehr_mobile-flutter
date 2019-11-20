package zw.gov.mohcc.mrs.ehr_mobile.dto.builder;

import org.mapstruct.Mapper;
import org.mapstruct.Mapping;
import org.mapstruct.Mappings;

import zw.gov.mohcc.mrs.ehr_mobile.model.Hts;
import zw.gov.mohcc.mrs.sync.adapter.dto.HtsDto;

/**
 *  For mapping Hts to HtsDto
 */
@Mapper
public interface HtsDtoMapper {
    /**
     *
     * @param hts
     * @return
     */
    @Mappings({
            @Mapping(target="dateOfHivTest", source = "dateOfHivTest", dateFormat = "yyyy-MM-dd"),
            @Mapping(target="datePostTestCounselled", source = "datePostTestCounselled", dateFormat = "yyyy-MM-dd")
    })
    HtsDto htsToHtsDto(Hts hts);
}
