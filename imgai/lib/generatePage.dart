// ignore_for_file: file_names, depend_on_referenced_packages, deprecated_member_use
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:share/share.dart';
import 'package:url_launcher/url_launcher.dart';

class generatePage extends StatefulWidget {
  const generatePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<generatePage> {
  List<PhotoItem> allPhotos = [
    PhotoItem(name: 'Forest', path: 'assets/forest.jpg'),
    PhotoItem(name: 'Forest', path: 'assets/forest(1).jpg'),
    PhotoItem(name: 'Forest', path: 'assets/forest(2).jpg'),
    PhotoItem(name: 'Forest', path: 'assets/forest(3).jpg'),
    PhotoItem(name: 'Home', path: 'assets/home.jpg'),
    PhotoItem(name: 'Home', path: 'assets/home(1).jpg'),
    PhotoItem(name: 'Home', path: 'assets/home(2).jpg'),
    PhotoItem(name: 'Home', path: 'assets/home(3).jpg'),
    PhotoItem(name: 'animal', path: 'assets/animal(1).jpg'),
    PhotoItem(name: 'animal', path: 'assets/animal(2).jpg'),
    PhotoItem(name: 'animal', path: 'assets/animal(3).jpg'),
    PhotoItem(name: 'animal', path: 'assets/animal(4).jpg'),
    PhotoItem(name: 'mountain', path: 'assets/mountain(1).jpg'),
    PhotoItem(name: 'mountain', path: 'assets/mountain(2).jpg'),
    PhotoItem(name: 'mountain', path: 'assets/mountain(3).jpg'),
    PhotoItem(name: 'mountain', path: 'assets/mountain(4).jpg'),
  ];

  final Map<PhotoItem, double> selectedPhotosRatings = {};
  List<PhotoItem> displayedPhotos = [];
  List<PhotoItem> selectedPhotos = [];
  TextEditingController promptController = TextEditingController();
  double selectedStarCount = 0;

  void shareSelectedPhoto(BuildContext context) {
    if (selectedPhotos.isNotEmpty) {
      final selectedPhoto = selectedPhotos.first;

      // Create a File object for the selected photo
      final file = File(selectedPhoto.path);

      // Show a dialog with sharing options
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.zero,
            ),
            title: const Text('Share Photo'),
            content: const Text('How do you want to share the photo?'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  // Share using the share package
                  Share.shareFiles([file.path],
                      text: 'Check out this photo: ${selectedPhoto.name}');
                  Navigator.of(context).pop(); // Close the dialog
                },
                child: const Text('Share via Other Apps'),
              ),
              TextButton(
                onPressed: () async {
                  // Open WhatsApp using url_launcher
                  final url =
                      'whatsapp://send?text=Check out this photo: ${selectedPhoto.name}&file=$file';
                  if (await canLaunch(url)) {
                    await launch(url);
                  } else {
                    print('Could not launch WhatsApp');
                  }
                  Navigator.of(context).pop(); // Close the dialog
                },
                child: const Text('Share via WhatsApp'),
              ),
              // Add more buttons for other sharing options if needed
            ],
          );
        },
      );
    } else {
      // Handle case when no photo is selected
      // You can show a snackbar or another type of feedback to the user
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromARGB(255, 0, 21, 112),
              Color.fromARGB(255, 13, 29, 42),
              Color.fromARGB(255, 0, 21, 112),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: Container(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Prompt here',
                  style: TextStyle(fontSize: 20, color: Colors.white),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 10),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.4),
                        spreadRadius: 4,
                        blurRadius: 5,
                        offset: const Offset(3, 4),
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: TextFormField(
                      controller: promptController,
                      style: const TextStyle(color: Colors.black),
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Write your prompt here',
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  height: 75,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        for (final photoItem in displayedPhotos)
                          GestureDetector(
                            onTap: () {
                              selectPhoto(photoItem);
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                child: Image.asset(
                                  photoItem.path,
                                  height: 100,
                                  width: 100,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Expanded(
                  child: Center(
                    child: selectedPhotos.isNotEmpty
                        ? Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                child: Image.asset(
                                  selectedPhotos.first.path,
                                  height: 250,
                                  width: 250,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              const SizedBox(height: 10),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  for (int i = 1; i <= 5; i++)
                                    GestureDetector(
                                      onTap: () {
                                        onStarTap(i);
                                      },
                                      child: Icon(
                                        Icons.star,
                                        color: i <= selectedStarCount
                                            ? Colors.yellow
                                            : Colors.grey,
                                      ),
                                    ),
                                ],
                              ),
                            ],
                          )
                        : Container(), // Add an empty container if no photo is selected
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton.icon(
                      onPressed: () {
                        shareSelectedPhoto(context);
                      },
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.black,
                        backgroundColor: Colors.white,
                        elevation: 4,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(3.0),
                        ),
                      ),
                      icon: const Icon(Icons.share, size: 20),
                      label: const Padding(
                        padding: EdgeInsets.all(1),
                        child: Text(
                          'Share',
                          style: TextStyle(fontSize: 13),
                        ),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        generatePhotos(promptController.text);
                      },
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.black,
                        backgroundColor: Colors.white,
                        elevation: 4,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(3.0),
                        ),
                      ),
                      child: const Padding(
                        padding: EdgeInsets.all(1),
                        child: Text(
                          'Generate',
                          style: TextStyle(fontSize: 13),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void generatePhotos(String prompt) {
    if (prompt.isEmpty) {
    } else {
      // Implement your photo generation logic based on the provided prompt
      // For simplicity, I'm filtering photos that contain the prompt in their names
      displayedPhotos = allPhotos
          .where((photo) =>
              photo.name.toLowerCase().contains(prompt.toLowerCase()))
          .toList();
    }

    setState(() {});
  }

  void selectPhoto(PhotoItem selectedPhoto) {
    setState(() {
      selectedPhotos.clear();
      selectedPhotos.add(selectedPhoto);
      selectedStarCount = 0; // Reset star count when a new photo is selected
    });
  }

  void onStarTap(int starCount) {
    setState(() {
      selectedStarCount = starCount.toDouble();
      print('Selected Star Count: $selectedStarCount');
    });
  }
}

class PhotoItem {
  final String name;
  final String path;

  PhotoItem({required this.name, required this.path});
}
