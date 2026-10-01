package com.moneytrail.app

import com.moneytrail.app.sms.SmsPlugin
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine

class MainActivity : FlutterActivity() {

    private var smsPlugin: SmsPlugin? = null

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        smsPlugin = SmsPlugin(this).also { it.attach(flutterEngine.dartExecutor.binaryMessenger) }
    }

    override fun onRequestPermissionsResult(
        requestCode: Int,
        permissions: Array<out String>,
        grantResults: IntArray
    ) {
        super.onRequestPermissionsResult(requestCode, permissions, grantResults)
        smsPlugin?.onRequestPermissionsResult(requestCode, grantResults)
    }

    override fun onDestroy() {
        smsPlugin?.detach()
        smsPlugin = null
        super.onDestroy()
    }
}
