import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_task/Screens/LoginScreen.dart';
import 'package:flutter_task/riverpods/authRiverpods.dart';

class Profile extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userData = ref.watch(authProvider).userData;

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Profile'),
          actions: [
            IconButton(
                onPressed: () async {
                  await ref.read(authProvider).logout();
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (BuildContext context) => Login()));
                },
                icon: Icon(Icons.logout)),
          ],
        ),
        body: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Name: ${userData['name']}'),
            Text('Email: ${userData['email']}'),
          ],
        )),
      ),
    );
  }
}
