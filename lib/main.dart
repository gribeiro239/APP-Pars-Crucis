import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'screens/character_screen.dart';
import 'screens/character_list_screen.dart';
import 'screens/splash_screen.dart';
import 'screens/copyright_screen.dart';

void main() {
  runApp(const ParcrucisApp());
}

class ParcrucisApp extends StatelessWidget {
  const ParcrucisApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ParsCrucis',
      theme: ThemeData(
        primaryColor: const Color(0xFF5B0A16),
        scaffoldBackgroundColor: Colors.white,
        textTheme: GoogleFonts.robotoTextTheme(
          Theme.of(context).textTheme,
        ),
      ),
      initialRoute: '/',
      routes: {
        '/': (ctx) => const SplashScreen(),
        '/novo': (ctx) => const CharacterScreen(defaultTitle: 'Novo Persona'),
        '/carregar': (ctx) => const CharacterListScreen(),
        '/config': (ctx) => const CopyrightScreen(),
      },
    );
  }
}


