package com.moneytrail.app.sms

import android.Manifest
import android.app.Activity
import android.content.pm.PackageManager
import android.provider.Telephony
import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel

/**
 * The only bridge between Dart and the SMS APIs.
 *
 * It answers permission questions, reads the inbox and hands over queued
 * messages. It never parses a message: that is the Dart parser's job.
 */
class SmsPlugin(private val activity: Activity) : MethodChannel.MethodCallHandler {

    private var channel: MethodChannel? = null
    private var pendingPermissionResult: MethodChannel.Result? = null

    fun attach(messenger: BinaryMessenger) {
        channel = MethodChannel(messenger, CHANNEL).apply { setMethodCallHandler(this@SmsPlugin) }
    }

    fun detach() {
        channel?.setMethodCallHandler(null)
        channel = null
        pendingPermissionResult = null
    }

    override fun onMethodCall(call: MethodCall, result: MethodChannel.Result) {
        when (call.method) {
            "hasSmsPermission" -> result.success(hasSmsPermission())

            "requestSmsPermission" -> requestSmsPermission(result)

            "queryInbox" -> {
                val sinceMillis = call.argument<Number>("sinceMillis")?.toLong() ?: 0L
                val limit = call.argument<Number>("limit")?.toInt() ?: DEFAULT_INBOX_LIMIT
                result.success(queryInbox(sinceMillis, limit))
            }

            "drainQueue" -> result.success(SmsQueueHelper.drain(activity))

            "deleteQueueIds" -> {
                val ids = call.argument<List<Number>>("ids")?.map { it.toLong() } ?: emptyList()
                SmsQueueHelper.deleteIds(activity, ids)
                result.success(null)
            }

            else -> result.notImplemented()
        }
    }

    /** Replies to a pending [requestSmsPermission] call. */
    fun onRequestPermissionsResult(requestCode: Int, grantResults: IntArray) {
        if (requestCode != PERMISSION_REQUEST_CODE) return

        val pending = pendingPermissionResult ?: return
        pendingPermissionResult = null
        val granted = grantResults.isNotEmpty() &&
            grantResults.all { it == PackageManager.PERMISSION_GRANTED }
        pending.success(granted)
    }

    private fun hasSmsPermission(): Boolean = REQUIRED_PERMISSIONS.all {
        activity.checkSelfPermission(it) == PackageManager.PERMISSION_GRANTED
    }

    private fun requestSmsPermission(result: MethodChannel.Result) {
        if (hasSmsPermission()) {
            result.success(true)
            return
        }
        if (pendingPermissionResult != null) {
            result.error(
                "permission_request_in_progress",
                "An SMS permission request is already waiting for the user.",
                null
            )
            return
        }
        pendingPermissionResult = result
        activity.requestPermissions(REQUIRED_PERMISSIONS, PERMISSION_REQUEST_CODE)
    }

    /** Newest first, messages strictly newer than [sinceMillis]. */
    private fun queryInbox(sinceMillis: Long, limit: Int): List<Map<String, Any?>> {
        if (!hasSmsPermission()) return emptyList()

        val messages = mutableListOf<Map<String, Any?>>()
        activity.contentResolver.query(
            Telephony.Sms.Inbox.CONTENT_URI,
            arrayOf(Telephony.Sms.ADDRESS, Telephony.Sms.BODY, Telephony.Sms.DATE),
            "${Telephony.Sms.DATE} > ?",
            arrayOf(sinceMillis.toString()),
            "${Telephony.Sms.DATE} DESC"
        )?.use { cursor ->
            val addressIndex = cursor.getColumnIndexOrThrow(Telephony.Sms.ADDRESS)
            val bodyIndex = cursor.getColumnIndexOrThrow(Telephony.Sms.BODY)
            val dateIndex = cursor.getColumnIndexOrThrow(Telephony.Sms.DATE)

            while (messages.size < limit && cursor.moveToNext()) {
                messages += mapOf(
                    "sender" to (cursor.getString(addressIndex) ?: ""),
                    "body" to (cursor.getString(bodyIndex) ?: ""),
                    "timestampMillis" to cursor.getLong(dateIndex)
                )
            }
        }
        return messages
    }

    private companion object {
        const val CHANNEL = "com.moneytrail.app/sms"
        const val PERMISSION_REQUEST_CODE = 4601
        const val DEFAULT_INBOX_LIMIT = 500

        val REQUIRED_PERMISSIONS = arrayOf(
            Manifest.permission.READ_SMS,
            Manifest.permission.RECEIVE_SMS
        )
    }
}
