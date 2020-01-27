# dc_nosucherrormethod_example

## Why?
Sample project with flutter and device_calendar.

## Steps to reproduce

Currently only tested on iOS 13 simulator.

1. Start app
2. Allow access to calendar
3. Push the button in the app
4. See it crash with 'NoSuchMethodError'

```
[VERBOSE-2:ui_dart_state.cc(157)] Unhandled Exception: type 'NoSuchMethodError' is not a subtype of type 'Exception'
#0      DeviceCalendarPlugin.createOrUpdateEvent (package:device_calendar/src/device_calendar.dart:202:54)
#1      _MyHomePageState.build.<anonymous closure> (package:dc_nosucherrormethod_example/main.dart:71:39)
<asynchronous suspension>
#2      _InkResponseState._handleTap (package:flutter/src/material/ink_well.dart:706:14)
#3      _InkResponseState.build.<anonymous closure> (package:flutter/src/material/ink_well.dart:789:36)
#4      GestureRecognizer.invokeCallback (package:flutter/src/gestures/recognizer.dart:182:24)
#5      TapGestureRecognizer.handleTapUp (package:flutter/src/gestures/tap.dart:486:11)
#6      BaseTapGestureRecognizer._checkUp (package:flutter/src/gestures/tap.dart:264:5)
#7      BaseTapGestureRecognizer.handlePrimaryPointer (package:flutter/src/gestures/tap.dart:199:7)
#8      PrimaryPointerGestureRecognizer.handleEvent (package:flutter/src/gestures/recognizer.da<…>

```

Looked at `/[...shortened].../.pub-cache/hosted/pub.dartlang.org/device_calendar-3.0.0/lib/src/device_calendar.dart:202` and found the line:

```dart
_parsePlatformExceptionAndUpdateResult<String>(e, res);
```

For debugging purposes I've added a statement `print('e = >$e< and res.success = >${res.isSuccess}< and res.data=>${res.data}<');` before and got:

```
e = >NoSuchMethodError: The getter 'data' was called on null.
Receiver: null
Tried calling: data< and res.success = >false< and res.data=>null<
```
(linebreak was added by the print statement not by me).