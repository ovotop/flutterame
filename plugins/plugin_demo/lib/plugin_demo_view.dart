import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'android_hybrid_composition_plugin.dart';
import 'android_virtual_display_plugin.dart';
import 'ios_ui_kit_view_plugin.dart';

class PluginDemoView extends StatelessWidget {
  const PluginDemoView();

  List<Widget> buildChildren() {
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return [
          Text('AndroidVirtualDisplayPluginView'),
          SizedBox(
              child: Center(child: AndroidVirtualDisplayPluginView()),
              height: 200),
          SizedBox(height: 10),
          Text('AndroidHybridCompositionPluginView'),
          SizedBox(
              child: Center(child: AndroidHybridCompositionPluginView()),
              height: 200),
          SizedBox(height: 10),
        ];
      case TargetPlatform.iOS:
        return [
          Text('iOSUikitView'),
          SizedBox(child: Center(child: IOSUiKitView()), height: 200),
        ];
      default:
        return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: buildChildren());
  }
}
