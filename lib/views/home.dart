import 'package:finance_forum/controllers/add_stock_controller.dart';
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
    return Consumer2<AuthController, AddStockController>(
      builder: (context, authController, addStockController, child) => Scaffold(
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
                    onPressed: () {
                      addStockController.addStock();
                    },
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
          body: SizedBox(
            height: 32,
            child: ListView.separated(
                separatorBuilder: (context, index) {
                  return const SizedBox(width: 3);
                },
                padding: const EdgeInsets.all(4),
                scrollDirection: Axis.horizontal,
                itemCount: addStockController.stockList.length,
                itemBuilder: ((context, index) {
                  return GestureDetector(
                    onTap: () {
                      addStockController.removeStock(index);
                    },
                    child: Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          color: Colors.black12),
                      padding: const EdgeInsets.all(4),
                      child: Text(
                        addStockController.stockList[index],
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  );
                })),
          )),
    );
  }
}
