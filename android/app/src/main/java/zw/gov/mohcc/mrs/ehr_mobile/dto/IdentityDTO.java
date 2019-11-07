package zw.gov.mohcc.mrs.ehr_mobile.dto;

import java.util.UUID;

public class IdentityDTO {

	String id;

	public IdentityDTO(String id) {
		super();
		this.id = id;
	}

	public IdentityDTO(UUID id) {
		super();
		this.id = id.toString();
	}

}