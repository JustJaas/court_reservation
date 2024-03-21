import 'package:court_reservation/presentation/blocs/BookingBloc/booking_bloc.dart';
import 'package:court_reservation/presentation/screens/home_screen.dart';
import 'package:court_reservation/presentation/screens/new_screen.dart';
import 'package:court_reservation/presentation/screens/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_fonts/google_fonts.dart';

void main() async {
  await loadEnvVars();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => BookingBloc()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Court Reservation',
        theme: ThemeData(
          textTheme: GoogleFonts.montserratTextTheme(),
          colorScheme: ColorScheme.fromSeed(
            seedColor: const Color.fromRGBO(90, 51, 255, 1),
          ),
        ),
        routes: {
          'home': (context) => const HomeScreen(),
          'new': (context) => const NewScreen(),
          'splash': (context) => const SplashScreen(),
        },
        initialRoute: 'splash',
        home: const SplashScreen(),
      ),
    );
  }
}

Future loadEnvVars() async {
  await dotenv.load(
    fileName: '.env',
  );
}
