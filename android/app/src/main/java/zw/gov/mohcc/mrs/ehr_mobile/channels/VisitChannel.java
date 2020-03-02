package zw.gov.mohcc.mrs.ehr_mobile.channels;

import com.google.gson.Gson;

import java.util.List;

import io.flutter.Log;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.view.FlutterView;
import zw.gov.mohcc.mrs.ehr_mobile.dto.DischargePatientDTO;
import zw.gov.mohcc.mrs.ehr_mobile.dto.OutPatientDTO;
import zw.gov.mohcc.mrs.ehr_mobile.dto.PatientSummaryDTO;
import zw.gov.mohcc.mrs.ehr_mobile.model.PatientQueue;
import zw.gov.mohcc.mrs.ehr_mobile.model.FacilityQueue;
import zw.gov.mohcc.mrs.ehr_mobile.service.AppWideService;
import zw.gov.mohcc.mrs.ehr_mobile.service.VisitService;

public class VisitChannel {
    private final static String TAG = "Visit Channel";

    public VisitChannel(FlutterView flutterView, String channelName, AppWideService appWideService, VisitService visitService) {
        new MethodChannel(flutterView, channelName).setMethodCallHandler(new MethodChannel.MethodCallHandler() {
            @Override
            public void onMethodCall(MethodCall call, MethodChannel.Result result1) {
                final String arguments = call.arguments();
                Gson gson = new Gson();
                if (call.method.equals("getFacilityQueues")) {
                    List<FacilityQueue> facilityQueues = visitService.getFacilityQueues();
                    result1.success(gson.toJson(facilityQueues));
                }
                if (call.method.equals("admitPatient")) {
                    OutPatientDTO outPatientDTO = gson.fromJson(arguments, OutPatientDTO.class);
                    String visitId = visitService.onOutPatientAdmitted(outPatientDTO);
                    result1.success(visitId);
                }
                if(call.method.equals("changePatientQueue")){
                    OutPatientDTO outPatientDTO = gson.fromJson(arguments, OutPatientDTO.class);
                    String queue_id = visitService.onPatientQueueChanged(outPatientDTO);
                    result1.success(queue_id);
                }
                if(call.method.equals("getPatientQueue")){
                    PatientQueue patientQueue = appWideService.getPatientQueue(arguments);
                    String queue_response = gson.toJson(patientQueue);
                    result1.success(queue_response);
                }
                if(call.method.equals("getPatientSummary")){
                    Log.i(TAG, "Here is the person Id sent from flutter "+ arguments);
                    PatientSummaryDTO patientSummaryDTO = visitService.getPatientSummary(arguments);
                    System.out.println("HERE IS THE PATIENT SUMMARY DTO PASSED to FLUTTER" + gson.toJson(patientSummaryDTO));
                    result1.success(gson.toJson(patientSummaryDTO));
                }

                if(call.method.equals("dischargePatient")){
                    Log.i(TAG, "Here is the person Id sent from flutter "+ arguments);
                    DischargePatientDTO dischargePatientDTO = gson.fromJson(arguments, DischargePatientDTO.class);
                    visitService.dischargePatient(dischargePatientDTO.getVisitId(), dischargePatientDTO.getDischargeDate());
                }

            }

        });
    }
}

