import 'package:flutter/material.dart';
import 'package:hackerone/resources/repository.dart';
import 'package:hackerone/ui/report_list/bloc.dart';
import 'ui/report_list/report_list.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:workmanager/workmanager.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'models/reports_list.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

void callbackDispatcher() {
  Workmanager.executeTask((task, inputData) async {
    try {
      switch (task) {
        case "bgFetchReports":
          print("Native called background task: $task");

          var androidPlatformChannelSpecifics = AndroidNotificationDetails(
              "newReports",
              'New Reports',
              'Get notification of new reports as soon as they get disclosed',
              importance: Importance.Max,
              priority: Priority.High,
              ticker: 'ticker');
          var iOSPlatformChannelSpecifics = IOSNotificationDetails();
          var platformChannelSpecifics = NotificationDetails(
              androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);
          int newReports =
              await ReportRepository(client: _client()).newReports();
          print(newReports);
          if (newReports > 0) {
            String message = '$newReports new reports disclosed';
            if (newReports == 1) {
              message = '$newReports new report disclosed';
            }
            await flutterLocalNotificationsPlugin.show(
              0,
              message,
              "Tap to view the reports",
              platformChannelSpecifics,
              payload: 'NewReportsNotification',
            );
          }
          return Future.value(true);
          break;
      }
    } catch (e) {
      print(e);
      return Future.value(true);
    }
    return Future.value(true);
  });
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  BlocSupervisor.delegate = await HydratedBlocDelegate.build();
  Workmanager.initialize(callbackDispatcher, isInDebugMode: false);
  Workmanager.registerPeriodicTask(
    "task0",
    "bgFetchReports",
    frequency: Duration(minutes: 30),
    initialDelay: Duration(minutes: 30),
  );

  var initializationSettingsAndroid = AndroidInitializationSettings('app_icon');
  // Note: permissions aren't requested here just to demonstrate that can be done later using the `requestPermissions()` method
  // of the `IOSFlutterLocalNotificationsPlugin` class
  var initializationSettingsIOS = IOSInitializationSettings(
      requestAlertPermission: false,
      requestBadgePermission: false,
      requestSoundPermission: false);
  var initializationSettings = InitializationSettings(
      initializationSettingsAndroid, initializationSettingsIOS);
  await flutterLocalNotificationsPlugin.initialize(initializationSettings,
      onSelectNotification: (String payload) async {
    if (payload != null) {
      debugPrint('notification payload: ' + payload);
    }
  });

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => ReportRepository(client: _client()),
      child: MaterialApp(
          title: 'Hacker One',
          theme: ThemeData(
            primarySwatch: Colors.blueGrey,
            brightness: Brightness.light,
            pageTransitionsTheme: PageTransitionsTheme(
              builders: {
                TargetPlatform.android: ZoomPageTransitionsBuilder(),
              },
            ),
          ),
          darkTheme: ThemeData(
            scaffoldBackgroundColor: Colors.black,
            brightness: Brightness.dark,
            colorScheme: ColorScheme.dark(
              primary: Colors.cyan,
            ),
            pageTransitionsTheme: PageTransitionsTheme(
              builders: {TargetPlatform.android: ZoomPageTransitionsBuilder()},
            ),
          ),
          home: BlocProvider(
            create: (context) => ReportListBloc(
              reportRepository: context.repository<ReportRepository>(),
            ),
            child: ReportList(title: 'Hacker One'),
          ),
          debugShowCheckedModeBanner: false),
    );
  }
}

GraphQLClient _client() {
  final HttpLink _link = HttpLink(
    uri: 'https://hackerone.com/graphql',
  );

  return GraphQLClient(
    cache: InMemoryCache(),
    link: _link,
  );
}
