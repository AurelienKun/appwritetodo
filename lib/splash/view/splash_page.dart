import 'package:appwritetodo/app/view/app.dart';
import 'package:appwritetodo/home/home.dart';
import 'package:appwritetodo/login/view/login_page.dart';
import 'package:flutter/material.dart';

class Splashscreen extends StatefulWidget {
  const Splashscreen({super.key});

  @override
  State<Splashscreen> createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen> {
  @override
  void initState() {
    getSessionDetail();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: Text('Bienvenue !\nChargement en cours...')),
    );
  }

  Future<void> getSessionDetail() async {
    await storage.init();
    final id = storage.getSession();

    if (!mounted) return;
    if (id.isEmpty) {
      await Navigator.push(
        context,
        MaterialPageRoute<void>(
          builder: (context) => LoginPage(),
        ),
      );
    } else {
      await Navigator.push(
        context,
        MaterialPageRoute<void>(
          builder: (context) => HomePage(),
        ),
      );
    }
  }
}
