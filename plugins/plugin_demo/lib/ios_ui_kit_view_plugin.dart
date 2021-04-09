// https://flutter.dev/docs/development/platform-integration/platform-views
// UiKitView

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';

class IOSUiKitView extends StatelessWidget {
  const IOSUiKitView();
  Widget build(BuildContext context) {
    // This is used in the platform side to register the view.
    final String viewType = 'ui-kit-plugin-view';
    // Pass parameters to the platform side.
    final Map<String, dynamic> creationParams = <String, dynamic>{};

    return UiKitView(
      viewType: viewType,
      layoutDirection: TextDirection.ltr,
      creationParams: creationParams,
      creationParamsCodec: const StandardMessageCodec(),
    );
  }
}
