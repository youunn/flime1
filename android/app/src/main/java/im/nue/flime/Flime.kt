package im.nue.flime

import android.content.Intent
import android.inputmethodservice.InputMethodService
import android.os.SystemClock
import android.provider.Settings
import android.view.InputDevice
import android.view.KeyCharacterMap
import android.view.KeyEvent
import android.view.View
import android.view.inputmethod.EditorInfo
import android.view.inputmethod.InputMethodManager
import android.widget.LinearLayout
import io.flutter.FlutterInjector
import io.flutter.embedding.android.FlutterView
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.embedding.engine.dart.DartExecutor

class Flime : InputMethodService() {
    private lateinit var engine: FlutterEngine
    private lateinit var flutterView: FlutterView
    private lateinit var rootView: LinearLayout

    companion object {
        const val LIBRARY_NAME = "package:flime/main.dart"
        const val SHOW_KEYBOARD_ENTRY_POINT = "showKeyboard"
    }

    inner class ContextApi(private val service: InputMethodService) : Pigeon.ContextApi {

        override fun commit(content: Pigeon.Content): Boolean {
            service.currentInputConnection.commitText(content.text, 1)

            return true
        }

        override fun send(keyLabel: String): Boolean {
            KeycodeMap[keyLabel]?.also {
                if (it == KeyEvent.KEYCODE_ENTER)
                    service.sendKeyChar('\n')
                else
                    service.sendDownUpKeyEvents(it)
            } ?: return false
            return true
        }

        override fun sendShortcut(keyLabel: String, modifier: Long): Boolean {
            val code = KeycodeMap[keyLabel] ?: return false

            val metaState = KeycodeMap.getMetaState(modifier.toInt())
            val connection = service.currentInputConnection
            connection.clearMetaKeyStates(
                KeyEvent.META_FUNCTION_ON
                        or KeyEvent.META_SHIFT_MASK
                        or KeyEvent.META_ALT_MASK
                        or KeyEvent.META_CTRL_MASK
                        or KeyEvent.META_META_MASK
                        or KeyEvent.META_SYM_ON
            )
            connection.beginBatchEdit()
            val eventTime = SystemClock.uptimeMillis()

            for (action in listOf(KeyEvent.ACTION_DOWN, KeyEvent.ACTION_UP)) {
                service.currentInputConnection.sendKeyEvent(
                    KeyEvent(
                        eventTime,
                        SystemClock.uptimeMillis(),
                        action,
                        code,
                        0,
                        metaState,
                        KeyCharacterMap.VIRTUAL_KEYBOARD,
                        0,
                        KeyEvent.FLAG_SOFT_KEYBOARD or KeyEvent.FLAG_KEEP_TOUCH_MODE,
                        InputDevice.SOURCE_KEYBOARD
                    )
                )
            }
            connection.endBatchEdit()

            return true
        }
    }

    inner class InputMethodApi : Pigeon.InputMethodApi {
        override fun enable(): Boolean {
            Intent().apply {
                action = Settings.ACTION_INPUT_METHOD_SETTINGS
                addCategory(Intent.CATEGORY_DEFAULT)
                startActivity(this)
            }
            return true
        }

        override fun pick(): Boolean {
            val manager = getSystemService(INPUT_METHOD_SERVICE) as InputMethodManager
            manager.showInputMethodPicker()
            return true
        }
    }

    override fun onCreateInputView(): View {
        rootView = LinearLayout(this)

        // TODO: engine group
        engine = FlutterEngine(this)
        engine.dartExecutor.executeDartEntrypoint(
            DartExecutor.DartEntrypoint(
                FlutterInjector.instance().flutterLoader().findAppBundlePath(),
                LIBRARY_NAME,
                SHOW_KEYBOARD_ENTRY_POINT,
            )
        )
        engine.serviceControlSurface.attachToService(this, null, true)
        Pigeon.ContextApi.setup(engine.dartExecutor.binaryMessenger, ContextApi(this))
        Pigeon.InputMethodApi.setup(engine.dartExecutor.binaryMessenger, InputMethodApi())

        flutterView = WrapFlutterView(engine, this)
        flutterView.attachToFlutterEngine(engine)
        rootView.addView(flutterView)
        flutterView.layoutParams = LinearLayout.LayoutParams(
            LinearLayout.LayoutParams.MATCH_PARENT,
            760, // any number greater than zero
        )

        return rootView
    }

    override fun onStartInputView(info: EditorInfo?, restarting: Boolean) {
        super.onStartInputView(info, restarting)
        engine.lifecycleChannel.appIsResumed()
    }

    override fun onFinishInputView(finishingInput: Boolean) {
        super.onFinishInputView(finishingInput)
        engine.lifecycleChannel.appIsPaused()
    }

    override fun onDestroy() {
        super.onDestroy()
        rootView.removeView(flutterView)
        flutterView.detachFromFlutterEngine()
        if (::engine.isInitialized) engine.run {
            serviceControlSurface.detachFromService()
            lifecycleChannel.appIsDetached()
            destroy()
        }
    }
}