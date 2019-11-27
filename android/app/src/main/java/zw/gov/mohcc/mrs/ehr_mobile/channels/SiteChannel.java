package zw.gov.mohcc.mrs.ehr_mobile.channels;

import android.support.annotation.NonNull;
import android.util.Log;

import com.google.gson.Gson;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.view.FlutterView;
import zw.gov.mohcc.mrs.ehr_mobile.model.terminology.NameCode;
import zw.gov.mohcc.mrs.ehr_mobile.model.terminology.SiteSetting;
import zw.gov.mohcc.mrs.ehr_mobile.persistance.database.EhrMobileDatabase;
import zw.gov.mohcc.mrs.ehr_mobile.service.SiteService;
import zw.gov.mohcc.mrs.ehr_mobile.service.VisitService;

public class SiteChannel {
    private final static String TAG = "Main Activity";

    public SiteChannel (FlutterView flutterView, String channelName, EhrMobileDatabase ehrMobileDatabase, SiteService siteService){
        new MethodChannel(flutterView, channelName).setMethodCallHandler(new MethodChannel.MethodCallHandler() {
            @Override
            public void onMethodCall(@NonNull MethodCall methodCall, @NonNull MethodChannel.Result result) {
                final String arguments = methodCall.arguments();
                Gson gson = new Gson();
                if(methodCall.method.equals("getSiteName")){
                    System.out.println("SITE CHANNEL CALLED !!!");
                    NameCode sitesetting = siteService.getFacilityDetails();
                    Log.i(TAG, "Site setting retrievs"+ sitesetting.getName());
                    result.success(sitesetting.getName());

                }
            }
        });

    }

}
