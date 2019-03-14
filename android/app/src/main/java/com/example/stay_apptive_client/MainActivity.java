package com.example.stay_apptive_client;

import android.os.Bundle;
import android.content.ContextWrapper;
import android.content.Intent;
import android.content.IntentFilter;
import android.os.BatteryManager;
import android.os.Build.VERSION;
import android.os.Build.VERSION_CODES;
import java.util.TimeZone;

import io.flutter.app.FlutterActivity;
import io.flutter.plugins.GeneratedPluginRegistrant;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;

public class MainActivity extends FlutterActivity {
  private static final String CHANNEL = "stayApptive.com/timeZone";

  @Override
  protected void onCreate(Bundle savedInstanceState) {
    super.onCreate(savedInstanceState);
    new MethodChannel(getFlutterView(), CHANNEL)
      .setMethodCallHandler(new MethodCallHandler(){
        @Override
        public void onMethodCall(MethodCall call, Result result){
          if (call.method.equals("getTimeZone")) {
            String timeZone = TimeZone.getDefault().getID();
            System.out.println("heello");
            System.out.println(timeZone);
            System.out.println(TimeZone.getDefault().getDisplayName());
            if (timeZone != null){
              result.success(timeZone);
            } else {
              result.error("UNAVAILABLE", "Time zone not available", null);
            }
          }
        }
      });
    GeneratedPluginRegistrant.registerWith(this);
  }
}
