package im.nue.flime

import android.content.Intent
import android.provider.Settings
import android.view.inputmethod.InputMethodManager
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine

class MainActivity : FlutterActivity() {
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

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        flutterEngine.dartExecutor.binaryMessenger.let {
            Pigeon.InputMethodApi.setup(it, InputMethodApi())
        }
    }
}
