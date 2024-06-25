import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io'; // Import nécessaire pour File

class ScanScreen extends StatefulWidget {
  const ScanScreen({Key? key}) : super(key: key);

  @override
  _ScanScreenState createState() => _ScanScreenState();
}

class _ScanScreenState extends State<ScanScreen> {
  final ImagePicker _picker = ImagePicker();
  XFile? imageFile;

  void _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
      imageFile = pickedFile;
    });
  }

  void _takePhoto() async {
    final photo = await _picker.pickImage(source: ImageSource.camera);
    setState(() {
      imageFile = photo;
    });
  }

  void processImage() {
    print("Process the image here...");
    // Future logic for processing the image
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
              SizedBox(height: 20),
              if (imageFile == null) ...[
                ElevatedButton(
                  onPressed: _pickImage,
                  child: const Text('Choose from Gallery'),
                ),
                SizedBox(height: 10),
                ElevatedButton(
                  onPressed: _takePhoto,
                  child: const Text('Take a Photo'),
                ),
              ],
              if (imageFile != null)
                ElevatedButton(
                  onPressed: processImage,
                  child: const Text('Scan'),
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
