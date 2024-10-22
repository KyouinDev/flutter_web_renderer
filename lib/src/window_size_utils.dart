// Copyright 2019 Google LLC
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//      http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
import 'package:flutter/services.dart';

const String _windowSizeChannelName = 'flutter/windowsize';

const String _setWindowFrameMethod = 'setWindowFrame';

class WindowSizeChannel {
  WindowSizeChannel._();

  final MethodChannel _platformChannel =
      const MethodChannel(_windowSizeChannelName);

  static final WindowSizeChannel instance = WindowSizeChannel._();

  Future setWindowFrame(Rect frame) async {
    assert(!frame.isEmpty, 'Cannot set window frame to an empty rect.');
    assert(frame.isFinite, 'Cannot set window frame to a non-finite rect.');
    return _platformChannel.invokeMethod(
      _setWindowFrameMethod,
      [frame.left, frame.top, frame.width, frame.height],
    );
  }
}

Future setWindowFrame(Rect frame) {
  return WindowSizeChannel.instance.setWindowFrame(frame);
}
