package top.ovo.plugin_demo

import android.content.Context
import android.graphics.Color
import android.view.View
import android.widget.TextView
import io.flutter.plugin.platform.PlatformView

internal class PluginView(context: Context, id: Int, creationParams: Map<String?, Any?>?) : PlatformView {
    private val textView: TextView

    override fun getView(): View {
        return textView
    }

    override fun dispose() {}

    init {
        textView = TextView(context)
        textView.textSize = 16f
        textView.setBackgroundColor(Color.rgb(127, 255, 127))
        textView.text = "Rendered on a native Android view (id: $id)"
    }
}