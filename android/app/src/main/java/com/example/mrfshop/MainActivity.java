package com.example.mrfshop;

import android.os.Bundle;
import io.flutter.app.FlutterActivity;
import io.flutter.plugins.GeneratedPluginRegistrant;

public class MainActivity extends FlutterActivity {
  //private static final String CHANNEL = "com.test/test";
  @Override
  protected void onCreate(Bundle savedInstanceState) {
    super.onCreate(savedInstanceState);
    GeneratedPluginRegistrant.registerWith(this);
    // StrictMode.VmPolicy.Builder builder = new StrictMode.VmPolicy.Builder();
    // StrictMode.setVmPolicy(builder.build());
    // new MethodChannel(getFlutterView(), CHANNEL).setMethodCallHandler(
    //   new MethodCallHandler() {
    //     @Override
    //     public void onMethodCall(MethodCall methodCall, Result result) {
    //       if (methodCall.method.equals("changeLife")){
    //         String message ="Life Changed";
    //         result.success(message);
    //       }
    //     }
    //   }
    // );
  }
}


