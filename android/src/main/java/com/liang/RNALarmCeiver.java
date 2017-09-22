package com.liang;

import android.content.BroadcastReceiver;
import android.content.Context;
import android.content.Intent;
import android.media.MediaPlayer;
import android.media.RingtoneManager;
import android.net.Uri;
import android.widget.Toast;

import com.facebook.common.util.UriUtil;

import java.io.IOException;

/**
 * Created by GBLiang on 9/22/2017.
 */

public class RNALarmCeiver extends BroadcastReceiver {
    @Override
    public void onReceive(Context context, Intent intent) {
        Uri uri;
        String title = intent.getStringExtra(RNAlarmConstants.REACT_NATIVE_ALARM_TITLE);
        String musicUri = intent.getStringExtra(RNAlarmConstants.REACT_NATIVE_ALARM_MUSIC_URI);
        if(musicUri == null || "".equals(musicUri)){
            uri = RingtoneManager.getDefaultUri(RingtoneManager.TYPE_ALARM);
        }else{
            uri = UriUtil.parseUriOrNull(musicUri);
        }

        Toast.makeText(context,title,Toast.LENGTH_SHORT).show();

        final MediaPlayer player = new MediaPlayer();
        try {
            player.setDataSource(context, uri);
            player.setLooping(true);
            player.prepareAsync();
            player.setOnPreparedListener(new MediaPlayer.OnPreparedListener() {
                @Override
                public void onPrepared(MediaPlayer mp) {
                    player.start();
                }
            });
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
}
