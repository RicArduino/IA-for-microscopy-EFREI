import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter/services.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key); // Ajout du paramètre key pour optimiser la gestion des widgets

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Accueil'),
        backgroundColor: Colors.teal,
      ),
      body: SingleChildScrollView( // Enveloppe le contenu avec SingleChildScrollView
        child: Column(
          children: <Widget>[
            Container(
              height: 300, // Fixe une hauteur pour le conteneur de l'image
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/home_image.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
              child: const Center(
                child: Text(
                  "",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    backgroundColor: Colors.black54,
                  ),
                ),
              ),
            ),
            Container(
              color: Colors.white,
              padding: const EdgeInsets.all(16),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "More Tech",
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),
                  Text(
                    "20 juin 2021",
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                  SizedBox(height: 8),
                  Wrap(
                    spacing: 8,
                    children: <Widget>[
                      Chip(label: Text('Software Engineering')),
                      Chip(label: Text('Biotechnology')),
                      Chip(label: Text('BI')),
                    ],
                  ),
                  SizedBox(height: 8),
                  Text(
                    "Bienvenue à BioCement AI Revolutionnez la construction durable avec la science de la biotechnologie. Notre application, BioCement AI, est a la pointe de l innovation en matière de construction écologique. Utilisant l'intelligence artificielle avancée, notre système est spécialement conçu pour détecter les bactéries Sporosarcina pasteurii à l'étape cruciale de biominéralisation. Ces bactéries jouent un rôle clé dans la production de bio-ciment, un matériau de construction durable qui pourrait radicalement transformer le secteur de la construction. Pourquoi est-ce important ? La biominéralisation des bactéries Sporosarcina pasteurii est essentielle pour produire un ciment écologique. Cependant, exploiter cette capacité requiert précision et timing : les bactéries doivent être identifiées au moment optimal de leur cycle de vie pour maximiser l'efficacité du processus de biominéralisation. C'est ici que notre IA intervient. Comment fonctionne notre application ? BioCement AI utilise des modèles d apprentissage profond pour analyser des échantillons de cultures bactériennes en temps réel, assurant que seule la phase optimale de biominéralisation est utilisée dans la production de bio-ciment. Cette précision non seulement améliore la qualité et la durabilité du ciment produit mais contribue également à une construction plus écologique et durable. Rejoignez-nous dans cette revolution verte Explorez notre site pour en savoir plus sur comment BioCement AI peut vous aider a adopter des pratiques de construction plus vertes et plus efficaces. Que vous soyez un professionnel de l industrie de la construction, un chercheur, ou simplement intéressé par la durabilité, BioCement AI a quelque chose à offrir. Ensemble, construisons un avenir plus durable.",
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Text('la bactérie pasteurie'), // 'const' cannot be used if text might change
                      Text('le Biociment '), // same as above
                    ],
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
                  Navigator.pop(context); // Pops the current route off the navigator.
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
                },
              ),
              ListTile(
                leading: const Icon(Icons.settings),
                title: const Text('Paramètres'),
                onTap: () {
                  Navigator.pop(context); // Close the menu
                  Navigator.pushNamed(context, '/settings'); // Navigate to Settings
                },
              ),
              // last analysis
              ListTile(
                leading: const Icon(Icons.analytics),
                title: const Text('Dernières Analyses'),
                onTap: () {
                  Navigator.pop(context);// Close the menu
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
