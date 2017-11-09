package com.liang;

import android.app.AlertDialog;
import android.app.Notification;
import android.app.NotificationManager;
import android.app.PendingIntent;
import android.content.BroadcastReceiver;
import android.content.Context;
import android.content.DialogInterface;
import android.content.Intent;
import android.graphics.drawable.Drawable;
import android.media.MediaPlayer;
import android.media.RingtoneManager;
import android.net.Uri;
import android.os.CountDownTimer;
import android.os.Vibrator;
import android.view.WindowManager;
import android.widget.Toast;

import com.facebook.common.util.UriUtil;

import java.io.IOException;

import static android.content.Context.NOTIFICATION_SERVICE;

/**
 * Created by GBLiang on 9/22/2017.
 */

public class RNALarmCeiver extends BroadcastReceiver {

    static MediaPlayer player = new MediaPlayer();



    @Override
    public void onReceive(Context context, Intent intent) {

        if(intent.getExtras().getBoolean("stopNotification")) {
            if (player.isPlaying()) {
                player.stop();
                player.reset();
            }
        }
        else {

            Uri uri;
            String title = intent.getStringExtra(RNAlarmConstants.REACT_NATIVE_ALARM_TITLE);
            String musicUri = intent.getStringExtra(RNAlarmConstants.REACT_NATIVE_ALARM_MUSIC_URI);
            if (musicUri == null || "".equals(musicUri)) {
                uri = RingtoneManager.getDefaultUri(RingtoneManager.TYPE_ALARM);
            } else {
                uri = UriUtil.parseUriOrNull(musicUri);
            }


            //Toast.makeText(context,title,Toast.LENGTH_SHORT).show();

//        AlertDialog.Builder normalDialog =
//                new AlertDialog.Builder(context);
//        normalDialog.setTitle(title);
//        normalDialog.setNegativeButton("关闭",
//                new DialogInterface.OnClickListener() {
//                    @Override
//                    public void onClick(DialogInterface dialog, int which) {
//                        dialog.dismiss();
//                        player.stop();
//                    }
//                });
//
//        AlertDialog dialog = normalDialog.create();
//        dialog.getWindow()
//                .setType(WindowManager.LayoutParams.TYPE_SYSTEM_ALERT);
//        dialog.show();

            PendingIntent pi = PendingIntent.getActivity(context, 100, intent, PendingIntent.FLAG_CANCEL_CURRENT);

            Notification.Builder notificationBuilder = new Notification.Builder(context)
                    .setSmallIcon(android.R.drawable.sym_def_app_icon)//设置小图标
                    .setVibrate(new long[]{0,6000})
                    .setContentTitle(title)
                    .setContentText("闹钟");


            Notification notification = notificationBuilder.build();
            notificationBuilder.setDefaults(Notification.DEFAULT_ALL);
            notificationBuilder.setFullScreenIntent(pi, true);
            notificationBuilder.setDeleteIntent(createOnDismissedIntent(context));
            notificationBuilder.setAutoCancel(true);
            NotificationManager notificationManager = (NotificationManager) context.getSystemService(NOTIFICATION_SERVICE);
            notificationManager.notify(0, notification);


            try {
                player.setDataSource(context, uri);
                player.setLooping(true);
                player.prepareAsync();
                player.setOnPreparedListener(new MediaPlayer.OnPreparedListener() {
                    @Override
                    public void onPrepared(MediaPlayer mp) {
                        player.start();
                        new CountDownTimer(50000, 10000) {
                            public void onTick(long millisUntilFinished) {

                            }

                            public void onFinish() {
                                if (player.isPlaying()) {
                                    player.stop();
                                    player.reset();
                                }
                            }
                        }.start();
                    }
                });

            } catch (IOException e) {
                uri = RingtoneManager.getDefaultUri(RingtoneManager.TYPE_ALARM);
                //e.printStackTrace();
            }

            if (musicUri != null  && !"".equals(musicUri)) {
                try {

                    player.setDataSource(context, uri);
                    player.setLooping(true);
                    player.prepareAsync();
                    player.setOnPreparedListener(new MediaPlayer.OnPreparedListener() {
                        @Override
                        public void onPrepared(MediaPlayer mp) {
                            player.start();
                            new CountDownTimer(50000, 10000) {
                                public void onTick(long millisUntilFinished) {

                                }

                                public void onFinish() {
                                    if (player.isPlaying()) {
                                        player.stop();
                                        player.reset();
                                    }
                                }
                            }.start();
                        }
                    });
                } catch (IOException e) {
                    e.printStackTrace();
                }
            }
        }
    }

    private PendingIntent createOnDismissedIntent(Context context) {
        Intent intent = new Intent(RNAlarmConstants.REACT_NATIVE_ALARM);
        intent.putExtra("stopNotification", true);
        PendingIntent pendingIntent =
                PendingIntent.getBroadcast(context,1, intent, 0);
        return pendingIntent;
    }

}
