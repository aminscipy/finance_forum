import 'package:finance_forum/controllers/add_stock_controller.dart';
import 'package:finance_forum/controllers/profile_controller.dart';
import 'package:finance_forum/views/create_post.dart';
import 'package:finance_forum/views/profile.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';
import 'package:finance_forum/controllers/auth_controller.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    Provider.of<ProfileController>(context).getData();
    return Consumer3<AuthController, AddStockController, ProfileController>(
      builder: (context, authController, addStockController, profileController,
              child) =>
          Scaffold(
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
              body: Column(
                children: [
                  SizedBox(
                    height: 32,
                    child: ListView.separated(
                        separatorBuilder: (context, index) {
                          return const SizedBox(width: 3);
                        },
                        padding:
                            const EdgeInsets.only(left: 4, right: 4, top: 4),
                        scrollDirection: Axis.horizontal,
                        itemCount: addStockController.stockList.length,
                        itemBuilder: ((context, index) {
                          return GestureDetector(
                            onLongPress: () {
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
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          );
                        })),
                  ),
                  Expanded(
                    child: ListView.separated(
                        separatorBuilder: (context, index) {
                          return const SizedBox(height: 3);
                        },
                        padding: const EdgeInsets.all(4),
                        scrollDirection: Axis.vertical,
                        itemCount: addStockController.stockList.length,
                        itemBuilder: ((context, index) {
                          return Container(
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(4),
                                  color: Colors.black12),
                              padding: const EdgeInsets.all(4),
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      GestureDetector(
                                          behavior: HitTestBehavior.translucent,
                                          onTap: (() {
                                            //should go to the profile of post owner
                                          }),
                                          child: CircleAvatar(
                                            backgroundImage: const AssetImage(
                                                'images/default.jpg'),
                                            foregroundImage: profileController
                                                    .snapEmpty
                                                ? null
                                                : NetworkImage(profileController
                                                    .snapshot!
                                                    .get('profilePic')),
                                            radius: 20,
                                          )),
                                      const SizedBox(width: 10),
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            profileController.snapEmpty
                                                ? ''
                                                : profileController.snapshot!
                                                    .get('name'),
                                            style: const TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Text(
                                            profileController.snapEmpty
                                                ? ''
                                                : '@${profileController.snapshot!.get('username')}',
                                            style: const TextStyle(
                                                fontSize: 13,
                                                fontWeight: FontWeight.bold),
                                          )
                                        ],
                                      ),
                                      const SizedBox(width: 20),
                                      GestureDetector(
                                          onTap: () {
                                            //should change to following when clicked },
                                          },
                                          child: const Icon(Icons.person_add)),
                                      const SizedBox(width: 40),
                                      const Text('10/10/22, 12:15',
                                          style: TextStyle(
                                              fontSize: 13,
                                              fontWeight: FontWeight.bold))
                                    ],
                                  ),
                                  const SizedBox(height: 20),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: const [
                                      Text(
                                        'tata motors',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w500),
                                      ),
                                      Text('396.40',
                                          style: TextStyle(
                                              fontWeight: FontWeight.w500))
                                    ],
                                  ),
                                  const SizedBox(height: 20),
                                  const Text(
                                      'TATA motors will go up when result are posted, i think results are on tuesday and till then we need to wait if results are good then go long or if results are bad then go short',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500)),
                                  const SizedBox(height: 3),
                                  const Divider(),
                                  SizedBox(
                                    height: 40,
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Column(
                                          children: [
                                            GestureDetector(
                                              onTap: () {},
                                              child: const Text('1M',
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w500)),
                                            ),
                                            GestureDetector(
                                              onTap: () {},
                                              child: const Icon(Iconsax.heart5),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(width: 10),
                                        Column(
                                          children: [
                                            GestureDetector(
                                              onTap: () {},
                                              child: const Text('20k',
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w500)),
                                            ),
                                            GestureDetector(
                                              onTap: () {},
                                              child: const Icon(
                                                  Icons.heart_broken),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(width: 10),
                                        Column(
                                          children: [
                                            GestureDetector(
                                              onTap: () {},
                                              child: const Text('50k',
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w500)),
                                            ),
                                            GestureDetector(
                                              onTap: () {},
                                              child:
                                                  const Icon(Iconsax.message1),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(width: 10),
                                        Column(
                                          children: [
                                            GestureDetector(
                                              onTap: () {},
                                              child: const Text('10k',
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w500)),
                                            ),
                                            GestureDetector(
                                              onTap: () {},
                                              child: const Icon(Iconsax.share5),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(width: 10),
                                      ],
                                    ),
                                  ),
                                ],
                              ));
                        })),
                  )
                ],
              )),
    );
  }
}
