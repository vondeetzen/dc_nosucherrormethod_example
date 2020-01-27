import 'package:device_calendar/device_calendar.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  DeviceCalendarPlugin _deviceCalendarPlugin;

  _MyHomePageState() {
    _deviceCalendarPlugin = DeviceCalendarPlugin();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            RaisedButton(
              child: Text('Test me & crash :-('),
              onPressed: () async {
                print('Tr ${_deviceCalendarPlugin.runtimeType}');
                var permissionsGranted =
                    await _deviceCalendarPlugin.hasPermissions();
                if (permissionsGranted.isSuccess && !permissionsGranted.data) {
                  permissionsGranted =
                      await _deviceCalendarPlugin.requestPermissions();
                  if (!permissionsGranted.isSuccess ||
                      !permissionsGranted.data) {
                    return;
                  }
                }
                final calendarsResult =
                    await _deviceCalendarPlugin.retrieveCalendars();
                final calendars = calendarsResult?.data;
                final writeableCalendar = calendars.firstWhere((cal) {
                  return cal.isReadOnly == false;
                });
                final event = Event(
                  writeableCalendar.id,
                  title: 'My small event',
                  start: DateTime.now(),
                  end: DateTime.now().add(Duration(minutes: 30)),
                );
                _deviceCalendarPlugin.createOrUpdateEvent(event);
              },
            ),
          ],
        ),
      ),
    );
  }
}
