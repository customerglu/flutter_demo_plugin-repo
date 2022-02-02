package com.example.demo_plugin_example;

import android.content.BroadcastReceiver;
import android.content.Context;
import android.content.Intent;
import android.content.IntentFilter;
import android.os.Bundle;
import android.os.Handler;
import android.os.Looper;
import android.widget.Toast;

import androidx.annotation.NonNull;
import androidx.annotation.Nullable;

import org.json.JSONObject;

import io.flutter.embedding.android.FlutterActivity;
import io.flutter.embedding.engine.FlutterEngine;
import io.flutter.plugin.common.EventChannel;
import io.flutter.plugin.common.MethodChannel;

public class MainActivity extends FlutterActivity {
    private MethodChannel methodChannel;
    private EventChannel eventChannel;

    @Override
    public void configureFlutterEngine(@NonNull FlutterEngine flutterEngine) {
        super.configureFlutterEngine(flutterEngine);
        methodChannel = new MethodChannel(flutterEngine.getDartExecutor().getBinaryMessenger(),"broadcast_channel");
        eventChannel = new EventChannel(flutterEngine.getDartExecutor().getBinaryMessenger(),"broadcast_streamer");
        eventChannel.setStreamHandler(new MyStreamHandler(getApplicationContext()));
    }



    @Override
    protected void onCreate(@Nullable Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        new Handler(Looper.getMainLooper()).post(new Runnable() {
            @Override
            public void run() {
                // Call the desired channel message here.
                methodChannel.invokeMethod("broadcast_message","message");

            }
        });

    }

    @Override
    protected void onRestart() {
        super.onRestart();
        listen_broadcast();
    }


    private void listen_broadcast()
    {


    }
}

   class MyStreamHandler implements EventChannel.StreamHandler {
       BroadcastReceiver mMessageReceiver;
       Context context;
       String message;


       public MyStreamHandler(Context context)
    {
        this.context = context;
    }


       @Override
       public void onListen(Object arguments, EventChannel.EventSink events) {

           mMessageReceiver = new BroadcastReceiver() {
               @Override
               public void onReceive(Context context, Intent intent) {
                   try {

                       if(intent.getAction().equalsIgnoreCase("CUSTOMERGLU_DEEPLINK_EVENT"))
                       {
                           String data =  intent.getStringExtra("data");
                           JSONObject jsonObject = new JSONObject(data);
                           message = jsonObject.getString("deepLink");

                           // Write your Logic to perform action
                           events.success(message);


                           Toast.makeText(context, message, Toast.LENGTH_SHORT).show();
                       }
                   }
                   catch (Exception e)
                   {
                       System.out.println(e);
                   }
               }
           };
           context.registerReceiver(mMessageReceiver,new IntentFilter("CUSTOMERGLU_DEEPLINK_EVENT"));

       }

       @Override
       public void onCancel(Object arguments) {

       }
   }
