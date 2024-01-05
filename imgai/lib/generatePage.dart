import 'dart:io';
import 'package:flutter/material.dart';
import 'package:share/share.dart';
import 'package:url_launcher/url_launcher.dart';

class GeneratePage extends StatefulWidget {
  const GeneratePage({Key? key}) : super(key: key);

  @override
  _GeneratePageState createState() => _GeneratePageState();
}

class _GeneratePageState extends State<GeneratePage> {
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
      final file = File(selectedPhoto.path);

      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Share Photo'),
            content: const Text('How do you want to share the photo?'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Share.shareFiles([file.path],
                      text: 'Check out this photo: ${selectedPhoto.name}');
                  Navigator.of(context).pop();
                },
                child: const Text('Share via Other Apps'),
              ),
              TextButton(
                onPressed: () async {
                  final url =
                      'whatsapp://send?text=Check out this photo: ${selectedPhoto.name}&file=$file';
                  if (await canLaunch(url)) {
                    await launch(url);
                  } else {
                    print('Could not launch WhatsApp');
                  }
                  Navigator.of(context).pop();
                },
                child: const Text('Share via WhatsApp'),
              ),
            ],
          );
        },
      );
    } else {
      // Handle case when no photo is selected
      // You can show a snackbar or another type of feedback to the user
    }
  }

  void generatePhotos(String prompt) {
    if (prompt.isEmpty) {
      // Handle case when prompt is empty
    } else {
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
      selectedStarCount = selectedPhotosRatings[selectedPhoto] ?? 0;
    });
  }

  void onStarTap(int starCount) {
    setState(() {
      selectedStarCount = starCount.toDouble();
      if (selectedPhotos.isNotEmpty) {
        selectedPhotosRatings[selectedPhotos.first] = selectedStarCount;
      }
    });
  }

  void saveToHistory() {
    if (selectedPhotos.isNotEmpty) {
      selectedPhotosRatings[selectedPhotos.first] = selectedStarCount;
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
                        hintText: 'Enter your prompt...',
                        hintStyle: TextStyle(color: Colors.grey),
                        suffixIcon: Icon(Icons.search, color: Colors.grey),
                      ),
                      onChanged: generatePhotos,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Expanded(
                  child: GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 12.0,
                      mainAxisSpacing: 12.0,
                    ),
                    itemCount: displayedPhotos.length,
                    itemBuilder: (BuildContext context, int index) {
                      final photo = displayedPhotos[index];
                      return InkWell(
                        onTap: () => selectPhoto(photo),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Stack(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(12.0),
                                child: Image.asset(
                                  photo.path,
                                  fit: BoxFit.cover,
                                  width: double.infinity,
                                  height: double.infinity,
                                ),
                              ),
                              if (selectedPhotos.contains(photo))
                                Container(
                                  decoration: BoxDecoration(
                                    color: Colors.black.withOpacity(0.5),
                                    borderRadius: BorderRadius.circular(12.0),
                                  ),
                                ),
                              if (selectedPhotosRatings.containsKey(photo))
                                Positioned(
                                  top: 12.0,
                                  right: 12.0,
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.star,
                                        color: Colors.yellow,
                                        size: 24.0,
                                      ),
                                      const SizedBox(width: 8.0),
                                      Text(
                                        selectedPhotosRatings[photo].toString(),
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16.0,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 20),
                if (selectedPhotos.isNotEmpty)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ElevatedButton(
                        onPressed: () => shareSelectedPhoto(context),
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20.0,
                            vertical: 12.0,
                          ),
                        ),
                        child: const Text(
                          'Share',
                          style: TextStyle(fontSize: 16.0),
                        ),
                      ),
                      Row(
                        children: List.generate(
                          5,
                          (index) => GestureDetector(
                            onTap: () => onStarTap(index + 1),
                            child: Icon(
                              Icons.star,
                              color: (index + 1) <= selectedStarCount
                                  ? Colors.yellow
                                  : Colors.grey,
                              size: 32.0,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class PhotoItem {
  final String name;
  final String path;

  PhotoItem({required this.name, required this.path});
}
