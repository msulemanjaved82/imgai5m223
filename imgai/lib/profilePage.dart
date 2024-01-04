import 'package:flutter/material.dart';

class profileScreen extends StatefulWidget {
  const profileScreen({Key? key}) : super(key: key);

  @override
  State<profileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<profileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: null, // Set title to null to remove the text
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(0),
          child: Container(),
        ),
      ),
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
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Icon(
                  Icons.account_circle_rounded,
                  size: 30,
                  shadows: [
                    Shadow(
                      color: Color.fromARGB(255, 224, 221, 221), // Shadow color
                      offset: Offset(2, 2), // Shadow offset
                      blurRadius: 2, // Shadow blur radius
                    ),
                  ],
                ),
                Align(
                  alignment: Alignment.center,
                  child: CircleAvatar(
                    // Use a dummy profile picture
                    radius: 50.0,
                    backgroundColor:
                        Colors.transparent, // Make the background transparent
                  ),
                ),
                SizedBox(height: 16.0),

                // User's name
                Center(
                  child: Text(
                    'John Doe',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.white, // Set text color to white
                    ),
                  ),
                ),
                SizedBox(height: 8.0),

                // User's email
                Center(
                  child: Text(
                    'john.doe@example.com',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white, // Set text color to white
                    ),
                  ),
                ),
                SizedBox(height: 16.0),

                // History text and Heart icon
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      ' History',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white, // Set text color to white
                      ),
                    ),
                    Icon(
                      Icons.favorite,
                      color: Colors.red,
                      size: 24,
                    ),
                  ],
                ),
                SizedBox(height: 16.0),

                // Line separator
                Container(
                  height: 2,
                  width: double.infinity,
                  color: Colors.white,
                  margin: EdgeInsets.symmetric(vertical: 16.0),
                ),

                // 2x2 grid of pictures with rounded corners
                GridView.count(
                  crossAxisCount: 2,
                  crossAxisSpacing: 8.0,
                  mainAxisSpacing: 8.0,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  children: List.generate(4, (index) {
                    return Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10.0),
                        child: Image.network(
                          'https://via.placeholder.com/150',
                          fit: BoxFit.cover,
                        ),
                      ),
                    );
                  }),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
