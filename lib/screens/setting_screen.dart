import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '/theme_provider.dart';
import '/locale_provider.dart';
import 'package:flutter/services.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final localeProvider = Provider.of<LocaleProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Paramètres'),
        backgroundColor: Colors.teal,
      ),
      body: ListView(
        children: [
          SwitchListTile(
            title: const Text('Mode sombre'),
            value: themeProvider.themeData.brightness == Brightness.dark,
            onChanged: (value) {
              themeProvider
                  .setTheme(value ? ThemeData.dark() : ThemeData.light());
            },
          ),
          ListTile(
            title: const Text('Changer de langue'),
            subtitle:
                Text('Langue actuelle: ${localeProvider.locale.languageCode}'),
            onTap: () {
              localeProvider.setLocale(
                  localeProvider.locale.languageCode == 'en'
                      ? const Locale('fr')
                      : const Locale('en'));
            },
          ),
          const SizedBox(height: 20),
          const Center(
            child: Text(
              'Version : 1.1.0',
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            IconButton(
              icon: const Icon(Icons.menu),
              onPressed: () => _showMenu(context),
            ),
            IconButton(
              icon: const Icon(Icons.camera_alt),
              onPressed: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, '/scan');
              },
            ),
            IconButton(
              icon: const Icon(Icons.arrow_back_sharp),
              onPressed: () {
                if (Navigator.canPop(context)) {
                  Navigator.pop(
                      context); // Pops the current route off the navigator.
                } else {
                  // Optionnel: Gérer le cas où il n'y a pas de page précédente (peut-être afficher un message ou fermer l'application)
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("No previous page!"),
                      duration: Duration(seconds: 2),
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  void _showMenu(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                leading: const Icon(Icons.home),
                title: const Text('Accueil'),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.pushReplacementNamed(context, '/home');
                },
              ),
              ListTile(
                leading: const Icon(Icons.settings),
                title: const Text('Paramètres'),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: const Icon(Icons.analytics),
                title: const Text('Dernières Analyses'),
                onTap: () {
                  Navigator.pop(context); // Close the menu
                  Navigator.pushNamed(context, '/last_analysis');
                },
              ),
              ListTile(
                leading: const Icon(Icons.document_scanner),
                title: const Text('Scanner'),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.pushNamed(context, '/scan');
                },
              ),
              ListTile(
                leading: const Icon(Icons.exit_to_app),
                title: const Text('Quitter'),
                onTap: () {
                  if (Navigator.canPop(context)) {
                    Navigator.pop(context); // Pour fermer le menu modal
                  }
                  SystemNavigator.pop(); // Ferme l'application
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
