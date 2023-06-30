package com.mendix.nativetemplate;

import android.content.Context;

import androidx.lifecycle.Lifecycle;
import androidx.lifecycle.LifecycleObserver;
import androidx.lifecycle.OnLifecycleEvent;


public class MendixActivityObserver implements LifecycleObserver {
    private final Context context;

    public MendixActivityObserver(Context activity) {
        this.context = activity;
    }

    @OnLifecycleEvent(Lifecycle.Event.ON_CREATE)
    void onCreate() {
        
    }

    @OnLifecycleEvent(Lifecycle.Event.ON_RESUME)
    void onResume() {
        
    }

    @OnLifecycleEvent(Lifecycle.Event.ON_START)
    void onStart() {
      
    }

    @OnLifecycleEvent(Lifecycle.Event.ON_PAUSE)
    void onPause() {
        
    }

    @OnLifecycleEvent(Lifecycle.Event.ON_STOP)
    void onStop() {
        
    }

    @OnLifecycleEvent(Lifecycle.Event.ON_DESTROY)
    void onDestroy() {
        
    }
}
