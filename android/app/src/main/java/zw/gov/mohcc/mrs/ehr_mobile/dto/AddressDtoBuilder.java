package zw.gov.mohcc.mrs.ehr_mobile.dto;

import org.jetbrains.annotations.NotNull;

import zw.gov.mohcc.mrs.ehr_mobile.model.Address;

/**
 * Builder to map Address to AddressDto
 *
 */
public class AddressDtoBuilder {

    private AddressDto addressDto;
    public AddressDtoBuilder fromAddress(@NotNull Address address){
        addressDto=new AddressDto();
        addressDto.setCity(address.getCity());
        addressDto.setTown(address.getTown());
        addressDto.setStreet(address.getStreet());
        return this;
    }

    public AddressDto build(){
        if(addressDto==null){
            addressDto=new AddressDto();
        }
        return addressDto;
    }
}
