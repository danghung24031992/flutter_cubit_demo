import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:device_preview/device_preview.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import '../../bloc/connectivity/connectivity_cubit.dart';
import '../../bloc/onboarding/onboarding_cubit.dart';
import '../../presentation/screens/my_homepage.dart';
import '../../presentation/screens/onboarding.dart';
import '../../presentation/screens/welcome_page.dart';
import '../../presentation/widgets/myindicator.dart';
import '../../shared/constants/consts_variables.dart';
import '../../shared/styles/themes.dart';

import 'bloc/auth/authentication_cubit.dart';
import 'cubit/counter_cubit.dart';
import 'navigation/routes.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  AwesomeNotifications().initialize(
    null,
    [
      NotificationChannel(
        channelKey: 'basic_channel',
        channelName: 'Basic Notifications',
        channelDescription: 'Notification channel for basic tests',
        importance: NotificationImportance.High,
        channelShowBadge: true,
        locked: false,
      ),
    ],
  );

  final prefs = await SharedPreferences.getInstance();
  final bool? seen = prefs.getBool('seen');
  profileimagesindex = prefs.getInt('plogo') ?? 0;
  runApp(
    DevicePreview(
        enabled: !kReleaseMode,
        tools: [
          ...DevicePreview.defaultTools,
        ],
        builder: (context) {
          final router = FluroRouter();
          Routes.configureRoutes(router);
          return MyApp(
            seen: seen,
            router: router,
          );
        }),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key, required this.router, required this.seen})
      : super(key: key);

  final FluroRouter router;
  final bool? seen;

  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (BuildContext context, Orientation orientation, deviceType) {
        return MultiBlocProvider(
          providers: [
            BlocProvider(
                lazy: false,
                create: (context) =>
                    ConnectivityCubit()..initializeConnectivity()),
            BlocProvider(
              create: (context) => OnboardingCubit(),
            ),
            BlocProvider(create: (context) => AuthenticationCubit()),
            BlocProvider(create: (context) => CounterCubit()),
          ],
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Todo App',
            themeMode: ThemeMode.light,
            theme: MyTheme.lightTheme,
            darkTheme: MyTheme.darkTheme,
            onGenerateRoute: router.generator,
            home: StreamBuilder<User?>(
              stream: FirebaseAuth.instance.authStateChanges(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const MyCircularIndicator();
                }
                if (snapshot.hasData) {
                  return const MyHomePage();
                }
                if (seen != null) {
                  return const WelcomePage();
                }
                return const OnboardingPage();
              },
            ),
          ),
        );
      },
    );
  }
}
