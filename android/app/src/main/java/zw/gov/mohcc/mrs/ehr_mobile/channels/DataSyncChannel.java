package zw.gov.mohcc.mrs.ehr_mobile.channels;

import android.os.Build;
import android.util.Log;

import androidx.annotation.RequiresApi;

import java.util.List;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.view.FlutterView;
import zw.gov.mohcc.mrs.ehr_mobile.persistance.database.EhrMobileDatabase;
import zw.gov.mohcc.mrs.ehr_mobile.sync.PatientDataSyncService;
import zw.gov.mohcc.mrs.sync.adapter.dto.PatientSyncDto;

public class DataSyncChannel {
    final String TAG="DataSyncChannel";
    public DataSyncChannel(FlutterView flutterView, String channelName, EhrMobileDatabase ehrMobileDatabase){
        new MethodChannel(flutterView, channelName).setMethodCallHandler(new MethodChannel.MethodCallHandler() {
            @RequiresApi(api = Build.VERSION_CODES.O)
            @Override
            public void onMethodCall(MethodCall call, MethodChannel.Result result1) {
                List<String>arguments = call.arguments();
                Log.i(TAG,"Args=== "+arguments);
                if (call.method.equals("syncPatients")) {
                    Log.i(TAG,"DATA SYNC PATIENTS");
                    new PatientDataSyncService(ehrMobileDatabase,arguments.get(1),arguments.get(0))
                    .syncPatient();
                }
            }
        });
    }
}
