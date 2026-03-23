import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:provider/provider.dart';
import 'providers/space_provider.dart';
import 'package:spacebook/splash.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
 runApp(
  MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => SpaceProvider()),
    ],
    child: const SpaceBookApp(),
  ),
);
}

class SpaceBookApp extends StatefulWidget {
  const SpaceBookApp({super.key});

  // ✅ THIS METHOD WAS MISSING
  static _SpaceBookAppState? of(BuildContext context) {
    return context.findAncestorStateOfType<_SpaceBookAppState>();
  }

  @override
  State<SpaceBookApp> createState() => _SpaceBookAppState();
}

class _SpaceBookAppState extends State<SpaceBookApp> {
  ThemeMode _themeMode = ThemeMode.light;

  void toggleTheme() {
    setState(() {
      _themeMode =
          _themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: _themeMode,

      theme: ThemeData(
        brightness: Brightness.light,
        fontFamily: 'Poppins',
        scaffoldBackgroundColor: Colors.white,
        cardColor: Colors.white,
        shadowColor: Colors.black,
        textTheme: TextTheme(
          bodyLarge: TextStyle(color: Color(0xFF0F172A)),
          bodyMedium: TextStyle(color: Color(0xFF0F172A)),
          bodySmall: TextStyle(color: Color(0xFF0F172A)),
          titleLarge: TextStyle(color: Color(0xFF0F172A), fontWeight: FontWeight.bold),
        ),
        colorScheme: ColorScheme.light(
          primary: Color(0xFF3F6B00),
          surface: Color(0xFFF6F8F8),
          primaryContainer: Colors.white,
          secondaryContainer: Colors.grey.shade200,
          onPrimaryContainer: Colors.black,
          primaryFixedDim: Colors.grey.shade300,
        ),
      ),

      darkTheme: ThemeData(
        brightness: Brightness.dark,
        fontFamily: 'Poppins',
        scaffoldBackgroundColor:Color(0xFF1E1E1E),
        cardColor: Color(0xFF1E1E1E),
        shadowColor: Colors.white,
        textTheme: TextTheme(
          bodyLarge: TextStyle(color: Colors.white),
          bodyMedium: TextStyle(color: Colors.white),
          bodySmall: TextStyle(color: Colors.white),
          titleLarge: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        colorScheme: ColorScheme.dark(
          primary: Color(0xFF3F6B00),
          surface: Color(0xFF1B1B1B),
          primaryContainer: Color(0xFF1E293B),
          secondaryContainer: Color(0xFF1E293B),
          onPrimaryContainer: Colors.white,
          primaryFixedDim: Colors.grey.shade800,
        ),
      ),
      home: SplashScreen(),
    );
  }
}
