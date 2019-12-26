package com.example.marconi_radio.services

import android.content.Context
import android.net.Uri

import com.google.android.exoplayer2.*
import com.google.android.exoplayer2.source.ExtractorMediaSource
import com.google.android.exoplayer2.source.MediaSource
import com.google.android.exoplayer2.upstream.DefaultHttpDataSourceFactory
import com.google.android.exoplayer2.trackselection.DefaultTrackSelector

class MarconiStreamService(val ctx: Context) {
    private var player: SimpleExoPlayer? = null
    private var playWhenReady = true
    private var playbackPosition = 0L
    private var volumeBeforeMuted = 0F
    private var muted = false
//    private var  notificationManager: PlayerNotificationManager = PlayerNotificationManager(ctx, "marconi_radio_notifications", Integer.parseInt(SimpleDateFormat("ddHHmmss", Locale.US).format(Date().time)), DescriptionAdapter())

//    companion object {
//        var instance: MarconiStreamService? = null;
//    }
//
//    init {
//        instance = if (instance == null) {
//            MarconiStreamService(ctx)
//        } else {
//            instance
//        }
//    }

    private fun initializePlayer(url: String) {
        player = ExoPlayerFactory.newSimpleInstance(
                DefaultRenderersFactory(ctx),
                DefaultTrackSelector(), DefaultLoadControl())
        player!!.playWhenReady = true
        player!!.seekTo(playbackPosition)
        val uri = Uri.parse(url)
        val mediaSource = buildMediaSource(uri)
        player!!.prepare(mediaSource, true, false)
    }

    private fun buildMediaSource(uri: Uri): MediaSource {
        return ExtractorMediaSource.Factory(
                DefaultHttpDataSourceFactory("com.example.marconi")).createMediaSource(uri)
    }

    fun play(url: String) {
        if (player == null) {
            initializePlayer(url)
        } else {
            player!!.playWhenReady = true
        }
    }

    fun pause() {
        if (player != null) {
            player!!.playWhenReady = false
        }
    }

    fun stop() {
        if (player != null) {
            playbackPosition = player!!.currentPosition
            playWhenReady = player!!.playWhenReady
            player?.release()
            player = null
        }
    }

    fun mute() {
        if (player != null) {
            if(muted){
                player!!.volume = volumeBeforeMuted
                muted = false
            }
            else{
                volumeBeforeMuted = player!!.volume
                muted = true
            }
        }
    }
}