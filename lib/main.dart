import 'dart:ui';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';

import 'features/google_sign_in/bloc/sign_in_with_google_bloc.dart';
import 'features/google_sign_in/presentation/screens/sign_in_with_google.dart';
import 'features/login_page/bloc/login_bloc.dart';
import 'features/login_page/data/data_provider/login_api_provider.dart';
import 'features/login_page/data/data_provider/login_secure_storage_provider.dart';
import 'features/login_page/data/repository/login_repository.dart';
import 'features/login_page/presentation/screens/login_page.dart';
import 'features/otp_screen/bloc/otp_screen_bloc.dart';
import 'features/otp_screen/data/data_provider/otp_api_provider.dart';
import 'features/otp_screen/data/repository/otp_repository.dart';
import 'features/signup/bloc/signup_bloc.dart';
import 'features/signup/data/data_provider/signup_api_provider.dart';
import 'features/signup/presentation/screens/sign_up.dart';
import 'features/splash_screen/bloc/splash_screen_bloc.dart';
import 'features/splash_screen/data/repository/splash_screen_repository.dart';
import 'features/splash_screen/presentation/screens/splash_screen.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  FlutterError.onError = (errorDetails) {
    FirebaseCrashlytics.instance.recordFlutterFatalError(errorDetails);
  };

  PlatformDispatcher.instance.onError = (error, stack) {
    FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
    return true;
  };
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late final Client client;

  @override
  void initState() {
    super.initState();
    client = Client();
  }

  @override
  void dispose() {
    client.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent, // transparent status bar
        statusBarIconBrightness: Brightness.dark, // dark text for status bar
        statusBarBrightness: Brightness.light,
      ),
    );

    return Provider<http.Client>(
        create: (context) => client,
        child: MultiRepositoryProvider(
          providers: [
            RepositoryProvider(
              create: (context) => SplashScreenRepository(),
            ),
            RepositoryProvider(
              create: (context) => LoginRepository(
                LoginApiProvider(context.read<http.Client>()),
                LoginSecureStorageProvider(),
              ),
            ),
            RepositoryProvider(
                create: (context) =>
                    SignupApiProvider(context.read<http.Client>())),
            RepositoryProvider(
              create: (context) => OtpRepository(
                OtpApiProvider(
                  context.read<http.Client>(),
                ),
              ),
            ),
          ],
          child: MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) => SplashScreenBloc(
                    context.read<SplashScreenRepository>(),
                    context.read<http.Client>()),
              ),
              BlocProvider(create: (context) => SignInWithGoogleBloc()),
              BlocProvider(
                create: (context) => LoginBloc(context.read<LoginRepository>()),
              ),
              BlocProvider(
                create: (context) => SignupBloc(
                  context.read<SignupApiProvider>(),
                ),
              ),
              BlocProvider(
                create: (context) =>
                    OtpScreenBloc(context.read<OtpRepository>()),
              ),
            ],
            child: _app(),
          ),
        ));
  }

  _app() {
    return MaterialApp(
      title: 'FlavR',
      theme: ThemeData(
          textTheme: GoogleFonts.poppinsTextTheme(),
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.white)),
      debugShowCheckedModeBanner: false,
      initialRoute: "/signInWithGoogle",
      routes: {
        "/splashscreen": (context) => const SplashScreen(),
        "/signInWithGoogle": (context) => const SignInWithGoogle(),
        "/login": (context) => const LoginPage(),
        "/signUp": (context) => const SignUp(),
      },
    );
  }
}
