// ignore_for_file: file_names

import 'package:flutter/material.dart';

class GeneratePage extends StatefulWidget {
  const GeneratePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<GeneratePage> {
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

    // Add more photo items here with names and paths
  ];

  List<PhotoItem> displayedPhotos = [];
  List<PhotoItem> selectedPhotos = [];
  TextEditingController promptController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: const Color.fromARGB(
            255, 12, 78, 178), // Dark blue background color
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.only(top: 20, left: 20),
              child: const Text(
                'Prompt here',
                style: TextStyle(fontSize: 20, color: Colors.white),
                textAlign: TextAlign.left,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Container(
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
            ),
            const SizedBox(height: 10),
            SizedBox(
              height: 75,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    for (final photoItem in displayedPhotos)
                      GestureDetector(
                        onTap: () {
                          selectPhoto(photoItem);
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Image.asset(
                            photoItem.path,
                            height: 80,
                            width: 80,
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
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: selectedPhotos.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(left: 80),
                      child: Image.asset(
                        selectedPhotos[index].path,
                        height: 200,
                        width: 200,
                      ),
                    );
                  },
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton.icon(
                  onPressed: () {
                    // Implement your share functionality here
                    // For now, let's print a message
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
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                    child: Text(
                      'Share',
                      style: TextStyle(fontSize: 16),
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
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                    child: Text(
                      'Generate',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ),
                ElevatedButton.icon(
                  onPressed: () {
                    // Implement your download functionality here
                    // For now, let's print a message
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.black,
                    backgroundColor: Colors.white,
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(3.0),
                    ),
                  ),
                  icon: const Icon(Icons.download, size: 20),
                  label: const Padding(
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                    child: Text(
                      'Download',
                      style: TextStyle(fontSize: 16),
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
    });
  }
}

class PhotoItem {
  final String name;
  final String path;

  PhotoItem({required this.name, required this.path});
}
