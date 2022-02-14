package com.example.demo_plugin;

import android.content.BroadcastReceiver;
import android.content.Context;
import android.content.Intent;
import android.content.IntentFilter;
import android.net.Uri;
import android.os.Build;
import android.widget.Toast;

import androidx.annotation.NonNull;
import androidx.annotation.RequiresApi;


import com.customerglu.sdk.CustomerGlu;
import com.customerglu.sdk.Interface.DataListner;
import com.customerglu.sdk.Modal.RegisterModal;

import org.json.JSONException;
import org.json.JSONObject;

import java.util.EventListener;
import java.util.HashMap;
import java.util.Map;

import io.flutter.embedding.engine.FlutterEngine;
import io.flutter.embedding.engine.dart.DartExecutor;
import io.flutter.embedding.engine.plugins.FlutterPlugin;
import io.flutter.plugin.common.EventChannel;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;

/** DemoPlugin */
public class DemoPlugin implements FlutterPlugin, MethodCallHandler, EventChannel.StreamHandler {
  /// The MethodChannel that will the communication between Flutter and native Android
  ///
  /// This local reference serves to register the plugin with the Flutter Engine and unregister it
  /// when the Flutter Engine is detached from the Activity
  private MethodChannel channel;
  private Context context;
  String message="";
  EventChannel eventChannel;
  CustomerGlu customerglu;
  private EventChannel.EventSink myEventSink;

  @Override
  public void onAttachedToEngine(@NonNull FlutterPluginBinding flutterPluginBinding) {
    channel = new MethodChannel(flutterPluginBinding.getBinaryMessenger(), "demo_plugin");
    channel.setMethodCallHandler(this);
    this.context = flutterPluginBinding.getApplicationContext();
   // listen_broadcast();

    eventChannel = new EventChannel(flutterPluginBinding.getBinaryMessenger(),"CustomerGlu");
    eventChannel.setStreamHandler(this);
  }


  @RequiresApi(api = Build.VERSION_CODES.M)
  @Override
  public void onMethodCall(@NonNull MethodCall call, @NonNull Result result) {
  //  setInstance();
    switch (call.method) {

      case "getInstance":
        setInstance();
        break;
      case "setDefaultBannerImage":
        setDefaultImage(call,result);
        break;
      case "configureLoaderColour":
        configureLoaderColour(call,result);
        break;
      case "closeWebviewOnDeeplinkEvent":
        closeWebviewOnDeeplinkEvent(call,result);
        break;
      case "disableGluSdk":
        disableSDK(call,result);
        break;
     
      case "doRegister":
        doRegister(call, result);
        break;
      case "updateProfile":
        updateProfile(call,result);
        break;
      case "sendEventData":
        sendEventData(call,result);
        break;
      case "enablePrecaching":
        CustomerGlu.getInstance().enablePreaching(context);

        break;
      case "getReferralId":
        getReferralId(call,result);
      break;

      case "openWallet":
        customerglu.openWallet(context);
        break;

      case "loadAllCampaigns":
        customerglu.loadAllCampaigns(context);
        break;
      case "loadCampaignById":
        String campaignId = call.argument("campaignId");
        customerglu.loadCampaignById(context,campaignId);
        break;
      case "loadCampaignsByFilter":
        loadCampaignsByFilter(call,result);
        break;

      default:
        result.notImplemented();
        break;
    }
  }

  private void loadCampaignsByFilter(MethodCall call, Result result) {
    Map<String, Object> filterData = Utils.dartMapToProfileMap(call.argument("filters"));
    customerglu.loadCampaignsByFilter(context,filterData);

  }

  private void getReferralId(MethodCall call, Result result) {
      String id = call.argument("getReferralId");
      Uri uri = Uri.parse(id);
    String refeer_id =   customerglu.getReferralId(uri);
      result.success(refeer_id);

  }

  private void sendEventData(MethodCall call, Result result) {
    String eventName = call.argument("eventName");
    Map<String, Object> eventProperties = Utils.dartMapToProfileMap(call.argument("eventData"));
    customerglu.sendEvent(context,eventName,eventProperties);

  }

  private void updateProfile(MethodCall call, Result result) {

    Map<String, Object> profile = Utils.dartMapToProfileMap(call.argument("profile"));
    customerglu.updateProfile(context,profile);
    result.success(null);
  }

  private void disableSDK(MethodCall call, Result result) {
    Boolean isDisable = call.argument("value");
    customerglu.disableGluSdk(isDisable);

  }

  private void closeWebviewOnDeeplinkEvent(MethodCall call, Result result) {
    Boolean value = call.argument("value");
    customerglu.closeWebviewOnDeeplinkEvent(value);
  }

  private void configureLoaderColour(MethodCall call, Result result) {
    String color = call.argument("color");
    customerglu.configureLoaderColour(context,color);
  }

  private void setDefaultImage(MethodCall call, Result result) {
    String url = call.argument("image_url");
    customerglu.setDefaultBannerImage(context,url);
  }

  private void setInstance()
  {
    customerglu = CustomerGlu.getInstance();
  }


  private void doRegister(MethodCall call, Result result) {
    Map<String, Object> profile = Utils.dartMapToProfileMap(call.argument("profile"));
    CustomerGlu.getInstance().registerDevice(context, profile, true, new DataListner() {
      @Override
      public void onSuccess(RegisterModal registerModal) {
        Toast.makeText(context, "Success", Toast.LENGTH_SHORT).show();
      }

      @Override
      public void onFail(String message) {
        Toast.makeText(context, "Failed", Toast.LENGTH_SHORT).show();

      }
    });
      result.success(null);

  }

  @Override
  public void onDetachedFromEngine(@NonNull FlutterPluginBinding binding) {
    channel.setMethodCallHandler(null);
  }

//  @Override
//  public void success(Object event) {
//
//  }
//
//  @Override
//  public void error(String errorCode, String errorMessage, Object errorDetails) {
//
//  }
//
//  @Override
//  public void endOfStream() {
//
//  }

  @Override
  public void onListen(Object o,EventChannel.EventSink eventSink)
  {

   // myEventSink = eventSink;
    System.out.println("--------------listen---------------");
  }

  @Override
  public void onCancel(Object arguments) {
  myEventSink = null;
  }
}

//     case "showNudges":
//
//             try {
//             JSONObject jsonObject = new JSONObject("{\n" +
//             "    \"type\": \"CustomerGlu\",\n" +
//             "    \"title\": \"Congrats! You are 3 steps away\",\n" +
//             "    \"body\": \"ok cool\",\n" +
//             "    \"glu_message_type\":\"in-app\",\n" +
//             "    \"page_type\":\"middle-default\",\n" +
//             "    \"image\": \"https://assets.customerglu.com\",\n" +
//             "    \"nudge_url\": \"https://d3guhyj4wa8abr.cloudfront.net/program/?token=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiJ0ZXN0dXNlci0yOSIsImdsdUlkIjoiM2EzNzI2MTQtMDRkZi00MDU0LWIwMmMtMDgwMjkzYTFjYzFjIiwiY2xpZW50IjoiODRhY2YyYWMtYjJlMC00OTI3LTg2NTMtY2JhMmI4MzgxNmMyIiwiZGV2aWNlSWQiOiJkZXZpY2ViIiwiZGV2aWNlVHlwZSI6ImFuZHJvaWQiLCJpYXQiOjE2NDM3MDQxMTcsImV4cCI6MTY3NTI0MDExN30.j-gSaD0QvMJqZVXLwzJYCtvNbws_3hpvDk6lXuqv6F4&campaignId=410e804b-0642-4f6d-88ff-14b2e9570c38\"\n" +
//             "}");
//             Thread thread = new Thread() {
//@Override
//public void run() {
//        CustomerGlu.getInstance().displayCustomerGluNotification(context, jsonObject, R.drawable.ij, 0.5);
//        }
//        };
//        thread.start();
//        } catch (Exception e) {
//        e.printStackTrace();
//        }
//        result.success(null);
//
//        break;
