import 'package:flutter/material.dart';
import 'package:finance_forum/constants.dart';

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
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 10),
            child: TextField(
              cursorColor: Colors.red,
              style: const TextStyle(
                  color: Colors.white, fontWeight: FontWeight.bold),
              decoration: kInputDecoration.copyWith(hintText: 'Name'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 10),
            child: TextField(
              cursorColor: Colors.red,
              style: const TextStyle(
                  color: Colors.white, fontWeight: FontWeight.bold),
              decoration: kInputDecoration.copyWith(hintText: 'Username'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 10),
            child: TextField(
              keyboardType: TextInputType.datetime,
              cursorColor: Colors.red,
              style: const TextStyle(
                  color: Colors.white, fontWeight: FontWeight.bold),
              decoration: kInputDecoration.copyWith(hintText: 'DD-MM-YYYY'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 10),
            child: TextField(
              cursorColor: Colors.red,
              style: const TextStyle(
                  color: Colors.white, fontWeight: FontWeight.bold),
              decoration: kInputDecoration.copyWith(hintText: 'Gender'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 10),
            child: TextField(
              cursorColor: Colors.red,
              style: const TextStyle(
                  color: Colors.white, fontWeight: FontWeight.bold),
              decoration: kInputDecoration.copyWith(
                  hintText: 'SEBI reg. number (optional)'),
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.pushNamed(context, '/home');
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
