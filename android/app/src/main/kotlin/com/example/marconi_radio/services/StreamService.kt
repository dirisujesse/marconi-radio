package com.example.marconi_radio.services

import android.content.Context
import android.net.Uri

import com.google.android.exoplayer2.SimpleExoPlayer
import com.google.android.exoplayer2.DefaultLoadControl
import com.google.android.exoplayer2.DefaultRenderersFactory
import com.google.android.exoplayer2.C
import com.google.android.exoplayer2.ExoPlayerFactory
import com.google.android.exoplayer2.audio.AudioAttributes
import com.google.android.exoplayer2.source.ProgressiveMediaSource
import com.google.android.exoplayer2.source.MediaSource
import com.google.android.exoplayer2.upstream.DefaultHttpDataSourceFactory
import com.google.android.exoplayer2.trackselection.DefaultTrackSelector

class MarconiStreamService(val ctx: Context) {
    private var player: SimpleExoPlayer? = null
    private var playWhenReady = true
    private var playbackPosition = 0L
    private var volumeBeforeMuted = 0F
    private var muted = false

    private fun initializePlayer(url: String) {
        player = ExoPlayerFactory.newSimpleInstance(
                ctx,
                DefaultRenderersFactory(ctx),
                DefaultTrackSelector(), DefaultLoadControl())

        val uri = Uri.parse(url)
        val mediaSource = buildMediaSource(uri)

        player!!.setAudioAttributes(attributes(), true)
        player!!.prepare(mediaSource, true, true)
        player!!.playWhenReady = true
    }

    private fun buildMediaSource(uri: Uri): MediaSource {
        return ProgressiveMediaSource.Factory(DefaultHttpDataSourceFactory("com.example.marconi")).createMediaSource(uri)
    }

    private fun attributes(): AudioAttributes? {
            return AudioAttributes.Builder()
                    .setUsage(C.USAGE_MEDIA)
                    .setContentType(C.CONTENT_TYPE_MUSIC)
                    .build()
    }

    fun play(url: String) {
//        if (player == null) {
            initializePlayer(url)
//        } else {
//            player!!.playWhenReady = true
//        }
    }

    fun pause() {
        if (player != null) {
            player!!.playWhenReady = false
        }
    }

    fun stop() {
        if (player != null) {
            playbackPosition = player!!.currentPosition
            player!!.playWhenReady = false
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