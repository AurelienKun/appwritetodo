import 'package:appwritetodo/helper/auth_helper.dart';
import 'package:appwritetodo/login/view/login_page.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Accueil'),
        actions: [
          ElevatedButton(
            child: const Text('Se déconnecter'),
            onPressed: () async {
              final auth = AuthHelper();
              var logout = false;
              var message = "Une erreur inconnue s'est produite !";
              try {
                if (await auth.logout()) {
                  message = 'Vous êtes maintenant déconnecté !';
                  logout = true;
                }
              } catch (e) {
                message = e.toString();
              }
              if (!mounted) return;
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text(message)));
              if (logout) {
                await Navigator.push(
                  context,
                  MaterialPageRoute<void>(builder: (context) => LoginPage()),
                );
              }
            },
          ),
        ],
      ),
      body: const Center(
        child: Text('Home sweet home'),
      ),
    );
  }
}
