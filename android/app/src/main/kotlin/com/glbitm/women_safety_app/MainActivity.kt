package com.glbitm.women_safety_app

import android.Manifest
import android.content.pm.PackageManager
import android.telephony.SmsManager
import android.os.Build
import androidx.core.app.ActivityCompat
import androidx.core.content.ContextCompat
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity: FlutterActivity() {
    private val CHANNEL = "com.glbitm.women_safety_app/sms"
    private val SMS_PERMISSION_CODE = 101

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler { call, result ->
            when (call.method) {
                "sendDirectSms" -> {
                    val phones = call.argument<List<String>>("phones")
                    val message = call.argument<String>("message")
                    if (phones == null || message == null) {
                        result.error("INVALID_ARGS", "phones and message are required", null)
                        return@setMethodCallHandler
                    }
                    if (ContextCompat.checkSelfPermission(this, Manifest.permission.SEND_SMS)
                        != PackageManager.PERMISSION_GRANTED) {
                        result.error("PERMISSION_DENIED", "SEND_SMS permission not granted", null)
                        return@setMethodCallHandler
                    }
                    try {
                        val smsManager = if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.S) {
                            getSystemService(SmsManager::class.java)
                        } else {
                            @Suppress("DEPRECATION")
                            SmsManager.getDefault()
                        }
                        var sentCount = 0
                        for (phone in phones) {
                            // Split long messages into parts
                            val parts = smsManager.divideMessage(message)
                            if (parts.size > 1) {
                                smsManager.sendMultipartTextMessage(phone, null, parts, null, null)
                            } else {
                                smsManager.sendTextMessage(phone, null, message, null, null)
                            }
                            sentCount++
                        }
                        result.success(sentCount)
                    } catch (e: Exception) {
                        result.error("SEND_FAILED", e.message, null)
                    }
                }
                "checkSmsPermission" -> {
                    val granted = ContextCompat.checkSelfPermission(this, Manifest.permission.SEND_SMS) == PackageManager.PERMISSION_GRANTED
                    result.success(granted)
                }
                "requestSmsPermission" -> {
                    if (ContextCompat.checkSelfPermission(this, Manifest.permission.SEND_SMS)
                        != PackageManager.PERMISSION_GRANTED) {
                        ActivityCompat.requestPermissions(this, arrayOf(Manifest.permission.SEND_SMS), SMS_PERMISSION_CODE)
                        result.success(false)
                    } else {
                        result.success(true)
                    }
                }
                else -> result.notImplemented()
            }
        }
    }
}
