import 'package:finance_forum/constants.dart';
import 'package:flutter/material.dart';

class Welcome extends StatelessWidget {
  const Welcome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueAccent,
      body: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          const Text('\$ Finance Forum',
              style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.white)),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 10),
            child: TextField(
              keyboardType: TextInputType.phone,
              cursorColor: Colors.red,
              style: const TextStyle(
                  color: Colors.white, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
              decoration:
                  kInputDecoration.copyWith(hintText: 'Enter mobile number'),
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.pushNamed(context, '/otp verify');
            },
            style: TextButton.styleFrom(backgroundColor: Colors.white),
            child: const Text(
              'Get OTP',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          )
        ]),
      ),
    );
  }
}
