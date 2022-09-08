import 'package:flutter/material.dart';

import '../auth/auth_page.dart';

class LoadingPage extends StatefulWidget {
  const LoadingPage({Key? key}) : super(key: key);

  @override
  State<LoadingPage> createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage>
    with TickerProviderStateMixin {
  late AnimationController controller;

  @override
  void initState() {
    controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )..addListener(() {
        setState(() {});
      });
    controller.forward().then((value) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const AuthPage()),
      );
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const SizedBox(),
          const Text('LOGO',
              style: TextStyle(fontSize: 60, fontWeight: FontWeight.w400)),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 48),
            child: LinearProgressIndicator(
              minHeight: 9,
              value: controller.value,
            ),
          ),
        ],
      ),
    );
  }
}
