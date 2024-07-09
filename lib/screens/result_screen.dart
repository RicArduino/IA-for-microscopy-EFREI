import 'package:flutter/material.dart';

class ResultScreen extends StatelessWidget {
  const ResultScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Résultats'),
        backgroundColor: Colors.teal,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: <Widget>[
              _buildResultCard(
                context,
                resultTitle: 'Résultat 1',
                analysisDate: 'xx/xx/XXXX',
                status: 'Composant prêt !',
                statusColor: Colors.green,
                description:
                    'Lorem ipsum dolor sit amet, consectetur adipiscing elit...',
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: _buildBottomNavigationBar(context),
    );
  }

  Widget _buildResultCard(
    BuildContext context, {
    required String resultTitle,
    required String analysisDate,
    required String status,
    required Color statusColor,
    required String description,
  }) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 10.0),
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(resultTitle,
                style: Theme.of(context).textTheme.headlineMedium),
            const SizedBox(height: 10),
            Text('Analyse', style: TextStyle(fontWeight: FontWeight.bold)),
            Text(analysisDate),
            const SizedBox(height: 10),
            Row(
              children: <Widget>[
                _buildTag('utilisateur'),
                const SizedBox(width: 10),
                _buildTag('lieu'),
              ],
            ),
            const SizedBox(height: 10),
            Text(description),
            const SizedBox(height: 10),
            Text(status, style: TextStyle(color: statusColor)),
          ],
        ),
      ),
    );
  }

  Widget _buildTag(String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: Colors.blue[100],
        borderRadius: BorderRadius.circular(5),
      ),
      child: Text(label),
    );
  }

  Widget _buildBottomNavigationBar(BuildContext context) {
    return BottomAppBar(
      shape: const CircularNotchedRectangle(),
      notchMargin: 10,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          IconButton(
            icon: const Icon(Icons.home),
            onPressed: () {
              Navigator.pushReplacementNamed(context, '/home');
            },
          ),
          IconButton(
            icon: const Icon(Icons.analytics),
            onPressed: () {
              Navigator.pushReplacementNamed(context, '/analysis');
            },
          ),
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              Navigator.pushReplacementNamed(context, '/settings');
            },
          ),
        ],
      ),
    );
  }
}
