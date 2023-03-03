// Copyright Amazon.com, Inc. or its affiliates. All Rights Reserved.
// SPDX-License-Identifier: Apache-2.0

package com.amazonaws.amplify.amplify_push_notifications

import android.content.Context
import android.content.Intent
import android.os.Handler
import android.util.Log
import androidx.core.app.JobIntentService
import com.google.firebase.messaging.RemoteMessage
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.embedding.engine.dart.DartExecutor
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.view.FlutterCallbackInformation
import io.flutter.view.FlutterMain
import java.util.*
import java.util.concurrent.atomic.AtomicBoolean
import kotlin.collections.ArrayDeque

private const val TAG = "PushBackgroundService"

class PushNotificationBackgroundService : MethodChannel.MethodCallHandler, JobIntentService() {
    private val queue = ArrayDeque<List<Any>>()
    private lateinit var backgroundChannel: MethodChannel
    private lateinit var mContext: Context

    companion object {

        @JvmStatic
        private val JOB_ID = UUID.randomUUID().mostSignificantBits.toInt()

        @JvmStatic
        private var sBackgroundFlutterEngine: FlutterEngine? = null

        @JvmStatic
        private val serviceStarted = AtomicBoolean(false)

        @JvmStatic
        fun enqueueWork(context: Context, work: Intent) {
            enqueueWork(context, PushNotificationBackgroundService::class.java, JOB_ID, work)
        }
    }

    private fun startPushNotificationService(context: Context) {
        synchronized(serviceStarted) {
            mContext = context
            if (sBackgroundFlutterEngine == null) {

                val callbackHandle = context.getSharedPreferences(
                    PushNotificationConstants.SHARED_PREFERENCES_KEY, Context.MODE_PRIVATE
                ).getLong(
                    PushNotificationConstants.CALLBACK_DISPATCHER_HANDLE_KEY, 0
                )
                if (callbackHandle == 0L) {
                    Log.w(TAG, "Warning: no callback registered")
                    return
                }
                val callbackInfo =
                    FlutterCallbackInformation.lookupCallbackInformation(callbackHandle)
                if (callbackInfo == null) {
                    Log.e(TAG, "Error: failed to find callback")
                    return
                }
                Log.i(TAG, "Starting PushNotificationBackgroundService...")

                sBackgroundFlutterEngine = FlutterEngine(context)

                val args = DartExecutor.DartCallback(
                    context.assets, FlutterMain.findAppBundlePath(), callbackInfo
                )
                sBackgroundFlutterEngine!!.dartExecutor.executeDartCallback(args)
            }
        }
        backgroundChannel = MethodChannel(
            sBackgroundFlutterEngine!!.dartExecutor.binaryMessenger,
            "plugins.flutter.io/amplify_push_notification_plugin_background"
        )
        backgroundChannel.setMethodCallHandler(this)
    }

    override fun onMethodCall(call: MethodCall, result: MethodChannel.Result) {
        when (call.method) {
            "PushNotificationBackgroundService.initialized" -> {
                synchronized(serviceStarted) {
                    // If events were added to the queue when the service was initializing, emits those
                    while (!queue.isEmpty()) {
                        backgroundChannel.invokeMethod("", queue.removeFirst())
                    }
                    serviceStarted.set(true)
                }
            }
            else -> result.notImplemented()
        }
        result.success(null)
    }

    override fun onHandleWork(intent: Intent) {
        Log.i(TAG, "Handling work @ PushNotificationBackgroundService...")
        if (!intent.isPushNotificationIntent) {
            return
        }
        val remoteMessage = RemoteMessage(intent.extras)
        val notificationMap = remoteMessage.asPayload().asChannelMap()

        val bgExternalCallbackHandle =
            getCallbackHandleForKey(PushNotificationConstants.BG_EXTERNAL_CALLBACK_HANDLE_KEY)
        val bgInternalCallbackHandle =
            getCallbackHandleForKey(PushNotificationConstants.BG_INTERNAL_CALLBACK_HANDLE_KEY)

        if (bgInternalCallbackHandle == 0L) {
            Log.w(TAG, "Warning: no internal callback registered")
            return
        }

        val callbackHandleList = listOf(
            mapOf(
                "handle" to bgInternalCallbackHandle, "notification" to notificationMap
            ), mapOf(
                "handle" to bgExternalCallbackHandle, "notification" to notificationMap
            )
        )
        synchronized(serviceStarted) {
            if (!serviceStarted.get()) {
                // Queue up geofencing events while background isolate is starting
                queue.add(callbackHandleList)
            } else {
                // Callback method name is intentionally left blank.
                Handler(mContext.mainLooper).post {
                    backgroundChannel.invokeMethod(
                        "", callbackHandleList
                    )
                }
            }
        }
    }

    private fun getCallbackHandleForKey(callbackKey: String): Long {
        return mContext.getSharedPreferences(
            PushNotificationConstants.SHARED_PREFERENCES_KEY, MODE_PRIVATE
        ).getLong(callbackKey, 0)
    }

    override fun onCreate() {
        super.onCreate()
        startPushNotificationService(this)
    }
}