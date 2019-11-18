package zw.gov.mohcc.mrs.ehr_mobile.sync;

import android.os.Build;
import android.util.Log;

import androidx.annotation.RequiresApi;

import org.mapstruct.factory.Mappers;

import java.util.List;

import retrofit2.Call;
import retrofit2.Callback;
import retrofit2.Response;
import zw.gov.mohcc.mrs.ehr_mobile.configuration.RetrofitClient;
import zw.gov.mohcc.mrs.ehr_mobile.dto.builder.HtsDtoMapper;
import zw.gov.mohcc.mrs.ehr_mobile.dto.builder.PersonDtoBuilder;
import zw.gov.mohcc.mrs.ehr_mobile.model.Hts;
import zw.gov.mohcc.mrs.ehr_mobile.model.Person;
import zw.gov.mohcc.mrs.ehr_mobile.persistance.database.EhrMobileDatabase;
import zw.gov.mohcc.mrs.ehr_mobile.service.DataSyncService;
import zw.gov.mohcc.mrs.sync.adapter.dto.HtsDto;
import zw.gov.mohcc.mrs.sync.adapter.dto.PatientSyncDto;
import zw.gov.mohcc.mrs.sync.adapter.dto.PersonResponseDto;
import zw.gov.mohcc.mrs.sync.adapter.enums.RecordStatus;

public class PatientDataSyncService {
    private EhrMobileDatabase ehrMobileDatabase;
    private String baseUrl;
    private String token;
    final String TAG="PatientDataSyncService";
    public PatientDataSyncService(EhrMobileDatabase ehrMobileDatabase,String baseUrl,String token){
        this.ehrMobileDatabase=ehrMobileDatabase;
        this.baseUrl=baseUrl;
        this.token=token;
    }

    @RequiresApi(api = Build.VERSION_CODES.O)
    public void synchPatient() {
        List<Person> fetch = ehrMobileDatabase.personDao().getPatients();

        DataSyncService service = RetrofitClient.getRetrofitInstance(baseUrl).create(DataSyncService.class);
        for (Person person : fetch) {

            if(person.getStatus()== RecordStatus.NEW){
                PatientSyncDto dto=createSyncDto(person);
                Call<PersonResponseDto> call = service.syncPatient("Bearer " + token,dto);
                syncPersonDto(call,person,ehrMobileDatabase);
            } else if(person.getStatus()== RecordStatus.CHANGED){
                PatientSyncDto patientSyncDto =new PatientSyncDto();
            }
        }
    }

    private PatientSyncDto createSyncDto(Person person){
        PatientSyncDto dto=new PatientSyncDto();
        dto.setPersonDto(new PersonDtoBuilder().fromPerson(person).build());
        return dto;
    }

    private void syncPersonDto(Call<PersonResponseDto> call,Person person,EhrMobileDatabase ehrMobileDatabase){
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
    }

    private HtsDto createHtsDto(Person person){
        Hts hts=ehrMobileDatabase.htsDao().findHtsByPersonId(person.getId());
        HtsDtoMapper mapper = Mappers.getMapper(HtsDtoMapper.class);
        HtsDto htsDto=null;
        if(hts!=null){
            htsDto= mapper.htsToHtsDto(hts);
            Log.i(TAG,"HtsDto---"+htsDto.getDateOfHivTest());
        }
        return htsDto;
    }
}
