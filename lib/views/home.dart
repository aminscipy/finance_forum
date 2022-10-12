import 'package:finance_forum/views/create_post.dart';
import 'package:finance_forum/views/profile.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:finance_forum/controllers/auth_controller.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthController>(
      builder: (context, authController, child) => Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            showModalBottomSheet(
                isScrollControlled: true,
                backgroundColor: Colors.transparent,
                context: context,
                builder: (context) {
                  return SingleChildScrollView(
                    padding: EdgeInsets.only(
                        bottom: MediaQuery.of(context).viewInsets.bottom),
                    child: const CreatePost(),
                  );
                });
          },
          child: const Icon(Icons.add),
        ),
        appBar: AppBar(
            title: const Text(
              '\$ Finance Forum',
            ),
            actions: [
              IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.add,
                    size: 25,
                  )),
              PopupMenuButton(
                itemBuilder: (context) {
                  return [
                    PopupMenuItem(
                        child: const Text('Switch theme'),
                        onTap: () {
                          authController.changeTheme();
                        }),
                    PopupMenuItem(
                        child: const Text('Profile'),
                        onTap: () async {
                          await Future.delayed(Duration.zero);
                          Get.to(() => const Profile());
                        }),
                    PopupMenuItem(
                        child: const Text('Log Out'),
                        onTap: () {
                          authController.logOut();
                        })
                  ];
                },
              )
            ]),
      ),
    );
  }
}
