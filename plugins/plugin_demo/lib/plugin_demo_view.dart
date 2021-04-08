import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:plugin_demo/android_hybrid_composition_plugin.dart';
import 'package:plugin_demo/android_virtual_display_plugin.dart';

class PluginDemoView extends StatelessWidget {
  const PluginDemoView();

  List<Widget> buildChildren() {
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return [
          Text('AndroidVirtualDisplayPluginView'),
          SizedBox(
              child: Center(child: AndroidVirtualDisplayPluginView()),
              height: 400),
          SizedBox(height: 10),
          Text('AndroidHybridCompositionPluginView'),
          SizedBox(
              child: Center(child: AndroidHybridCompositionPluginView()),
              height: 400),
          SizedBox(height: 10),
        ];
      case TargetPlatform.iOS:
        return [Text('iOS')];
      default:
        return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: buildChildren());
  }
}
