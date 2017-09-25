
package com.liang;

import android.app.AlarmManager;
import android.app.PendingIntent;
import android.content.Context;
import android.content.Intent;
import android.support.annotation.Nullable;
import android.support.v4.content.WakefulBroadcastReceiver;
import android.util.TimeUtils;

import com.facebook.react.bridge.Promise;
import com.facebook.react.bridge.ReactApplicationContext;
import com.facebook.react.bridge.ReactContextBaseJavaModule;
import com.facebook.react.bridge.ReactMethod;
import com.facebook.react.bridge.Callback;
import com.facebook.react.uimanager.IllegalViewOperationException;

import java.io.Console;

import static android.R.attr.type;

public class RNAlarmModule extends ReactContextBaseJavaModule {

    private final ReactApplicationContext reactContext;

    public RNAlarmModule(ReactApplicationContext reactContext) {
        super(reactContext);
        this.reactContext = reactContext;
    }

    @Override
    public String getName() {
        return "RNAlarm";
    }

    @ReactMethod
    public void setAlarm(String triggerTime, String title, @Nullable String musicUri, @Nullable Callback successCallback, @Nullable Callback errorCallback) {
        try {
            AlarmManager alarmManager = (AlarmManager) reactContext.getSystemService(Context.ALARM_SERVICE);
            Intent intent = new Intent(RNAlarmConstants.REACT_NATIVE_ALARM);
            intent.putExtra(RNAlarmConstants.REACT_NATIVE_ALARM_TITLE,title);
            intent.putExtra(RNAlarmConstants.REACT_NATIVE_ALARM_MUSIC_URI, musicUri);
            PendingIntent pendingIntent = PendingIntent.getBroadcast(reactContext, type, intent, PendingIntent.FLAG_UPDATE_CURRENT);

            long startTime = Long.parseLong(triggerTime);
            alarmManager.setExact(AlarmManager.RTC_WAKEUP, startTime, pendingIntent);
            if(successCallback != null) {
                successCallback.invoke();
            }

        } catch (IllegalViewOperationException e) {
            if(errorCallback == null ){
                System.out.print(e.toString());
            }else{
                errorCallback.invoke(e.getMessage());
            }
        } catch (NumberFormatException e) {
            if(errorCallback == null ){
                System.out.print(e.toString());
            }else{
                errorCallback.invoke(e.getMessage());
            }
        }
    }

    @ReactMethod
    public void setAlarm(String triggerTime, String title, @Nullable String musicUri, Promise promise) {
        try {
            AlarmManager alarmManager = (AlarmManager) reactContext.getSystemService(Context.ALARM_SERVICE);
            Intent intent = new Intent(RNAlarmConstants.REACT_NATIVE_ALARM);
            intent.putExtra(RNAlarmConstants.REACT_NATIVE_ALARM_TITLE,title);
            intent.putExtra(RNAlarmConstants.REACT_NATIVE_ALARM_MUSIC_URI, musicUri);
            PendingIntent pendingIntent = PendingIntent.getBroadcast(reactContext, type, intent, PendingIntent.FLAG_UPDATE_CURRENT);

            long startTime = Long.parseLong(triggerTime);
            alarmManager.setExact(AlarmManager.RTC_WAKEUP, startTime, pendingIntent);
            promise.resolve(0);
        } catch (IllegalViewOperationException e) {
            promise.reject(e);
        } catch (NumberFormatException e) {
            promise.reject(e);
        }
    }
}