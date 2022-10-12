import 'package:finance_forum/controllers/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:finance_forum/constants.dart';
import 'package:provider/provider.dart';

class CompleteProfile extends StatelessWidget {
  const CompleteProfile({super.key});

  @override
  Widget build(BuildContext context) {
    String name = '';
    String username = '';
    String dob = '';
    String gender = '';
    String sebi = '';
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
          TextInputField(
            hint: 'Name',
            textInputType: TextInputType.name,
            onChanged: (value) {
              name = value;
            },
          ),
          TextInputField(
            hint: 'Username',
            textInputType: TextInputType.name,
            onChanged: (value) {
              username = value;
            },
          ),
          TextInputField(
            hint: 'DD-MM-YYYY',
            textInputType: TextInputType.datetime,
            onChanged: (value) {
              dob = value;
            },
          ),
          TextInputField(
            hint: 'Gender',
            textInputType: TextInputType.name,
            onChanged: (value) {
              gender = value;
            },
          ),
          TextInputField(
            hint: 'SEBI reg. no. (optional)',
            textInputType: TextInputType.name,
            onChanged: (value) {
              sebi = value;
            },
          ),
          TextButton(
            onPressed: () {
              Provider.of<AuthController>(context, listen: false)
                  .completProfile(
                      name: name,
                      username: username,
                      dob: dob,
                      gender: gender,
                      sebi: sebi);
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
