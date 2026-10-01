package com.moneytrail.app.sms

import android.content.BroadcastReceiver
import android.content.Context
import android.content.Intent
import android.provider.Telephony
import android.telephony.SmsMessage

/**
 * Parks an incoming SMS in `inbox_queue` and nothing else.
 *
 * No parsing happens here and no Flutter engine is started: Dart owns the
 * parser and drains the queue on the next app start or resume. The broadcast is
 * never aborted, so other SMS apps still see the message.
 */
class SmsReceivedReceiver : BroadcastReceiver() {

    override fun onReceive(context: Context, intent: Intent) {
        if (intent.action != Telephony.Sms.Intents.SMS_RECEIVED_ACTION) return

        val messages: Array<SmsMessage> =
            Telephony.Sms.Intents.getMessagesFromIntent(intent) ?: return
        val first = messages.firstOrNull() ?: return

        val sender = first.originatingAddress ?: return
        // A long SMS arrives as several PDUs that together form one body.
        val body = messages.joinToString(separator = "") { it.displayMessageBody ?: "" }
        if (body.isEmpty()) return

        val receivedAt = first.timestampMillis.takeIf { it > 0L } ?: System.currentTimeMillis()

        SmsQueueHelper.enqueue(context, sender, body, receivedAt)
    }
}
