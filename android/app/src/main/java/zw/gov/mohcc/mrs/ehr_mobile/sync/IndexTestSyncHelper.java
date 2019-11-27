package zw.gov.mohcc.mrs.ehr_mobile.sync;

import org.mapstruct.factory.Mappers;

import zw.gov.mohcc.mrs.ehr_mobile.dto.builder.IndexTestDtoMapper;
import zw.gov.mohcc.mrs.ehr_mobile.model.hts.IndexTest;
import zw.gov.mohcc.mrs.ehr_mobile.persistance.database.EhrMobileDatabase;
import zw.gov.mohcc.mrs.sync.adapter.dto.IndexTestDto;

public class IndexTestSyncHelper {

    private EhrMobileDatabase ehrMobileDatabase;
    public IndexTestSyncHelper(EhrMobileDatabase ehrMobileDatabase){
        this.ehrMobileDatabase=ehrMobileDatabase;
    }

    public IndexTestDto getIndexTest(String personId){
        IndexTest indexTest = ehrMobileDatabase.indexTestDao().findByPersonId(personId);
        IndexTestDtoMapper mapper= Mappers.getMapper(IndexTestDtoMapper.class);
        IndexTestDto dto=mapper.indexTestToIndexTestDto(indexTest);
        return dto;
    }
}
