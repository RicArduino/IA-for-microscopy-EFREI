import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class LastAnalysisScreen extends StatelessWidget {
  const LastAnalysisScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Dummy data for the list of analyses
    final List<Map<String, dynamic>> analyses = [
      {
        'title': 'Analyse 1',
        'date': '26/05/2024',
        'description':
            'Description de l\'analyse 1 : Sur le chantier de villejuif se trouve un chantier ou il faut construire un batiment. Le bio-ciment est nécéssaire pour les fondations.',
        'status': 'Go',
        'user': 'Dupont',
        'location': 'Villejuif'
      },
      {
        'title': 'Analyse 2',
        'date': '14/06/2024',
        'description':
            'Description de l\'analyse 2: Sur le chantier de paris se trouve un chantier ou il faut construire un batiment. Le bio-ciment est nécéssaire pour les fondations.',
        'status': 'No Go',
        'user': 'Wallace',
        'location': 'Paris'
      },
      // Add more analyses as needed
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Dernières Analyses'),
        backgroundColor: Colors.teal,
      ),
      body: ListView.builder(
        padding: EdgeInsets.all(16),
        itemCount: analyses.length,
        itemBuilder: (context, index) {
          return Center(
            child: AnalysisCard(
              title: analyses[index]['title'],
              date: analyses[index]['date'],
              description: analyses[index]['description'],
              status: analyses[index]['status'],
              user: analyses[index]['user'],
              location: analyses[index]['location'],
            ),
          );
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Accueil',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.analytics),
            label: 'Analyses',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Paramètres',
          ),
        ],
        currentIndex: 1, // Change this to set the current tab
        selectedItemColor: Colors.teal,
        onTap: (index) {
          if (index == 0) {
            Navigator.pushReplacementNamed(context, '/home');
          } else if (index == 1) {
            Navigator.pushReplacementNamed(context, '/last_analysis');
          } else if (index == 2) {
            Navigator.pushNamed(context, '/settings');
          }
        },
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
              // last analysis
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

class AnalysisCard extends StatelessWidget {
  final String title;
  final String date;
  final String description;
  final String status;
  final String user;
  final String location;

  const AnalysisCard({
    Key? key,
    required this.title,
    required this.date,
    required this.description,
    required this.status,
    required this.user,
    required this.location,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 10),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                      fontSize: 20, // Taille de police ajustée
                      fontWeight: FontWeight.bold,
                      color: Color(
                          0xFF2E2D2D) // Changement de couleur de la police
                      ),
                ),
                Text(
                  status,
                  style: TextStyle(
                      color: status == 'Go' ? Colors.green : Colors.red,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(height: 5),
            Text(
              date,
              style: TextStyle(
                color: Color(0xFF2E2D2D), // Changement de couleur de la police
              ),
            ),
            const SizedBox(height: 5),
            Row(
              children: [
                Chip(
                  label: Text(
                    user,
                    style: const TextStyle(
                        color: Color(
                            0xFF2E2D2D)), // Changement de couleur de la police
                  ),
                  backgroundColor: Color(0xFFE4EAFF),
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                ),
                const SizedBox(width: 10),
                Chip(
                  label: Text(
                    location,
                    style: const TextStyle(
                        color: Color(
                            0xFF2E2D2D)), // Changement de couleur de la police
                  ),
                  backgroundColor: Color(0xFFE4EAFF),
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                ),
              ],
            ),
            const SizedBox(height: 5),
            Text(
              description,
              style: TextStyle(
                color: Color(0xFF2E2D2D), // Changement de couleur de la police
              ),
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
