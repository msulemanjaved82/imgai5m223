import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'dart:typed_data';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

class generatePage extends StatefulWidget {
  const generatePage({Key? key}) : super(key: key);

  @override
  _GeneratePageState createState() => _GeneratePageState();
}

class _GeneratePageState extends State<generatePage> {
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

  List<PhotoItem> displayedPhotos = [];
  List<PhotoItem> selectedPhotos = [];
  TextEditingController promptController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: const Color.fromARGB(255, 12, 78, 178),
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
              height: 120,
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
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(15.0),
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
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: selectedPhotos.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(left: 80),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(15.0),
                        child: Image.asset(
                          selectedPhotos[index].path,
                          height: 200,
                          width: 250, // Increased width for selected photos
                          fit: BoxFit.cover,
                        ),
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
                    downloadSelectedPhoto();
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
      displayedPhotos = allPhotos;
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
    });
  }

  void downloadSelectedPhoto() async {
    if (selectedPhotos.isNotEmpty) {
      final photo = selectedPhotos.first;

      try {
        // Get the image bytes
        Dio dio = Dio();
        Response response = await dio.get(
          photo.path,
          options: Options(responseType: ResponseType.bytes),
        );

        // Save the image to the device
        final directory = await getApplicationDocumentsDirectory();
        File file = File('${directory.path}/${photo.name}.jpg');
        await file.writeAsBytes(Uint8List.fromList(response.data));

        // Show a download successful message
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Download successful!'),
          ),
        );
      } catch (e) {
        print('Error downloading photo: $e');
      }
    }
  }
}

class PhotoItem {
  final String name;
  final String path;

  PhotoItem({required this.name, required this.path});
}
