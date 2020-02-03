package zw.gov.mohcc.mrs.ehr_mobile.channels;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;

import java.util.Date;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.view.FlutterView;
import zw.gov.mohcc.mrs.ehr_mobile.constant.APPLICATION_CONSTANTS;
import zw.gov.mohcc.mrs.ehr_mobile.dto.ArtDTO;
import zw.gov.mohcc.mrs.ehr_mobile.enumeration.WorkArea;
import zw.gov.mohcc.mrs.ehr_mobile.model.art.ArtCurrentStatus;
import zw.gov.mohcc.mrs.ehr_mobile.model.terminology.ArtReason;
import zw.gov.mohcc.mrs.ehr_mobile.model.terminology.ArvCombinationRegimen;
import zw.gov.mohcc.mrs.ehr_mobile.persistance.database.EhrMobileDatabase;
import zw.gov.mohcc.mrs.ehr_mobile.service.ArtService;
import zw.gov.mohcc.mrs.ehr_mobile.util.DateDeserializer;


public class ArtChannel {

    private final String TAG = "ART Channel";

    public ArtChannel(FlutterView flutterView, String channelName, EhrMobileDatabase ehrMobileDatabase, ArtService artService) {
        final String index_id;
        new MethodChannel(flutterView, channelName).setMethodCallHandler(
                new MethodChannel.MethodCallHandler() {
                    @Override
                    public void onMethodCall(MethodCall methodCall, MethodChannel.Result result) {
                        String arguments = methodCall.arguments();
                        Gson gson = new GsonBuilder().registerTypeAdapter(Date.class, new DateDeserializer()).create();

                        if (methodCall.method.equals("saveArtRegistration")) {
                            try {
                                ArtDTO art = gson.fromJson(arguments, ArtDTO.class);
                                String response = gson.toJson(artService.createArt(art));
                                result.success(response);

                            } catch (Exception e) {
                                System.out.println("something went wrong " + e.getMessage());
                                e.printStackTrace();

                            }

                        }

                        if (methodCall.method.equals("saveArtInitiation")) {
                            try {

                                ArtCurrentStatus artCurrentStatus = gson.fromJson(arguments, ArtCurrentStatus.class);
                                ArtCurrentStatus dbArtCurrentStatus = artService.initiatePatientOnArt(artCurrentStatus);
                                result.success(gson.toJson(dbArtCurrentStatus));
                            } catch (Exception e) {
                                System.out.println("something went wrong " + e.getMessage());

                            }

                        }
                        if (methodCall.method.equals("getRegimenName")) {
                            try {
                                ArvCombinationRegimen arvCombinationRegimen = ehrMobileDatabase.arvCombinationRegimenDao().findByName(arguments);
                                String regimenname = arvCombinationRegimen.getName();
                                result.success(regimenname);

                            } catch (Exception e) {

                                System.out.println("something went wrong " + e.getMessage());
                            }
                        }
                        if (methodCall.method.equals("getReason")) {
                            try {
                                ArtReason artReason = ehrMobileDatabase.artReasonDao().findByName(arguments);
                                String reason = artReason.getName();
                                result.success(reason);

                            } catch (Exception e) {
                                System.out.println("something went wrong " + e.getMessage());
                            }
                        }
                        if (methodCall.method.equals("getReasonForhivTest")) {
                            try {
                                result.success(gson.toJson(artService.findByWorkAreaAndCategoryId(WorkArea.ART, APPLICATION_CONSTANTS.ART_CATEGORY_ID)));

                            } catch (Exception e) {
                                System.out.println("something went wrong " + e.getMessage());
                            }
                        }

                    }
                });
    }
}
