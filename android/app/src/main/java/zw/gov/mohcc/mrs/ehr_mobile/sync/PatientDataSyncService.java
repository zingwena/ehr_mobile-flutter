package zw.gov.mohcc.mrs.ehr_mobile.sync;

import android.os.Build;
import android.util.Log;

import androidx.annotation.RequiresApi;

import java.text.SimpleDateFormat;
import java.util.List;

import retrofit2.Call;
import retrofit2.Callback;
import retrofit2.Response;
import zw.gov.mohcc.mrs.ehr_mobile.configuration.RetrofitClient;
import zw.gov.mohcc.mrs.ehr_mobile.dto.IdentityDTO;
import zw.gov.mohcc.mrs.ehr_mobile.dto.PersonDtoBuilder;
import zw.gov.mohcc.mrs.ehr_mobile.dto.RegisterPersonDTO;
import zw.gov.mohcc.mrs.ehr_mobile.model.Person;
import zw.gov.mohcc.mrs.ehr_mobile.persistance.database.EhrMobileDatabase;
import zw.gov.mohcc.mrs.ehr_mobile.service.DataSyncService;
import zw.gov.mohcc.mrs.ehr_mobile.util.Constants;
import zw.gov.mohcc.mrs.sync.adapter.dto.PatientSyncDto;
import zw.gov.mohcc.mrs.sync.adapter.dto.PersonResponseDto;
import zw.gov.mohcc.mrs.sync.adapter.enums.RecordStatus;

public class PatientDataSyncService {

    @RequiresApi(api = Build.VERSION_CODES.O)
    public void synchPatient(EhrMobileDatabase ehrMobileDatabase, String token, String baseUrl) {
        List<Person> fetch = ehrMobileDatabase.personDao().getPatients();
        DataSyncService service = RetrofitClient.getRetrofitInstance(baseUrl).create(DataSyncService.class);
        for (Person person : fetch) {
            if(person.getStatus()== RecordStatus.NEW){
//                SimpleDateFormat dateFormat=new SimpleDateFormat("yyyy-MM-dd");
//                RegisterPersonDTO dto=new RegisterPersonDTO(
//                        person.getLastName(),
//                        person.getFirstName(),
//                        dateFormat.format(person.getBirthDate()),
//                        person.getSex(),
//                        Constants.NATIONAL_ID_NUMBER_TYPE,
//                        person.getNationalId());
//                dto.setId(person.getId());
                PatientSyncDto dto=createSyncDto(person);
                Call<PersonResponseDto> call = service.syncPatient("Bearer " + token,dto);
                call.enqueue(new Callback<PersonResponseDto>() {
                    @Override
                    public void onResponse(Call<PersonResponseDto> call, Response<PersonResponseDto> response) {
                        if(response.isSuccessful()){
                            System.out.println(response.body());
                            person.setStatus(RecordStatus.SYNCED);
                            ehrMobileDatabase.personDao().updatePatient(person);
                        }else {
                            Log.e("PATIENT_APOLLO",response.message());
                        }
                    }
                    @Override
                    public void onFailure(Call<PersonResponseDto> call, Throwable t) {
                        System.out.println(t.getMessage());
                    }
                });
            } else if(person.getStatus()== RecordStatus.CHANGED){
                PatientSyncDto patientSyncDto =new PatientSyncDto();
                //createSyncDto();
            }
        }
    }

    private PatientSyncDto createSyncDto(Person person){
        PatientSyncDto dto=new PatientSyncDto();
        dto.setPersonDto(new PersonDtoBuilder().fromPerson(person).build());
        return dto;
    }
}
