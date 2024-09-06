import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:loginapp/screens/login_screen.dart';

void main() async {
  await dotenv.load(fileName: ".env");
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(
            inputDecorationTheme: const InputDecorationTheme(
                border: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white, strokeAlign: 1),
            )),
            appBarTheme: const AppBarTheme(
                backgroundColor: Color.fromARGB(255, 16, 16, 16)),
            scaffoldBackgroundColor: const Color.fromARGB(255, 16, 16, 16),
            textTheme: Typography.whiteCupertino,
            textSelectionTheme: const TextSelectionThemeData(
                cursorColor: Colors.white,
                selectionColor: Colors.white,
                selectionHandleColor: Colors.white)),
        title: 'Material App',
        home: const LoginScreen());
  }
}
