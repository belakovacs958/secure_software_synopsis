
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:responsive_framework/responsive_wrapper.dart';
import 'package:responsive_framework/utils/scroll_behavior.dart';
import 'package:secure_software_synopsis/features/global_widgets/pro_tips_page.dart';
import 'package:secure_software_synopsis/features/message_feature/presentation/pages/key_input_page.dart';

import 'features/account_feature/presentation/bloc/vendor_account_bloc.dart';
import 'features/account_feature/presentation/bloc/vendor_account_event.dart';
import 'features/account_feature/presentation/pages/vendor_login_page.dart';
import 'features/global_widgets/contacts_page.dart';
import 'features/message_feature/presentation/bloc/message_bloc.dart';

import 'features/message_feature/presentation/pages/chat_page.dart';
import 'firebase_options.dart';
import 'injection_container.dart' as di;
import 'injection_container.dart';

import 'utils/route_names.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await di.init();

  runApp(
    const MyApp(),
  );
  //HttpOverrides.global = MyHttpOverrides();
  debugRepaintRainbowEnabled = false;
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print('language: ' + WidgetsBinding.instance.window.locale.languageCode);
    return MultiBlocProvider(
      providers: [
        BlocProvider<MessageBloc>(
          create: (context) => sl<MessageBloc>(),
        ),
        BlocProvider<AccountBloc>(
          create: (context) => sl<AccountBloc>(),
        ),
      ],
      child: StreamBuilder<User?>(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data?.uid != null) {
                BlocProvider.of<AccountBloc>(context)
                    .add(GetUserInfoEvent(uid: snapshot.data!.uid));
              }
            }
            return MaterialApp.router(
              builder: (context, child) => ResponsiveWrapper.builder(
                BouncingScrollWrapper.builder(context, child!),
                maxWidth: 4000,
                minWidth: 450,
                defaultScale: true,
                breakpoints: [
                  const ResponsiveBreakpoint.resize(450, name: MOBILE),
                  const ResponsiveBreakpoint.autoScale(800, name: TABLET),
                  const ResponsiveBreakpoint.autoScale(1000, name: TABLET),
                  const ResponsiveBreakpoint.resize(1200, name: DESKTOP),
                  const ResponsiveBreakpoint.autoScale(2460, name: "4K"),
                ],
              ),
              debugShowCheckedModeBanner: false,
              routerConfig: _router,
              title: 'SecureChat',
              theme: ThemeData(
                colorScheme: ColorScheme.fromSeed(
                  seedColor: Color(0xff761DAF),
                ),
                appBarTheme: const AppBarTheme(
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                  scrolledUnderElevation: 0,
                ),
                buttonTheme:
                    ButtonThemeData(colorScheme: ColorScheme.fromSwatch()),
                // primarySwatch: Colors.blue,
                fontFamily: GoogleFonts.quicksand().fontFamily,
                textTheme: const TextTheme(
                    titleLarge: TextStyle(fontSize: 35),
                    titleMedium: TextStyle(fontSize: 25),
                    titleSmall: TextStyle(fontSize: 30),
                    bodySmall: TextStyle(fontSize: 15),
                    bodyLarge: TextStyle(fontSize: 20),
                    labelLarge:
                        TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                scaffoldBackgroundColor: Color(0xffffffff),
                disabledColor: Colors.grey,
                useMaterial3: true,
              ),

              // },
            );
          }),
    );
  }
}

final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>();
final GlobalKey<NavigatorState> _shellNavigatorKey2 =
    GlobalKey<NavigatorState>();
final GoRouter _router = GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: '/',
  routes: [
    ShellRoute(
        navigatorKey: _shellNavigatorKey2,
        builder: (context, state, child) {
          return child;
        },
        routes: [
          GoRoute(
            name: "/",
            path: "/",
            builder: (context, state) {
              return const LoginPage();
            },
          ),

          GoRoute(
            name: CONTACTS_PAGE,
            path: CONTACTS_PAGE,
            builder: (context, state) {

              return ContactsPage();
            },
          ),
        ]),
    GoRoute(
      name: CHAT,
      path: CHAT,
      builder: (context, state) {
        Map<String, String> params = state.queryParams as Map<String, String>;
        return ChatPage(queryParams: params,);
      },
    ),
    GoRoute(
      name: KEY_INPUT_PAGE,
      path: KEY_INPUT_PAGE,
      builder: (context, state) {
        Map<String, String> params = state.queryParams as Map<String, String>;
        return KeyInputPage(queryParams: params);
      },
    ),

    GoRoute(
      name: LOGIN_PAGE,
      path: LOGIN_PAGE,
      builder: (context, state) {
        return const LoginPage();
      },
    ),
    GoRoute(
      name: PRO_TIPS_PAGE,
      path: PRO_TIPS_PAGE,
      builder: (context, state) {
        return const ProTipsPage();
      },
    ),
  ],
//errorBuilder: (context, state) => const ErrorScreen(),
);
