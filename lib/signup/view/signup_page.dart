import 'package:appwritetodo/helper/auth_helper.dart';
import 'package:appwritetodo/helper/validators.dart';
import 'package:appwritetodo/home/view/home_page.dart';
import 'package:appwritetodo/login/view/login_page.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class SignupPage extends StatelessWidget {
  SignupPage({Key? key}) : super(key: key);
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _pass = TextEditingController();
  final TextEditingController _confirmPass = TextEditingController();
  SignupModel model = SignupModel();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("S'enregistrer")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              const Center(
                child: Text(
                  'Veuillez remplir ces informations pour vous inscrire',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              TextFormField(
                decoration: const InputDecoration(
                  label: Text('Nom'),
                  hintText: 'Entrer votre nom (publique)',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if ((value == null) || (!value.isValidName())) {
                    return "Votre nom n'est pas correcte !";
                  }
                  return null;
                },
                onSaved: (newValue) {
                  model.name = newValue;
                },
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
                controller: _pass,
                decoration: const InputDecoration(
                  label: Text('Mot de passe'),
                  hintText: 'Entrer votre mot de passe',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if ((value == null) || (!value.isGoodPassword())) {
                    return 'Le mot de passe nécessite au minimum 8 caractères avec au moins : \n - une majuscule\n - une minuscule\n - un caractère spécial\n - un chiffre.';
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
              TextFormField(
                controller: _confirmPass,
                decoration: const InputDecoration(
                  label: Text('Confirmation du mot de passe'),
                  hintText: 'Entrer à nouveau votre mot de passe',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if ((value == null) || (_pass.value.text != value)) {
                    return 'Les mots de passe doivent être identiques ';
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 16,
              ),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    try {
                      await AuthHelper()
                          .createUserAccount(
                            email: model.email!,
                            password: model.password!,
                            name: model.name!,
                          )
                          .then((value) => Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => HomePage())));
                    } catch (e) {
                      print(e);
                      ScaffoldMessenger.of(context)
                          .showSnackBar(SnackBar(content: Text(e.toString())));
                    }
                  }
                },
                child: const Text("S'enregistrer"),
              ),
              const SizedBox(
                height: 16,
              ),
              RichText(
                  text: TextSpan(
                text: "Vous avez déjà un compte ? C'est par ici !",
                recognizer: TapGestureRecognizer()
                  ..onTap = () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => LoginPage(),
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

class SignupModel {
  SignupModel({this.email, this.password, this.name});
  String? email;
  String? password;
  String? name;
}
