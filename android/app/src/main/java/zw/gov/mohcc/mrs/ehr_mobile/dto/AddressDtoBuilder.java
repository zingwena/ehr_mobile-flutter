package zw.gov.mohcc.mrs.ehr_mobile.dto;

import zw.gov.mohcc.mrs.ehr_mobile.model.Address;
import zw.gov.mohcc.mrs.sync.adapter.dto.AddressDto;

public class AddressDtoBuilder {
    private AddressDto addressDto;
    public AddressDtoBuilder fromAddress(Address address) {
        addressDto=new AddressDto();
        addressDto.setCity(address.getCity());
        addressDto.setStreet(address.getStreet());
        addressDto.setTown(address.getTown());
        return this;
    }

    public AddressDto build(){
        if(addressDto==null){
            addressDto=new AddressDto();
        }
        return addressDto;
    }
}
