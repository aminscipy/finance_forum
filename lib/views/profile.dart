import 'package:finance_forum/constants.dart';
import 'package:finance_forum/controllers/profile_controller.dart';
import 'package:finance_forum/views/complete_profile.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});
  @override
  Widget build(BuildContext context) {
    Provider.of<ProfileController>(context).getData();
    return Consumer<ProfileController>(
        builder: (context, profileController, child) => SafeArea(
                child: Scaffold(
              backgroundColor: Colors.blueAccent,
              body: Column(
                children: [
                  const SizedBox(height: 40),
                  GestureDetector(
                      behavior: HitTestBehavior.translucent,
                      onTap: (() {
                        profileController.profilePic();
                      }),
                      child: CircleAvatar(
                        backgroundImage: const AssetImage('images/default.jpg'),
                        foregroundImage: profileController.snapEmpty
                            ? null
                            : NetworkImage(
                                profileController.snapshot!.get('profilePic')),
                        radius: 60,
                      )),
                  const SizedBox(
                    height: 30,
                  ),
                  tile(
                    Icons.person,
                    profileController.snapEmpty
                        ? ''
                        : profileController.snapshot!.get('name'),
                  ),
                  tile(
                    Icons.verified_user,
                    profileController.snapEmpty
                        ? ''
                        : profileController.snapshot!.get('username'),
                  ),
                  tile(
                    Icons.female,
                    profileController.snapEmpty
                        ? ''
                        : profileController.snapshot!.get('gender'),
                  ),
                  tile(
                    Icons.calendar_month,
                    profileController.snapEmpty
                        ? ''
                        : profileController.snapshot!.get('dob'),
                  ),
                  tile(
                    Icons.people,
                    profileController.snapEmpty
                        ? ''
                        : profileController.snapshot!
                            .get('followers')
                            .length
                            .toString(),
                  ),
                  tile(
                    Icons.check,
                    profileController.snapEmpty
                        ? ''
                        : profileController.snapshot!
                            .get('following')
                            .length
                            .toString(),
                  ),
                  tile(
                    Icons.phone,
                    profileController.snapEmpty
                        ? ''
                        : profileController.snapshot!.get('phoneNumber'),
                  ),
                  tile(
                    Icons.app_registration,
                    profileController.snapEmpty
                        ? ''
                        : profileController.snapshot!.get('sebi'),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Your mobile number and birth date is not visible to others',
                    style: TextStyle(color: Colors.white),
                  ),
                  GestureDetector(
                    onTap: () {
                      Get.to(() => const CompleteProfile());
                    },
                    child: const Text(
                      'Want to edit your profile details? click here',
                      style: TextStyle(color: Colors.white),
                      textAlign: TextAlign.left,
                    ),
                  )
                ],
              ),
            )));
  }
}
