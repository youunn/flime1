package im.nue.flime

import android.app.Service
import android.content.Context
import android.content.Intent
import android.graphics.PixelFormat
import android.net.Uri
import android.os.IBinder
import android.provider.Settings
import android.view.*
import android.widget.LinearLayout
import androidx.appcompat.app.AppCompatActivity
import io.flutter.FlutterInjector
import io.flutter.embedding.android.FlutterSurfaceView
import io.flutter.embedding.android.FlutterView
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.embedding.engine.dart.DartExecutor

class ReverseLookupActivity : AppCompatActivity() {
    override fun onResume() {
        super.onResume()
        if (Settings.canDrawOverlays(this)) {
            Intent(this, ReverseLookupService::class.java).let {
                it.putExtra(
                    "text",
                    intent.getCharSequenceExtra(Intent.EXTRA_PROCESS_TEXT)?.toString()
                )
                startService(it)
            }
        } else {
            startActivity(
                Intent(
                    Settings.ACTION_MANAGE_OVERLAY_PERMISSION,
                    Uri.parse("package:$packageName")
                )
            )
        }
        finish()
    }
}

class ReverseLookupService : Service() {
    private lateinit var text: String
    private lateinit var windowManager: WindowManager
    private lateinit var engine: FlutterEngine
    private lateinit var flutterView: FlutterView
    private lateinit var rootView: View
    private var attached = false

    companion object {
        const val SHOW_REVERSE_LOOKUP_ENTRY_POINT = "showReverseLookup"
    }

    inner class ProcessTextApi : Pigeon.ProcessTextApi {
        override fun getText(): String = this@ReverseLookupService.text
    }

    override fun onStartCommand(intent: Intent?, flags: Int, startId: Int): Int {
        text = intent?.extras?.get("text").toString()
        return super.onStartCommand(intent, flags, startId)
    }

    override fun onCreate() {
        super.onCreate()
        windowManager = getSystemService(Context.WINDOW_SERVICE) as WindowManager

        engine = FlutterEngine(this)
        engine.dartExecutor.executeDartEntrypoint(
            DartExecutor.DartEntrypoint(
                FlutterInjector.instance().flutterLoader().findAppBundlePath(),
                SHOW_REVERSE_LOOKUP_ENTRY_POINT
            )
        )
        engine.serviceControlSurface.attachToService(this, null, true)
        Pigeon.ProcessTextApi.setup(engine.dartExecutor.binaryMessenger, ProcessTextApi())

        rootView = object : LinearLayout(this) {
            override fun dispatchKeyEvent(event: KeyEvent?): Boolean {
                if (event != null &&
                    event.action == KeyEvent.ACTION_DOWN &&
                    event.keyCode == KeyEvent.KEYCODE_BACK
                ) {
                    stopSelf()
                    return true
                }

                return super.dispatchKeyEvent(event)
            }
        }
        val listener = View.OnTouchListener { v, _ ->
            v.performClick()
            stopSelf()
            return@OnTouchListener true
        }
        rootView.setOnTouchListener(listener)

        flutterView = FlutterView(this, FlutterSurfaceView(this, true))
        flutterView.attachToFlutterEngine(engine)
        (rootView as LinearLayout).addView(flutterView)
        flutterView.layoutParams = LinearLayout.LayoutParams(
            LinearLayout.LayoutParams.MATCH_PARENT,
            resources.displayMetrics.heightPixels / 3,
        ).apply {
            marginStart = 48
            marginEnd = 48
        }

        val layoutParams = WindowManager.LayoutParams(
            WindowManager.LayoutParams.MATCH_PARENT,
            WindowManager.LayoutParams.WRAP_CONTENT,
            0,
            0,
            WindowManager.LayoutParams.TYPE_APPLICATION_OVERLAY,
            0,
            PixelFormat.TRANSPARENT,
        ).apply {
            gravity = Gravity.TOP or Gravity.CENTER_VERTICAL
        }
        windowManager.addView(rootView, layoutParams)
        attached = true
        engine.lifecycleChannel.appIsResumed()
    }

    override fun onDestroy() {
        super.onDestroy()
        if (::flutterView.isInitialized) flutterView.detachFromFlutterEngine()
        if (::engine.isInitialized) engine.run {
            serviceControlSurface.detachFromService()
            lifecycleChannel.appIsDetached()
            destroy()
        }
        if (attached) {
            windowManager.removeView(rootView)
        }
    }

    override fun onBind(intent: Intent?): IBinder? {
        return null
    }
}