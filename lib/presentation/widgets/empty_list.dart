import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class EmptyList extends StatelessWidget {
  const EmptyList({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset(
              'assets/lotties/no_data.json',
              width: 300,
              height: 300,
            ),
            const SizedBox(height: 20),
            const Text(
              "Aún no hay reservas",
              style: TextStyle(
                color: Color.fromRGBO(90, 51, 255, 1),
                fontSize: 20,
                fontWeight: FontWeight.w900,
                letterSpacing: 2,
              ),
            )
          ],
        ),
      ),
    );
  }
}
