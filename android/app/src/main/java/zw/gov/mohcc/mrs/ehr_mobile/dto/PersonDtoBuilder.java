package zw.gov.mohcc.mrs.ehr_mobile.dto;

import org.jetbrains.annotations.NotNull;

import java.text.SimpleDateFormat;

import zw.gov.mohcc.mrs.ehr_mobile.model.Person;
import zw.gov.mohcc.mrs.sync.adapter.dto.PersonDto;

public class PersonDtoBuilder {

    private PersonDto dto;
    public PersonDtoBuilder(){}
    public PersonDtoBuilder fromPerson(@NotNull Person person) {
        dto =new PersonDto();
        SimpleDateFormat dateFormat=new SimpleDateFormat("yyyy-MM-dd");
        dto.setPersonId(person.getId());
        dto.setBirthDate(dateFormat.format(person.getBirthDate()));
        dto.setCountryId(person.getCountryId());
        dto.setEducationLevelId(person.getEducationLevelId());
        dto.setFirstName(person.getFirstName());
        dto.setGender(person.getSex().name());
        dto.setLastName(person.getLastName());
        dto.setMaritalStatusId(person.getMaritalStatusId());
        dto.setNationalId(person.getNationalId());
        dto.setNationalityId(person.getNationalityId());
        dto.setOccupationId(person.getOccupationId());
        dto.setReligionId(person.getReligionId());
        dto.setSelfIdentifiedGender(person.getSelfIdentifiedGender().name());
        dto.setAddressDto(new AddressDtoBuilder().fromAddress(person.getAddress()).build());
        return this;
    }

    public PersonDto build(){
        if(dto==null){
            dto =new PersonDto();
        }
        return dto;
    }
}
