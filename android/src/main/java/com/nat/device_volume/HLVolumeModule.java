package com.nat.device_volume;

import android.content.Context;
import android.media.AudioManager;
import java.util.HashMap;

/**
 * Created by xuqinchao on 17/2/7.
 *  Copyright (c) 2017 Nat. All rights reserved.
 */

public class HLVolumeModule {

    private Context mContext;
    private static volatile HLVolumeModule instance = null;

    private HLVolumeModule(Context context){
        mContext = context;
    }

    public static HLVolumeModule getInstance(Context context) {
        if (instance == null) {
            synchronized (HLVolumeModule.class) {
                if (instance == null) {
                    instance = new HLVolumeModule(context);
                }
            }
        }

        return instance;
    }
    
    public void set(float volume, HLModuleResultListener listener){
        AudioManager manager = (AudioManager) mContext.getSystemService(Context.AUDIO_SERVICE);
        int streamMaxVolume = manager.getStreamMaxVolume(AudioManager.STREAM_SYSTEM);
        manager.setStreamVolume(AudioManager.STREAM_SYSTEM, Math.round(volume * streamMaxVolume), AudioManager.FLAG_SHOW_UI | AudioManager.FLAG_PLAY_SOUND);
        get(listener);
    }

    public void get(HLModuleResultListener listener){
        AudioManager manager = (AudioManager) mContext.getSystemService(Context.AUDIO_SERVICE);
        int streamVolume = manager.getStreamVolume(AudioManager.STREAM_SYSTEM);
        int streamMaxVolume = manager.getStreamMaxVolume(AudioManager.STREAM_SYSTEM);
        HashMap<String, Float> result = new HashMap<>();
        result.put("volume", streamVolume / (streamMaxVolume + 0.0f));
        listener.onResult(result);
    }
}
