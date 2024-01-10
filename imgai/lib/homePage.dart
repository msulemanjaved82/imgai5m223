import 'package:flutter/material.dart';

class homeScreen extends StatefulWidget {
  const homeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<homeScreen> {
  final PageController _pageController =
      PageController(initialPage: 1, viewportFraction: 0.7);
  int _currentPage = 1;

  List<String> slideImages = [
    "assets/generatePage/Slide1.jpg",
    "assets/generatePage/Slide2.jpg",
    "assets/generatePage/Slide3.jpg",
  ];

  String discoverGalleryImage = "assets/generatePage/Slide2.jpg";

  final List<Map<String, dynamic>> _options = [
    {
      'label': 'Wallpapers',
      'icon': Icons.wallpaper,
      'gradientColors': [
        const Color.fromARGB(255, 10, 159, 204), // Light Blue
        const Color.fromARGB(255, 4, 62, 98), // Light Blue
      ],
    },
    {
      'label': 'Stock Img',
      'icon': Icons.image,
      'gradientColors': [
        const Color.fromARGB(255, 249, 249, 92), // Light Yellow
        const Color.fromARGB(255, 255, 255, 0), // Light Yellow
      ],
    },
    {
      'label': 'Illustration',
      'icon': Icons.palette,
      'gradientColors': [
        const Color.fromARGB(255, 144, 238, 144), // Light Green
        const Color.fromARGB(255, 50, 205, 50), // Light Green
      ],
    },
    {
      'label': 'Poster',
      'icon': Icons.picture_as_pdf,
      'gradientColors': [
        const Color.fromARGB(255, 255, 182, 193), // Light Pink
        const Color.fromARGB(255, 255, 105, 180), // Light Pink
      ],
    },
    {
      'label': 'Logo',
      'icon': Icons.image_search,
      'gradientColors': [
        const Color.fromARGB(255, 230, 230, 250), // Light Purple
        const Color.fromARGB(255, 148, 87, 235), // Light Purple
      ],
    },
    {
      'label': 'Mobile Icon',
      'icon': Icons.phone_android,
      'gradientColors': [
        const Color.fromARGB(255, 255, 182, 193), // Light Red
        const Color.fromARGB(255, 255, 69, 0), // Light Red
      ],
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color.fromARGB(255, 0, 21, 112),
              Color.fromARGB(255, 13, 29, 42),
              Color.fromARGB(255, 0, 21, 112),
            ],
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: 200,
                padding: const EdgeInsets.all(16),
                child: PageView.builder(
                  controller: _pageController,
                  itemCount: slideImages.length + 2,
                  onPageChanged: (int page) {
                    setState(() {
                      _currentPage = page;
                    });
                  },
                  itemBuilder: (context, index) {
                    return _buildSlides(index);
                  },
                ),
              ),
              Container(
                height: 1,
                width: MediaQuery.of(context).size.width * 0.8,
                color:
                    const Color.fromARGB(255, 255, 255, 255).withOpacity(0.5),
                margin: const EdgeInsets.symmetric(vertical: 20),
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 20),
                padding: const EdgeInsets.all(16),
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                  ),
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: _options.length,
                  itemBuilder: (context, index) {
                    return _buildOption(
                      _options[index]['label'],
                      _options[index]['icon'],
                      gradientColors: _options[index]['gradientColors'],
                    );
                  },
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.3),
                      blurRadius: 5,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
              ),
              Container(
                height: 1,
                width: MediaQuery.of(context).size.width * 0.8,
                color: Colors.white.withOpacity(0.5),
                margin: const EdgeInsets.symmetric(vertical: 20),
              ),
              const Padding(
                padding: EdgeInsets.all(20.0),
                child: Text(
                  'Discover Gallery',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    shadows: [
                      Shadow(
                        color: Colors.black,
                        offset: Offset(2, 2),
                        blurRadius: 2,
                      ),
                    ],
                  ),
                ),
              ),
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 1.5,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                ),
                itemCount: 16,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              GeneratedPage(image: discoverGalleryImage),
                        ),
                      );
                    },
                    child: TweenAnimationBuilder(
                      tween: Tween<double>(begin: 0.8, end: 1.0),
                      duration: const Duration(milliseconds: 300),
                      builder: (context, scale, child) {
                        return Transform.scale(
                          scale: scale,
                          child: Container(
                            padding: const EdgeInsets.all(10.0),
                            margin: const EdgeInsets.all(8.0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: const Color.fromARGB(255, 255, 255, 255),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.3),
                                  blurRadius: 5,
                                  offset: const Offset(0, 3),
                                ),
                              ],
                              image: DecorationImage(
                                image: AssetImage(discoverGalleryImage),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSlides(int index) {
    int pageIndex = index;

    if (index == 0) {
      pageIndex = slideImages.length - 1;
    } else if (index == slideImages.length + 1) {
      pageIndex = 0;
    } else {
      pageIndex = index - 1;
    }

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => GeneratedPage(image: slideImages[pageIndex]),
          ),
        );
      },
      child: TweenAnimationBuilder(
        tween: Tween<double>(begin: 0.8, end: 1.0),
        duration: const Duration(milliseconds: 300),
        builder: (context, scale, child) {
          return Transform.scale(
            scale: scale,
            child: Container(
              width: MediaQuery.of(context).size.width * 0.7,
              height: double.infinity,
              padding: const EdgeInsets.all(0),
              margin: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: const Color.fromARGB(255, 255, 255, 255),
                boxShadow: [
                  BoxShadow(
                    color: const Color.fromARGB(255, 255, 255, 255)
                        .withOpacity(0.3),
                    blurRadius: 5,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Stack(
                children: [
                  Image.asset(
                    slideImages[pageIndex],
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: double.infinity,
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      width: 70,
                      height: 40,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(3),
                        gradient: const LinearGradient(
                          colors: [
                            Color.fromARGB(255, 0, 191, 255),
                            Color.fromARGB(255, 5, 75, 118),
                          ],
                        ),
                      ),
                      child: const Center(
                        child: Text(
                          'Generate',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildOption(
    String label,
    IconData icon, {
    List<Color> gradientColors = const [],
  }) {
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            // Add your onPressed logic here
          },
          child: Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                colors: gradientColors,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.3),
                  blurRadius: 5,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            padding: const EdgeInsets.all(16),
            child: Icon(
              icon,
              size: 30,
              color: Colors.white,
            ),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: const TextStyle(
            color: Colors.white,
            shadows: [
              Shadow(
                color: Colors.black,
                offset: Offset(2, 2),
                blurRadius: 2,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class GeneratedPage extends StatelessWidget {
  final String image;

  const GeneratedPage({Key? key, required this.image}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Generated Page'),
      ),
      body: Center(
        child: GestureDetector(
          onTap: () {
            // Add your onPressed logic here
          },
          child: TweenAnimationBuilder(
            tween: Tween<double>(begin: 0.8, end: 1.0),
            duration: const Duration(milliseconds: 300),
            builder: (context, scale, child) {
              return Transform.scale(
                scale: scale,
                child: Container(
                  padding: const EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: const Color.fromARGB(255, 255, 255, 255),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.3),
                        blurRadius: 5,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Image.asset(
                    image,
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: double.infinity,
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: homeScreen(),
  ));
}
