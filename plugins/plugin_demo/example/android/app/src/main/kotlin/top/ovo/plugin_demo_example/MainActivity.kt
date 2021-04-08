package top.ovo.plugin_demo_example

import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import dev.flutter.example.PluginViewFactory

class MainActivity : FlutterActivity() {
    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        flutterEngine
            .platformViewsController
            .registry
            .registerViewFactory("hybrid-composition-plugin-view", PluginViewFactory())

        flutterEngine
            .platformViewsController
            .registry
            .registerViewFactory("virtual-display-plugin-view", PluginViewFactory())

    }
}
