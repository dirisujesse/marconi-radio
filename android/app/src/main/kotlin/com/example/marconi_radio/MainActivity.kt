package com.example.marconi_radio

import android.os.Bundle
import android.os.PersistableBundle
import androidx.annotation.NonNull;
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugins.GeneratedPluginRegistrant

import com.example.marconi_radio.services.MarconiStreamService

class MainActivity: FlutterActivity() {
    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        GeneratedPluginRegistrant.registerWith(flutterEngine)
        val streamService = MarconiStreamService(context)
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
            }
        }
    }
}
