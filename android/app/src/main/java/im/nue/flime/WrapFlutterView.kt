package im.nue.flime

import android.annotation.SuppressLint
import android.content.Context
import androidx.core.view.updateLayoutParams
import io.flutter.embedding.android.FlutterView
import io.flutter.embedding.engine.FlutterEngine

@SuppressLint("ViewConstructor")
class WrapFlutterView(engine: FlutterEngine, context: Context) : FlutterView(context, null) {
    init {
        Pigeon.LayoutApi.setup(engine.dartExecutor.binaryMessenger, LayoutApi())
    }

    inner class LayoutApi : Pigeon.LayoutApi {
        override fun setHeight(h: Long?) {
            h?.toInt()?.let {
                this@WrapFlutterView.updateLayoutParams { height = it }
                requestLayout()
            }
        }
    }
}