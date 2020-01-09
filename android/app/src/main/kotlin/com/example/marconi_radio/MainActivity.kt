package com.example.marconi_radio

import android.content.ActivityNotFoundException
import android.net.Uri
import android.content.Intent
import android.widget.Toast
import androidx.annotation.NonNull
import com.example.marconi_radio.services.MarconiStreamService
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugins.GeneratedPluginRegistrant


class MainActivity: FlutterActivity() {
    lateinit var streamService: MarconiStreamService
    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        GeneratedPluginRegistrant.registerWith(flutterEngine)
        streamService = MarconiStreamService(context)
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, "marconi_audio_stream").setMethodCallHandler { call, response ->
            when (call.method) {
                "play" -> {
                    streamService.play(call.argument<Any>("url").toString())
                    response.success(null)
                }
                "pause" -> {
                    streamService.pause()
                    response.success(null)
                }
                "stop" -> {
                    streamService.stop()
                    response.success(null)
                }
                "mute" -> {
                    streamService.mute()
                    response.success(null)
                }
                "rate" -> {
                    rateApp()
                    response.success(null)
                }
            }
        }
    }

    override fun onDestroy() {
        try {
            streamService.stop()
        } catch (e: Throwable) {
            print(e.message)
        }
        super.onDestroy()
    }

    private fun rateApp() {
        print("okkk")
        var uri: Uri = Uri.parse("market://details?id=com.dirisu.marconi_radio")
        var myAppLinkToMarket = Intent(Intent.ACTION_VIEW, uri)
        try {
            startActivity(myAppLinkToMarket)
        } catch (e: ActivityNotFoundException) {
            Toast.makeText(this, " unable to find market app", Toast.LENGTH_LONG).show()
            uri = Uri.parse("https://play.google.com/store/apps/details?id=com.dirisu.marconi_radio")
            myAppLinkToMarket = Intent(Intent.ACTION_VIEW, uri)
            try {
                startActivity(myAppLinkToMarket)
            } catch (e: Throwable) {
                Toast.makeText(this, "Cannot find web browser", Toast.LENGTH_LONG).show()
            }
        }
    }
}
