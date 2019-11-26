package zw.gov.mohcc.mrs.ehr_mobile.channels;
import androidx.sqlite.db.SimpleSQLiteQuery;

import com.google.gson.Gson;

import java.util.ArrayList;
import java.util.List;

import io.flutter.Log;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.view.FlutterView;
import zw.gov.mohcc.mrs.ehr_mobile.dto.OutPatientDTO;
import zw.gov.mohcc.mrs.ehr_mobile.dto.RelationshipDTO;
import zw.gov.mohcc.mrs.ehr_mobile.dto.RelationshipViewDTO;
import zw.gov.mohcc.mrs.ehr_mobile.model.person.Person;
import zw.gov.mohcc.mrs.ehr_mobile.model.person.Relationship;
import zw.gov.mohcc.mrs.ehr_mobile.model.vitals.FacilityQueue;
import zw.gov.mohcc.mrs.ehr_mobile.persistance.dao.raw.PersonQuery;
import zw.gov.mohcc.mrs.ehr_mobile.persistance.database.EhrMobileDatabase;
import zw.gov.mohcc.mrs.ehr_mobile.service.RelationshipService;
import zw.gov.mohcc.mrs.ehr_mobile.service.VisitService;

public class VisitChannel {
    private final static String TAG = "Main Activity";

    public VisitChannel(FlutterView flutterView, String channelName, EhrMobileDatabase ehrMobileDatabase, VisitService visitService){
        new MethodChannel(flutterView, channelName).setMethodCallHandler(new MethodChannel.MethodCallHandler() {
            @Override
            public void onMethodCall(MethodCall call, MethodChannel.Result result1) {
                final String arguments = call.arguments();
                Gson gson = new Gson();
                if (call.method.equals("getFacilityQueues")) {
                    List<FacilityQueue>facilityQueues = visitService.getFacilityQueues();
                    Log.i(TAG," Here is the list of queues ###########"+facilityQueues);
                    result1.success(gson.toJson(facilityQueues));
                }
                if(call.method.equals("admitPatient")){
                    OutPatientDTO outPatientDTO =  gson.fromJson(arguments, OutPatientDTO.class);
                    Log.i(TAG, "HERE IS THE PATIENT ID IN THE OUTPATIENT DTO SAVED >>>>>>>>>>>>>>"+ outPatientDTO.getPersonId());
                    Log.i(TAG, "HERE IS THE Queue IN THE OUTPATIENT DTO SAVED >>>>>>>>>>>>>>"+ outPatientDTO.getQueue().getName());

                    String visitId =  visitService.onOutPatientAdmitted(outPatientDTO);
                    result1.success(visitId);

                }

            }

        });
    }
}

