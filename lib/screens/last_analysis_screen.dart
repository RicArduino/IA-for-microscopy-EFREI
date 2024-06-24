import 'package:flutter/material.dart';

class LastAnalysisScreen extends StatelessWidget {
  const LastAnalysisScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Dummy data for the list of analyses
    final List<Map<String, dynamic>> analyses = [
      {
        'title': 'Analyse 1',
        'date': 'xx/xx/XXXX',
        'description': 'Description de l\'analyse 1...',
        'status': 'Go'
      },
      {
        'title': 'Analyse 2',
        'date': 'xx/xx/XXXX',
        'description': 'Description de l\'analyse 2...',
        'status': 'No Go'
      },
      // Add more analyses as needed
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Dernières Analyses'),
        backgroundColor: Colors.teal,
      ),
      body: ListView.builder(
        itemCount: analyses.length,
        itemBuilder: (context, index) {
          return AnalysisCard(
            title: analyses[index]['title'],
            date: analyses[index]['date'],
            description: analyses[index]['description'],
            status: analyses[index]['status'],
          );
        },
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
              onPressed: () {},
            ),
            IconButton(
              icon: const Icon(Icons.arrow_forward),
              onPressed: () {},
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
                leading: const Icon(Icons.exit_to_app),
                title: const Text('Quitter'),
                onTap: () {
                  Navigator.pop(context); // Close the menu
                  Navigator.pop(context); // Exit the app
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

  const AnalysisCard({
    Key? key,
    required this.title,
    required this.date,
    required this.description,
    required this.status,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(10),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              title,
              style: const TextStyle(
                  fontSize: 20, // Taille de police ajustée
                  fontWeight: FontWeight.bold,
                  color: Colors.black // Définissez la couleur selon vos besoins
              ),
            ),
            const SizedBox(height: 5),
            Text(date),
            const SizedBox(height: 5),
            Text(description),
            const SizedBox(height: 10),
            Text(
              status,
              style: TextStyle(
                  color: status == 'Go' ? Colors.green : Colors.red,
                  fontWeight: FontWeight.bold
              ),
            ),
          ],
        ),
      ),
    );
  }
}

