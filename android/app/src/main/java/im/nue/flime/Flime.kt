package im.nue.flime

import android.inputmethodservice.InputMethodService
import android.text.TextUtils
import android.view.View
import android.view.inputmethod.EditorInfo
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
        const val SHOW_KEYBOARD_ENTRY_POINT = "showKeyboard"
    }

    inner class ContextApi : Pigeon.ContextApi {
        override fun commit(content: Pigeon.Content?): Boolean {
            content?.let {
                this@Flime.currentInputConnection.commitText(content.text, 1)
            }

            return content != null
        }

        override fun delete(): Boolean {
            val ic = this@Flime.currentInputConnection
            val selectedText = ic.getSelectedText(0) ?: ""
            if (TextUtils.isEmpty(selectedText)) {
                ic.deleteSurroundingText(1, 0)
            } else {
                ic.commitText("", 1)
            }
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
                SHOW_KEYBOARD_ENTRY_POINT
            )
        )
        engine.serviceControlSurface.attachToService(this, null, true)
        Pigeon.ContextApi.setup(engine.dartExecutor.binaryMessenger, ContextApi())

        flutterView = WrapFlutterView(engine, this)
        flutterView.attachToFlutterEngine(engine)
        rootView.addView(flutterView)
        flutterView.layoutParams = LinearLayout.LayoutParams(LinearLayout.LayoutParams.MATCH_PARENT, 0)

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