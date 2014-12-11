package com.liberhood.snowmatch.snowmatch;

import android.app.Activity;
import android.support.v7.app.ActionBarActivity;
import android.os.Bundle;
import android.view.Menu;
import android.view.MenuItem;
import android.webkit.WebView;
import android.webkit.WebSettings;


public class MainActivity extends Activity {
    
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);
        WebView wv= (WebView)findViewById(R.id.webview);
        
        WebSettings settings = wv.getSettings();
        
        settings.setJavaScriptEnabled(true);
        settings.setAllowFileAccessFromFileURLs(true);
        settings.setAllowUniversalAccessFromFileURLs(true);
        
        wv.loadUrl("file:///android_asset/index.html");
        wv.getSettings().setJavaScriptEnabled(true);
    }
    
}
