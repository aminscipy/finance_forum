import 'package:flutter/material.dart';
import 'package:finance_forum/constants.dart';

class OtpVerify extends StatelessWidget {
  const OtpVerify({super.key});

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
              cursorColor: Colors.red,
              style: const TextStyle(
                  color: Colors.white, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
              decoration: kInputDecoration.copyWith(hintText: 'Enter OTP'),
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.pushNamed(context, '/complete profile');
            },
            style: TextButton.styleFrom(backgroundColor: Colors.white),
            child: const Text(
              'Verify OTP',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          )
        ]),
      ),
    );
  }
}
