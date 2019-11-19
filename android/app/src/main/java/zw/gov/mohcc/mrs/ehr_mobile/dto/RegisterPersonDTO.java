package zw.gov.mohcc.mrs.ehr_mobile.dto;

import zw.gov.mohcc.mrs.ehr_mobile.enumeration.Gender;

public class RegisterPersonDTO {

	private String id;
	private String lastname;
	private String firstname;

	private String birthdate;

	private Gender sex;

	private String typeId;

	private String number;

	public RegisterPersonDTO(){}

	public RegisterPersonDTO(String lastname, String firstname, String birthdate, Gender sex, String typeId, String number) {
		this.lastname = lastname;
		this.firstname = firstname;
		this.birthdate = birthdate;
		this.sex = sex;
		this.typeId = typeId;
		this.number = number;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getLastname() {
		return lastname;
	}

	public void setLastname(String lastname) {
		this.lastname = lastname;
	}

	public String getFirstname() {
		return firstname;
	}

	public void setFirstname(String firstname) {
		this.firstname = firstname;
	}

	public String getBirthdate() {
		return birthdate;
	}

	public void setBirthdate(String birthdate) {
		this.birthdate = birthdate;
	}

	public Gender getSex() {
		return sex;
	}

	public void setSex(Gender sex) {
		this.sex = sex;
	}

	public String getTypeId() {
		return typeId;
	}

	public void setTypeId(String typeId) {
		this.typeId = typeId;
	}

	public String getNumber() {
		return number;
	}

	public void setNumber(String number) {
		this.number = number;
	}


}