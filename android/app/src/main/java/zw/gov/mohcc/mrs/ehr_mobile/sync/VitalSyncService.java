package zw.gov.mohcc.mrs.ehr_mobile.sync;

import android.util.Log;

import org.mapstruct.factory.Mappers;

import java.util.ArrayList;
import java.util.List;

import zw.gov.mohcc.mrs.ehr_mobile.dto.builder.VitalDtoMapper;
import zw.gov.mohcc.mrs.ehr_mobile.model.vitals.BloodPressure;
import zw.gov.mohcc.mrs.ehr_mobile.model.vitals.Pulse;
import zw.gov.mohcc.mrs.ehr_mobile.model.vitals.RespiratoryRate;
import zw.gov.mohcc.mrs.ehr_mobile.model.vitals.Temperature;
import zw.gov.mohcc.mrs.ehr_mobile.model.vitals.Weight;
import zw.gov.mohcc.mrs.ehr_mobile.persistance.database.EhrMobileDatabase;
import zw.gov.mohcc.mrs.sync.adapter.dto.VitalDto;
import zw.gov.mohcc.mrs.sync.adapter.enums.VitalName;

public class VitalSyncService {

    private EhrMobileDatabase ehrMobileDatabase;
    public VitalSyncService(EhrMobileDatabase ehrMobileDatabase){
        this.ehrMobileDatabase=ehrMobileDatabase;
    }

    public List<VitalDto> getVitalsByPersonId(String personId){
        List<VitalDto> vitalDtos=new ArrayList<>(1);
        List<BloodPressure>bloodPressureList= ehrMobileDatabase.bloodPressureDao().findByPersonId(personId);
        for (BloodPressure pressure:bloodPressureList) {
            VitalDtoMapper mapper = Mappers.getMapper(VitalDtoMapper.class);
            VitalDto vitalDto = mapper.vitalToVitalDto(pressure);
            vitalDto.setVitalName(VitalName.BLOOD_PRESSURE);
            vitalDto.setDiastolic(pressure.getDiastolic());
            vitalDto.setSystolic(pressure.getSystolic());
            vitalDtos.add(vitalDto);
        }

        List<Temperature> temperatureList=ehrMobileDatabase.temperatureDao().findByPersonId(personId);
        for (Temperature temp:temperatureList) {
            VitalDtoMapper mapper = Mappers.getMapper(VitalDtoMapper.class);
            VitalDto vitalDto = mapper.vitalToVitalDto(temp);
            vitalDto.setVitalName(VitalName.TEMPERATURE);
            vitalDto.setValue(temp.getValue());
            vitalDtos.add(vitalDto);
        }

        List<Weight> weightList=ehrMobileDatabase.weightDao().findByPersonId(personId);
        for (Weight weight:weightList) {
            VitalDtoMapper mapper = Mappers.getMapper(VitalDtoMapper.class);
            VitalDto vitalDto = mapper.vitalToVitalDto(weight);
            vitalDto.setVitalName(VitalName.WEIGHT);
            vitalDto.setValue(weight.getValue());
            vitalDtos.add(vitalDto);
        }

        List<Pulse> pulses=ehrMobileDatabase.pulseDao().findByPersonId(personId);
        for (Pulse pulse:pulses) {
            VitalDtoMapper mapper = Mappers.getMapper(VitalDtoMapper.class);
            VitalDto vitalDto = mapper.vitalToVitalDto(pulse);
            vitalDto.setVitalName(VitalName.PULSE);
            vitalDto.setValue(pulse.getValue());
            vitalDtos.add(vitalDto);
        }

        List<RespiratoryRate> respiratoryRates=ehrMobileDatabase.respiratoryRateDao().findByPersonId(personId);
        for (RespiratoryRate rate:respiratoryRates) {
            VitalDtoMapper mapper = Mappers.getMapper(VitalDtoMapper.class);
            VitalDto vitalDto = mapper.vitalToVitalDto(rate);
            vitalDto.setVitalName(VitalName.RESPIRATORY_RATE);
            vitalDto.setValue(rate.getValue());
            vitalDtos.add(vitalDto);
        }
        for (VitalDto vitalDto:vitalDtos) {
            Log.i("Vital----",vitalDto.toString());
        }
        return vitalDtos;
    }


}
