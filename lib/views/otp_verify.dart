import 'package:finance_forum/controllers/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OtpVerify extends StatelessWidget {
  const OtpVerify({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthController>(
      builder: (context, authController, child) => Scaffold(
        backgroundColor: Colors.blueGrey,
        body: Center(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            const Text('\$ Finance Forum',
                style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.white)),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 80, vertical: 10),
              child: TextField(
                keyboardType: TextInputType.number,
                onChanged: ((value) {
                  authController.otp = value;
                }),
                cursorColor: Colors.red,
                style: const TextStyle(
                    color: Colors.white, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
                decoration: const InputDecoration(hintText: 'Enter OTP'),
                // kInputDecoration.copyWith(hintText: 'Enter OTP'),
              ),
            ),
            TextButton(
              onPressed: () {
                authController.verifyOtp();
              },
              style: TextButton.styleFrom(backgroundColor: Colors.white),
              child: const Text(
                'Verify OTP',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            )
          ]),
        ),
      ),
    );
  }
}
