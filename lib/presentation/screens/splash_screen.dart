import 'dart:async';

import 'package:court_reservation/presentation/blocs/BookingBloc/booking_bloc.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    context.read<BookingBloc>().add(InitializeDB());
    super.initState();
    Timer(const Duration(seconds: 3), () {
      Navigator.pushReplacementNamed(context, 'home');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset(
              'assets/lotties/loader.json',
              width: 500,
              height: 500,
            ),
            const SizedBox(height: 20),
            const Text(
              "Cargando . . .",
              style: TextStyle(
                color: Color.fromRGBO(90, 51, 255, 1),
                fontSize: 20,
                fontWeight: FontWeight.w900,
                letterSpacing: 4,
              ),
            )
          ],
        ),
      ),
    );
  }
}
