import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'loading_screen.dart';
import 'result_screen.dart';
import 'dart:io';

class ScanScreen extends StatefulWidget {
  const ScanScreen({Key? key}) : super(key: key);

  @override
  _ScanScreenState createState() => _ScanScreenState();
}

class _ScanScreenState extends State<ScanScreen> {
  final ImagePicker _picker = ImagePicker();
  XFile? imageFile;

  void _pickImage() async {
    try {
      final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        setState(() {
          imageFile = pickedFile;
        });
      }
    } catch (e) {
      _showError("Failed to pick image: $e");
    }
  }

  void _takePhoto() async {
    try {
      final photo = await _picker.pickImage(source: ImageSource.camera);
      if (photo != null) {
        setState(() {
          imageFile = photo;
        });
      }
    } catch (e) {
      _showError("Failed to take photo: $e");
    }
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  void processImage() async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return const LoadingScreen();
      },
    );

    // Ici ca aurait été l'appel à l'API hin
    await Future.delayed(const Duration(seconds: 5));

    Navigator.of(context).pop();

    // Ici par exemple on aurait navigué vers la page des résultats hin
    _showResults();
  }

  void _showResults() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const ResultScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Scan'),
        backgroundColor: Colors.teal,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              if (imageFile != null)
                Container(
                  height: 300,
                  width: double.infinity,
                  child: Image.file(File(imageFile!.path), fit: BoxFit.cover),
                ),
              const SizedBox(height: 20),
              if (imageFile == null) ...[
                ElevatedButton(
                  onPressed: _pickImage,
                  child: const Text('Choose from Gallery'),
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: _takePhoto,
                  child: const Text('Take a Photo'),
                ),
              ],
              if (imageFile != null)
                Column(
                  children: [
                    ElevatedButton(
                      onPressed: processImage,
                      child: const Text('Scan'),
                    ),
                    ElevatedButton(
                      onPressed: () => setState(() {
                        imageFile = null;
                      }),
                      child: const Text('Retake Photo'),
                    ),
                  ],
                ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: buildBottomAppBar(context),
    );
  }

  Widget buildBottomAppBar(BuildContext context) {
    return BottomAppBar(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () => _showMenu(context),
          ),
          if (imageFile == null)
            IconButton(
              icon: const Icon(Icons.camera_alt),
              onPressed: _takePhoto,
            ),
          IconButton(
            icon: const Icon(Icons.arrow_back_sharp),
            onPressed: () {
              if (Navigator.canPop(context)) {
                Navigator.pop(context);
              } else {
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
                  Navigator.pushNamed(context, '/settings');
                },
              ),
              ListTile(
                leading: const Icon(Icons.analytics),
                title: const Text('Dernières Analyses'),
                onTap: () {
                  Navigator.pop(context);
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

@override
Widget build(BuildContext context) {
  return const Scaffold(
    body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            'Chargement',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 20),
          CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
          ),
          SizedBox(height: 20),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 40.0),
            child: Text(
              'Patientez le temps que les résultats soient interprétés :)',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
