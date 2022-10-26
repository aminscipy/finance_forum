import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finance_forum/controllers/add_stock_controller.dart';
import 'package:finance_forum/controllers/post_controller.dart';
import 'package:finance_forum/controllers/profile_controller.dart';
import 'package:finance_forum/views/create_post.dart';
import 'package:finance_forum/views/profile.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
    String? phoneNumber = FirebaseAuth.instance.currentUser!.phoneNumber;
    return Consumer4<AuthController, AddStockController, ProfileController,
        PostController>(
      builder: (context, authController, addStockController, profileController,
              postController, child) =>
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
                    // IconButton(
                    //     onPressed: () {
                    //       addStockController.addStock();
                    //     },
                    //     icon: const Icon(
                    //       Icons.add,
                    //       size: 25,
                    //     )),
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
                  // SizedBox(
                  //   height: 32,
                  //   child: ListView.separated(
                  //       separatorBuilder: (context, index) {
                  //         return const SizedBox(width: 3);
                  //       },
                  //       padding:
                  //           const EdgeInsets.only(left: 4, right: 4, top: 4),
                  //       scrollDirection: Axis.horizontal,
                  //       itemCount: addStockController.stockList.length,
                  //       itemBuilder: ((context, index) {
                  //         return GestureDetector(
                  //           onLongPress: () {
                  //             addStockController.removeStock(index);
                  //           },
                  //           child: Container(
                  //             decoration: BoxDecoration(
                  //                 borderRadius: BorderRadius.circular(4),
                  //                 color: Colors.black12),
                  //             padding: const EdgeInsets.all(4),
                  //             child: Text(
                  //               addStockController.stockList[index],
                  //               style: const TextStyle(
                  //                   fontWeight: FontWeight.bold),
                  //             ),
                  //           ),
                  //         );
                  //       })),
                  // ),
                  StreamBuilder<QuerySnapshot>(
                      stream: FirebaseFirestore.instance
                          .collection('posts')
                          .snapshots(),
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) {
                          return const CircularProgressIndicator(
                            backgroundColor: Colors.blue,
                          );
                        }
                        final posts = snapshot.data!.docs;
                        return Expanded(
                          child: ListView.separated(
                              separatorBuilder: (context, index) {
                                return const SizedBox(height: 3);
                              },
                              padding: const EdgeInsets.all(4),
                              scrollDirection: Axis.vertical,
                              itemCount: snapshot.data!.docs.length,
                              itemBuilder: ((context, index) {
                                return Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(4),
                                        color: Colors.black12),
                                    padding: const EdgeInsets.all(4),
                                    child: Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(children: [
                                              GestureDetector(
                                                  behavior: HitTestBehavior
                                                      .translucent,
                                                  onTap: (() {
                                                    //should g
                                                    //o to the profile of post owner
                                                  }),
                                                  child: CircleAvatar(
                                                    backgroundImage:
                                                        const AssetImage(
                                                            'images/default.jpg'),
                                                    foregroundImage:
                                                        NetworkImage(
                                                            posts[index].get(
                                                                'profile pic')),
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
                                                    posts[index].get('name'),
                                                    style: const TextStyle(
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                  Text(
                                                    '@${posts[index].get('username')}',
                                                    style: const TextStyle(
                                                        fontSize: 13,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  )
                                                ],
                                              )
                                            ]),
                                            const SizedBox(width: 20),
                                            Row(
                                              children: [
                                                Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment.end,
                                                    children: [
                                                      GestureDetector(
                                                          onTap: () {
                                                            postController
                                                                .following(posts[
                                                                        index]
                                                                    .get(
                                                                        'owner'));
                                                            postController
                                                                .followers(posts[
                                                                        index]
                                                                    .get(
                                                                        'owner'));
                                                          },
                                                          child: phoneNumber ==
                                                                  posts[index]
                                                                      .get(
                                                                          'owner')
                                                              ? const SizedBox(
                                                                  height: 20,
                                                                )
                                                              : (profileController
                                                                      .snapEmpty
                                                                  ? const Icon(Icons
                                                                      .person_add_alt_1)
                                                                  : profileController
                                                                          .snapshot!
                                                                          .get(
                                                                              'following')
                                                                          .contains(posts[index].get(
                                                                              'owner'))
                                                                      ? const Icon(
                                                                          Icons
                                                                              .check,
                                                                          color:
                                                                              Colors.blue,
                                                                        )
                                                                      : const Icon(
                                                                          Icons
                                                                              .person_add_alt_1))),
                                                      Text(
                                                          posts[index]
                                                              .get('timestamp')
                                                              .toString(),
                                                          style: const TextStyle(
                                                              fontSize: 11,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold)),
                                                    ]),
                                              ],
                                            )
                                          ],
                                        ),
                                        const Divider(
                                          thickness: 1,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              posts[index]
                                                  .get('symbol')
                                                  .toString(),
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.w500),
                                            ),
                                            // Text(
                                            //     posts[index]
                                            //         .get('price when posted')
                                            //         .toString(),
                                            //     style: const TextStyle(
                                            //         fontWeight:
                                            //             FontWeight.w500))
                                          ],
                                        ),
                                        const SizedBox(height: 10),
                                        Row(
                                          children: [
                                            Expanded(
                                              child: Text(
                                                posts[index]
                                                    .get('opinion')
                                                    .toString(),
                                                style: const TextStyle(
                                                    fontWeight:
                                                        FontWeight.w500),
                                                textAlign: TextAlign.start,
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 4),
                                        SizedBox(
                                          height:
                                              posts[index].get ('postPic') == ""
                                                  ? 0
                                                  : 200,
                                          width: double.infinity,
                                          child:
                                              posts[index].get('postPic') == ""
                                                  ? null
                                                  : Image(
                                                      image: NetworkImage(
                                                          posts[index]
                                                              .get('postPic')),
                                                      fit: BoxFit.cover,
                                                    ),
                                        ),
                                        const Divider(
                                          thickness: 1,
                                        ),
                                        SizedBox(
                                          height: 40,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            children: [
                                              Column(
                                                children: [
                                                  GestureDetector(
                                                    onTap: () {},
                                                    child: Text(
                                                        posts[index]
                                                            .get('likes')
                                                            .length
                                                            .toString(),
                                                        style: const TextStyle(
                                                            fontWeight:
                                                                FontWeight
                                                                    .w500)),
                                                  ),
                                                  GestureDetector(
                                                    onTap: () {
                                                      postController.liked(
                                                          posts[index].id);
                                                    },
                                                    child: Icon(
                                                      Iconsax.heart5,
                                                      color: posts[index]
                                                              .get('likes')
                                                              .contains(
                                                                  phoneNumber)
                                                          ? Colors.red
                                                          : null,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Column(
                                                children: [
                                                  GestureDetector(
                                                    onTap: () {},
                                                    child: Text(
                                                        posts[index]
                                                            .get('dislikes')
                                                            .length
                                                            .toString(),
                                                        style: const TextStyle(
                                                            fontWeight:
                                                                FontWeight
                                                                    .w500)),
                                                  ),
                                                  GestureDetector(
                                                    onTap: () {
                                                      postController.disliked(
                                                          posts[index].id);
                                                    },
                                                    child: Icon(
                                                        Icons.heart_broken,
                                                        color: posts[index]
                                                                .get('dislikes')
                                                                .contains(
                                                                    phoneNumber)
                                                            ? Colors.red
                                                            : null),
                                                  ),
                                                ],
                                              ),
                                              Column(
                                                children: [
                                                  GestureDetector(
                                                    onTap: () {},
                                                    child: Text(
                                                        posts[index]
                                                            .get('comments')
                                                            .length
                                                            .toString(),
                                                        style: const TextStyle(
                                                            fontWeight:
                                                                FontWeight
                                                                    .w500)),
                                                  ),
                                                  GestureDetector(
                                                    onTap: () {},
                                                    child: const Icon(
                                                        Iconsax.message1),
                                                  ),
                                                ],
                                              ),
                                              Column(
                                                children: [
                                                  GestureDetector(
                                                    onTap: () {},
                                                    child: Text(
                                                        posts[index]
                                                            .get('share')
                                                            .length
                                                            .toString(),
                                                        style: const TextStyle(
                                                            fontWeight:
                                                                FontWeight
                                                                    .w500)),
                                                  ),
                                                  GestureDetector(
                                                    onTap: () {},
                                                    child: const Icon(
                                                        Iconsax.share5),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ));
                              })),
                        );
                      })
                ],
              )),
    );
  }
}
