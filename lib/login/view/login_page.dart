import 'package:appwritetodo/helper/validators.dart';
import 'package:appwritetodo/signup/signup.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../../helper/auth_helper.dart';
import '../../home/view/home_page.dart';

class LoginPage extends StatelessWidget {
  LoginPage({Key? key}) : super(key: key);
  final formKey = GlobalKey<FormState>();
  SigninModel model = SigninModel();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Connexion')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: formKey,
          child: Column(
            children: [
              const Center(
                child: Text(
                  'Veuillez vous connecter pour commencer',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              TextFormField(
                decoration: const InputDecoration(
                  label: Text('Email'),
                  hintText: 'Entrer votre email',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if ((value == null) || (!value.isValidEmail())) {
                    return "L'email n'est pas correcte !";
                  }
                  return null;
                },
                onSaved: (newValue) {
                  model.email = newValue;
                },
              ),
              const SizedBox(
                height: 16,
              ),
              TextFormField(
                decoration: const InputDecoration(
                  label: Text('Mot de passe'),
                  hintText: 'Entrer votre mot de passe',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if ((value == null) || (!value.isGoodPassword())) {
                    return 'Le mot de passe est incorrecte !';
                  }
                  return null;
                },
                onSaved: (newValue) {
                  model.password = newValue;
                },
              ),
              const SizedBox(
                height: 16,
              ),
              ElevatedButton(
                onPressed: () async {
                  if (formKey.currentState!.validate()) {
                    formKey.currentState!.save();
                    try {
                      await AuthHelper()
                          .login(
                            email: model.email!,
                            password: model.password!,
                          )
                          .then(
                            (value) => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => HomePage(),
                              ),
                            ),
                          );
                    } catch (e) {
                      print(e);
                      ScaffoldMessenger.of(context)
                          .showSnackBar(SnackBar(content: Text(e.toString())));
                    }
                  }
                },
                child: const Text('Se connecter'),
              ),
              const SizedBox(
                height: 16,
              ),
              RichText(
                  text: TextSpan(
                text: 'Besoin de vous enregistrer ?',
                recognizer: TapGestureRecognizer()
                  ..onTap = () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SignupPage(),
                      ),
                    );
                  },
                style: const TextStyle(
                  fontSize: 12,
                  fontStyle: FontStyle.italic,
                  color: Colors.blue,
                  decoration: TextDecoration.underline,
                ),
              )),
            ],
          ),
        ),
      ),
    );
  }
}

class SigninModel {
  SigninModel({this.email, this.password});
  String? email;
  String? password;
}
