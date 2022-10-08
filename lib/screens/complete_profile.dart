import 'package:finance_forum/screens/home.dart';
import 'package:flutter/material.dart';
import 'package:finance_forum/constants.dart';
import 'package:get/get.dart';

class CompleteProfile extends StatelessWidget {
  const CompleteProfile({super.key});

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
          const TextInputField(
            hint: 'Name',
            textInputType: TextInputType.name,
          ),
          const TextInputField(
              hint: 'Username', textInputType: TextInputType.name),
          const TextInputField(
              hint: 'DD-MM-YYYY', textInputType: TextInputType.datetime),
          const TextInputField(
              hint: 'Gender', textInputType: TextInputType.name),
          const TextInputField(
              hint: 'SEBI reg. no. (optional)',
              textInputType: TextInputType.name),
          TextButton(
            onPressed: () {
              Get.to(() => const Home());
            },
            style: TextButton.styleFrom(backgroundColor: Colors.white),
            child: const Text(
              'submit',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          )
        ]),
      ),
    );
  }
}
