import 'package:finance_forum/constants.dart';
import 'package:finance_forum/controllers/profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});
  @override
  Widget build(BuildContext context) {
    return Consumer<ProfileController>(
        builder: (context, profileController, child) => SafeArea(
                child: Scaffold(
              resizeToAvoidBottomInset: false,
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
                  Row(children: [
                    Expanded(
                        child: tile(
                      Icons.person,
                      profileController.snapEmpty
                          ? ''
                          : profileController.snapshot!.get('name'),
                    )),
                    IconButton(
                        onPressed: () {
                          profileController.editProfile(
                              context, 'name', TextInputType.name);
                        },
                        icon: const Icon(
                          Icons.edit,
                          color: Colors.white,
                        ))
                  ]),
                  Row(children: [
                    Expanded(
                        child: tile(
                      Icons.verified_user,
                      profileController.snapEmpty
                          ? ''
                          : profileController.snapshot!.get('username'),
                    )),
                    IconButton(
                        onPressed: () {
                          profileController.editProfile(
                              context, 'username', TextInputType.name);
                        },
                        icon: const Icon(
                          Icons.edit,
                          color: Colors.white,
                        ))
                  ]),
                  Row(children: [
                    Expanded(
                        child: tile(
                      Icons.female,
                      profileController.snapEmpty
                          ? ''
                          : profileController.snapshot!.get('gender'),
                    )),
                    IconButton(
                        onPressed: () {
                          profileController.editProfile(
                              context, 'gender', TextInputType.name);
                        },
                        icon: const Icon(
                          Icons.edit,
                          color: Colors.white,
                        ))
                  ]),
                  Row(children: [
                    Expanded(
                        child: tile(
                      Icons.calendar_month,
                      profileController.snapEmpty
                          ? ''
                          : profileController.snapshot!.get('dob'),
                    )),
                    IconButton(
                        onPressed: () {
                          profileController.editProfile(
                              context, 'dob', TextInputType.number);
                        },
                        icon: const Icon(
                          Icons.edit,
                          color: Colors.white,
                        ))
                  ]),
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
                  Row(children: [
                    Expanded(
                        child: tile(
                      Icons.app_registration,
                      profileController.snapEmpty
                          ? ''
                          : profileController.snapshot!.get('sebi'),
                    )),
                    IconButton(
                        onPressed: () {
                          profileController.editProfile(
                              context, 'sebi', TextInputType.name);
                        },
                        icon: const Icon(
                          Icons.edit,
                          color: Colors.white,
                        ))
                  ]),
                  const SizedBox(height: 20),
                  const Text(
                    'Your mobile number and birth date is not visible to others',
                    style: TextStyle(color: Colors.white),
                  ),
                  const Text(
                    'Your data is safe. will not be used for any other purpose',
                    style: TextStyle(color: Colors.white),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            )));
  }
}
