import 'package:appwrite/appwrite.dart';
import 'package:appwritetodo/helper/storage_helper.dart';
import 'package:appwritetodo/l10n/l10n.dart';
import 'package:appwritetodo/splash/view/splash_page.dart';
import 'package:flutter/material.dart';

Client client = Client();
StorageHelper storage = StorageHelper();

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  void initState() {
    client
        .setEndpoint('http://localhost/v1')
        .setProject('6416f746cce0328672e5')
        .setSelfSigned();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        appBarTheme: const AppBarTheme(color: Color(0xFF13B9FF)),
        colorScheme: ColorScheme.fromSwatch(
          accentColor: const Color(0xFF13B9FF),
        ),
      ),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: const Splashscreen(),
    );
  }
}
