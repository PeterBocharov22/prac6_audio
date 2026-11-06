import 'package:flutter/material.dart';

import 'routes.dart';

import 'pages/loading_page.dart';
import 'pages/login_page.dart';
import 'pages/register_page.dart';
import 'pages/home_page.dart';
import 'pages/detail_page.dart';
import 'pages/profile_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Форматы аудиофайлов',

      theme: ThemeData(
        useMaterial3: true,
        fontFamily: 'Inter',
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFFFF5A76),
        ),
        scaffoldBackgroundColor: const Color(0xFFFFF8FA),
      ),

      initialRoute: Routes.loading,

      routes: {
        Routes.loading: (context) => const LoadingPage(),

        Routes.login: (context) => const LoginPage(),

        Routes.register: (context) => const RegisterPage(),

        Routes.home: (context) => const HomePage(),

        Routes.profile: (context) => const ProfilePage(
          name: 'Бочаров Пётр Андреевич',
          email: 'student@mail.ru',
        ),
      },

      onGenerateRoute: (settings) {
        if (settings.name == Routes.detail) {
          final format = settings.arguments;

          if (format is AudioFormat) {
            return MaterialPageRoute<int>(
              settings: settings,
              builder: (context) => DetailPage(
                format: format,
              ),
            );
          }
        }

        return null;
      },
    );
  }
}
