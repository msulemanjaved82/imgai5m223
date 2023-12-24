import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  // Define your options data
  List<Map<String, dynamic>> _options = [
    {
      'label': 'Wallpapers',
      'icon': Icons.wallpaper,
      'gradientColors': [
        Color.fromARGB(255, 10, 159, 204), // Light Blue
        Color.fromARGB(255, 4, 62, 98), // Light Blue
      ],
    },
    {
      'label': 'Stock Img',
      'icon': Icons.image,
      'gradientColors': [
        Color.fromARGB(255, 249, 249, 92), // Light Yellow
        Color.fromARGB(255, 255, 255, 0), // Light Yellow
      ],
    },
    {
      'label': 'Illustration',
      'icon': Icons.palette,
      'gradientColors': [
        Color.fromARGB(255, 144, 238, 144), // Light Green
        Color.fromARGB(255, 50, 205, 50), // Light Green
      ],
    },
    {
      'label': 'Poster',
      'icon': Icons.picture_as_pdf,
      'gradientColors': [
        Color.fromARGB(255, 255, 182, 193), // Light Pink
        Color.fromARGB(255, 255, 105, 180), // Light Pink
      ],
    },
    {
      'label': 'Logo',
      'icon': Icons.image_search,
      'gradientColors': [
        Color.fromARGB(255, 230, 230, 250), // Light Purple
        Color.fromARGB(255, 148, 87, 235), // Light Purple
      ],
    },
    {
      'label': 'Mobile Icon',
      'icon': Icons.phone_android,
      'gradientColors': [
        Color.fromARGB(255, 255, 182, 193), // Light Red
        Color.fromARGB(255, 255, 69, 0), // Light Red
      ],
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
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
              // Centered Slide of images with rounded corners and buttons
              Container(
                height: 200,
                padding: EdgeInsets.all(16),
                child: PageView.builder(
                  controller: _pageController,
                  itemCount: 6,
                  onPageChanged: (int page) {
                    setState(() {
                      _currentPage = page;
                    });
                  },
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        // Add your onPressed logic here
                      },
                      child: TweenAnimationBuilder(
                        tween: Tween<double>(begin: 0.8, end: 1.0),
                        duration: Duration(milliseconds: 300),
                        builder: (context, scale, child) {
                          return Transform.scale(
                            scale: scale,
                            child: Container(
                              width: MediaQuery.of(context).size.width * 0.7,
                              padding: EdgeInsets.all(16),
                              margin: EdgeInsets.symmetric(horizontal: 16),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Color.fromARGB(255, 255, 255, 255),
                                boxShadow: [
                                  BoxShadow(
                                    color: Color.fromARGB(255, 255, 255, 255)
                                        .withOpacity(0.3),
                                    blurRadius: 5,
                                    offset: Offset(0, 3),
                                  ),
                                ],
                              ),
                              child: Align(
                                alignment: Alignment.bottomRight,
                                child: Container(
                                  width: 70,
                                  height: 40,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(3),
                                    gradient: LinearGradient(
                                      colors: [
                                        Color.fromARGB(255, 0, 191, 255),
                                        Color.fromARGB(255, 5, 75, 118),
                                      ],
                                    ),
                                  ),
                                  child: Center(
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
                            ),
                          );
                        },
                      ),
                    );
                  },
                ),
              ),

              // Separator
              Container(
                height: 1,
                width: MediaQuery.of(context).size.width * 0.8,
                color: Color.fromARGB(255, 255, 255, 255).withOpacity(0.5),
                margin: EdgeInsets.symmetric(vertical: 20),
              ),

              // Options with circle corner and icon
              Container(
                margin: EdgeInsets.symmetric(vertical: 20),
                padding: EdgeInsets.all(16),
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                  ),
                  physics: NeverScrollableScrollPhysics(),
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
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
              ),

              // Separator
              Container(
                height: 1,
                width: MediaQuery.of(context).size.width * 0.8,
                color: Colors.white.withOpacity(0.5),
                margin: EdgeInsets.symmetric(vertical: 20),
              ),

              // Discover Gallery Heading and 2 x 8 grid
              Padding(
                padding: const EdgeInsets.all(16.0),
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
                physics: NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 1.5,
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 8,
                ),
                itemCount: 16,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      // Add your onPressed logic here
                    },
                    child: TweenAnimationBuilder(
                      tween: Tween<double>(begin: 0.8, end: 1.0),
                      duration: Duration(milliseconds: 300),
                      builder: (context, scale, child) {
                        return Transform.scale(
                          scale: scale,
                          child: Container(
                            padding: const EdgeInsets.all(8.0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Color.fromARGB(255, 255, 255, 255),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.3),
                                  blurRadius: 5,
                                  offset: Offset(0, 3),
                                ),
                              ],
                            ),
                            child: Center(
                              child: Text('Image $index'),
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
                  offset: Offset(0, 3),
                ),
              ],
            ),
            padding: EdgeInsets.all(16),
            child: Icon(
              icon,
              size: 30,
              color: Colors.white,
            ),
          ),
        ),
        SizedBox(height: 8),
        Text(
          label,
          style: TextStyle(
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

  Widget _buildDots() {
    return Positioned(
      bottom: 10,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(
          5,
          (index) => _buildDot(index),
        ),
      ),
    );
  }

  Widget _buildDot(int index) {
    return Container(
      width: 8,
      height: 8,
      margin: EdgeInsets.symmetric(horizontal: 6),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: _currentPage == index
            ? Color.fromARGB(255, 0, 0, 0)
            : Color.fromARGB(255, 0, 0, 0).withOpacity(0.5),
      ),
    );
  }
}
