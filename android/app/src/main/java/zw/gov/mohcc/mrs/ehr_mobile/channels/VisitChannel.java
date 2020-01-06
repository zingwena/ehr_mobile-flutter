package zw.gov.mohcc.mrs.ehr_mobile.channels;

import com.google.gson.Gson;

import java.util.List;

import io.flutter.Log;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.view.FlutterView;
import zw.gov.mohcc.mrs.ehr_mobile.dto.OutPatientDTO;
import zw.gov.mohcc.mrs.ehr_mobile.dto.PatientSummaryDTO;
import zw.gov.mohcc.mrs.ehr_mobile.model.PatientQueue;
import zw.gov.mohcc.mrs.ehr_mobile.model.vitals.FacilityQueue;
import zw.gov.mohcc.mrs.ehr_mobile.persistance.database.EhrMobileDatabase;
import zw.gov.mohcc.mrs.ehr_mobile.service.VisitService;

public class VisitChannel {
    private final static String TAG = "Main Activity";

    public VisitChannel(FlutterView flutterView, String channelName, EhrMobileDatabase ehrMobileDatabase, VisitService visitService) {
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
                    PatientQueue patientQueue = visitService.getPatientQueue(arguments);
                    String queue_response = gson.toJson(patientQueue);
                    result1.success(queue_response);

                }
                if(call.method.equals("getPatientSummary")){
                    Log.i(TAG, "Here is the person Id sent from flutter "+ arguments);
                    PatientSummaryDTO patientSummaryDTO = visitService.getPatientSummary(arguments);
                    result1.success(gson.toJson(patientSummaryDTO));
                }

            }

        });
    }
}

