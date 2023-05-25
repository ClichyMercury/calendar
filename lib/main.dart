import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_app/data/auth.dart';
import 'package:task_app/firebase_options.dart';
import 'package:task_app/screens/connection.dart';
import 'package:task_app/screens/calendarView.dart';
import 'data/landing_page.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print("Handling a background message: ${message.messageId}");
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  NotificationSettings settings = await _firebaseMessaging.requestPermission(
    alert: true,
    announcement: true,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
    sound: true,
  );
  await _firebaseMessaging.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );
  print("User granted permission :${settings.authorizationStatus}");
  final fcmToken = await FirebaseMessaging.instance.getToken();
  print("FCM Token :${fcmToken}");
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    print("Got a message whilt in the foreground");
    print('onMesage: $message');
    if (message.notification != null) {
      print('Message also contained a notification: ${message.notification}');
    }
  });
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentfocus = FocusScope.of(context);
        if (!currentfocus.hasPrimaryFocus &&
            currentfocus.focusedChild != null) {
          FocusManager.instance.primaryFocus?.unfocus();
        }
      },
      child: Provider<AuthBase>(
        create: (context) => Auth(),
        child: MaterialApp(
          routes: {
            '/home': (context) => const CalendarView(),
            '/connexion': (context) => const ConnexionPage(),
          },
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
          home: LandingPage(),
        ),
      ),
    );
  }
}
