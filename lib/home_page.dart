import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'controller.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text(
            'Finance Forum',
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
                        Provider.of<Controller>(context, listen: false).theme();
                      }),
                  PopupMenuItem(child: const Text('Log Out'), onTap: () {}),
                ];
              },
            ),
          ]),
    );
  }
}
