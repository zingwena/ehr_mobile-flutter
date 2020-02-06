package zw.gov.mohcc.mrs.ehr_mobile.channels;

import android.util.Log;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;

import org.apache.commons.lang3.StringUtils;

import java.util.Date;
import java.util.UUID;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.view.FlutterView;
import zw.gov.mohcc.mrs.ehr_mobile.dto.PatientDto;
import zw.gov.mohcc.mrs.ehr_mobile.dto.PatientPhoneDto;
import zw.gov.mohcc.mrs.ehr_mobile.enumeration.RecordStatus;
import zw.gov.mohcc.mrs.ehr_mobile.model.person.Address;
import zw.gov.mohcc.mrs.ehr_mobile.model.person.PersonPhone;
import zw.gov.mohcc.mrs.ehr_mobile.model.person.Person;
import zw.gov.mohcc.mrs.ehr_mobile.persistance.database.EhrMobileDatabase;
import zw.gov.mohcc.mrs.ehr_mobile.util.DateDeserializer;

public class AddPatientChannel {

    public AddPatientChannel(FlutterView flutterView, String channelName, EhrMobileDatabase ehrMobileDatabase){
        new MethodChannel(flutterView, channelName).setMethodCallHandler(new MethodChannel.MethodCallHandler() {
            @Override
            public void onMethodCall(MethodCall methodCall, MethodChannel.Result result) {
                String TAG="AddPatientChannel";
                Gson gson = new GsonBuilder().registerTypeAdapter(Date.class, new DateDeserializer()).create();
                if (methodCall.method.equals("registerPatient")) {
                    String args = methodCall.arguments();
                    PatientDto patientDto = gson.fromJson(args, PatientDto.class);
                    Log.d(TAG, "$$$$$$$$$$$$$$$$$$ : " + patientDto);
                    Person person = new Person(patientDto.getFirstName(), patientDto.getLastName(), patientDto.getSex());
                    String personId = UUID.randomUUID().toString();
                    person.setId(personId);
                    person.setNationalId(patientDto.getNationalId());
                    person.setReligionId(patientDto.getReligion());
                    person.setMaritalStatusId(patientDto.getMaritalStatus());
                    person.setEducationLevelId(patientDto.getEducationLevel());
                    person.setNationalityId(patientDto.getNationality());
                    person.setCountryId(patientDto.getCountryOfBirth());
                    person.setSelfIdentifiedGender(patientDto.getSelfIdentifiedGender());
                    person.setNationalId(patientDto.getNationalId());
                    person.setReligionId(patientDto.getReligion());
                    person.setMaritalStatusId(patientDto.getMaritalStatus());
                    person.setEducationLevelId(patientDto.getEducationLevel());
                    person.setNationalityId(patientDto.getNationality());
                    person.setCountryId(patientDto.getCountryOfBirth());
                    person.setSelfIdentifiedGender(patientDto.getSelfIdentifiedGender());
                    person.setAddress(patientDto.getAddress());
                    person.setOccupationId(patientDto.getOccupation());
                    person.setBirthDate(patientDto.getBirthDate());
                    person.setStatus(RecordStatus.NEW);
                    ehrMobileDatabase.personDao().createPatient(person);
                    Person person1 = ehrMobileDatabase.personDao().findPatientById(personId);
                    Log.i(TAG,"PERSON PERSON PERSON SAVED IN ANDROID"+ person1.toString());
                    result.success(person1.getId());

                    System.out.println("==================-=-=-=-=-fromDB " + ehrMobileDatabase.personDao().findPatientById(person.getId()));
                }
                if (methodCall.method.equals("getPatientById")) {
                    String ags = methodCall.arguments();
                    Log.i(TAG, "HERE IS PATIENT ID TO RETRIEVE PATIENT"+ ags);

                    Person person = ehrMobileDatabase.personDao().findPatientById(ags);

                    String response = gson.toJson(person);
                    System.out.println("HERE IS THE PERSON SENT FROM FLUTTER THROUGH GET BY ID >>>>>>>>>>>>> "+ response);
                    result.success(response);
                }
                if (methodCall.method.equals("getPatientMaritalStatus")) {
                    String code = methodCall.arguments();
                    String name = ehrMobileDatabase.maritalStateDao().findById(code).getName();
                    result.success(name);
                }

                if (methodCall.method.equals("getEducationLevel")) {
                    String code = methodCall.arguments();
                    String name = ehrMobileDatabase.educationLevelDao().findbyId(code);
                    result.success(name);
                }
                if (methodCall.method.equals("getOccupation")) {
                    String code = methodCall.arguments();
                    String name = ehrMobileDatabase.occupationDao().findById(code).getName();
                    result.success(name);
                }
                if (methodCall.method.equals("getNationality")) {
                    String code = methodCall.arguments();
                    String name = ehrMobileDatabase.nationalityDao().findById(code).getName();
                    result.success(name);
                }
                if (methodCall.method.equals("getAddress")) {
                    String code = methodCall.arguments();
                    Person patient = ehrMobileDatabase.personDao().findPatientById(code);
                    Address address = patient.getAddress();
                    StringBuilder patient_address=new StringBuilder();
                    if(address!=null){
                        patient_address.append(address.getStreet())
                                .append(' ')
                                .append(address.getTown())
                                .append(' ')
                                .append(address.getCity());
                        System.out.println("ADDRESSS " + "street: " + address.getStreet() + " town:" + address.getTown() + " city:" + address.getCity());
                    }
                    result.success(patient_address.toString());
                }
                if (methodCall.method.equals("savephonenumber")) {

                    String args = methodCall.arguments();
                    System.out.println("PATIENT FROM FLUTTER" + args);
                    PatientPhoneDto patientPhoneDto = gson.fromJson(args, PatientPhoneDto.class);
                    System.out.println("PATIENT DTO" + patientPhoneDto);
                    String phoneNumberId = UUID.randomUUID().toString();
                    PersonPhone personPhone = new PersonPhone(phoneNumberId, patientPhoneDto.getPersonId(), patientPhoneDto.getPhoneNumber1(), patientPhoneDto.getPhoneNumber2());
                    ehrMobileDatabase.patientPhoneDao().saveOne(personPhone).intValue();
                    System.out.println("PATIENT NUMBER SAVED HERE ");
                  /*  PersonPhone patient_PhoneNumber = ehrMobileDatabase.patientPhoneDao().findById(phonenumber_id);
                    System.out.println("NUMBER 1" + patient_PhoneNumber.getPhonenumber_1());*/
                    /*System.out.println("PATIENT ID HERE"+ patient_PhoneNumber.getPatientId());*/
                    result.success(phoneNumberId);

/*
                    System.out.println("==================-=-=-=-=-fromDB " + ehrMobileDatabase.patientDao().findPatientById(id));
*/
                }
                if (methodCall.method.equals("getPhonenumber")) {
                    String args = methodCall.arguments();
                    Log.i(TAG, "PATIENT ID FROM FLUTTER " + args);
                    PersonPhone personPhone = ehrMobileDatabase.patientPhoneDao().findByPersonId(args);
                    String phoneNumber = "";
                    if (personPhone != null) {
                        if (StringUtils.isNoneBlank(personPhone.getPhoneNumber1())) {
                            phoneNumber += personPhone.getPhoneNumber1();
                        }
                        if (StringUtils.isNoneBlank(personPhone.getPhoneNumber2())) {
                            if (StringUtils.isNoneBlank(phoneNumber)) {
                                phoneNumber += "/ " + personPhone.getPhoneNumber2();
                            } else {
                                phoneNumber += personPhone.getPhoneNumber2();
                            }
                        }
                    }

                    result.success(phoneNumber);
                }

            }
        });

    }
}
