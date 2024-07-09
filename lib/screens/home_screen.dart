import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Accueil'),
        backgroundColor: Colors.teal,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              height: 300,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/test.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
              child: const Center(),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Card(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    elevation: 5,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            "Quelques informations",
                            style: TextStyle(
                                fontSize: 24, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 8),
                          Text(
                            "IA for Microscopy - EFREI",
                            style: TextStyle(fontSize: 16, color: Colors.grey),
                          ),
                          SizedBox(height: 8),
                          Wrap(
                            spacing: 8,
                            children: <Widget>[
                              Chip(
                                label: Text('Software Engineering'),
                                backgroundColor: Color(0xFFE4EAFF),
                                labelStyle: TextStyle(color: Color(0xFF0D38CE)),
                              ),
                              Chip(
                                label: Text('Biotechnology'),
                                backgroundColor: Color(0xFFE4EAFF),
                                labelStyle: TextStyle(color: Color(0xFF0D38CE)),
                              ),
                              Chip(
                                label: Text('BI'),
                                backgroundColor: Color(0xFFE4EAFF),
                                labelStyle: TextStyle(color: Color(0xFF0D38CE)),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Card(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    elevation: 5,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                        "Bienvenue à BioCement AI. Notre application, BioCement AI, utilise l'intelligence artificielle pour détecter les bactéries Sporosarcina pasteurii à l'étape cruciale de biominéralisation. Ces bactéries jouent un rôle clé dans la production de bio-ciment, cependant, exploiter cette capacité requiert précision et timing : les bactéries doivent être identifiées au moment optimal de leur cycle de vie pour maximiser. C'est ici que notre app intervient. Il suffit de choisir une photo dans sa gallerie ou d'en prendre une et l'app s'occupera d'analyser l'image et de donner son Go !",
                        style:
                            TextStyle(fontSize: 16, color: Color(0xFF2E2D2D)),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
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
                  Navigator.pop(context); // Close the menu
                  Navigator.pushReplacementNamed(context, '/home');
                },
              ),
              ListTile(
                leading: const Icon(Icons.settings),
                title: const Text('Paramètres'),
                onTap: () {
                  Navigator.pop(context); // Close the menu
                  Navigator.pushNamed(context, '/settings');
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
