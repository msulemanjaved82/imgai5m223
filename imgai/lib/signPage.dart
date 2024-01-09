import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'loginPage.dart';

class signUpScreen extends StatefulWidget {
  const signUpScreen({Key? key}) : super(key: key);

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<signUpScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  // Add a map to store user credentials
  Map<String, String> userCredentials = {};

  String errorMessage = "";

  Future<void> _handleSignUp(BuildContext context) async {
    String username = _usernameController.text;
    String email = _emailController.text;
    String password = _passwordController.text;

    if (username.isEmpty || email.isEmpty || password.isEmpty) {
      setState(() {
        errorMessage = "Please complete all the fields";
      });
      return;
    }

    print('Username: $username, Email: $email, Password: $password');

    // Save user credentials to the map
    userCredentials[email] = password;

    bool signUpSuccessful = true;

    if (signUpSuccessful) {
      // After successful signup, navigate to login page
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => loginPage(userCredentials: userCredentials),
        ),
      );
    } else {
      // Handle unsuccessful sign-up
      print("Sign-up failed");
    }
  }

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
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Create Account',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  shadows: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      spreadRadius: 2,
                      blurRadius: 4,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 16.0),
              _buildInputField('Name', _usernameController),
              SizedBox(height: 16.0),
              _buildInputField('Email', _emailController),
              SizedBox(height: 16.0),
              _buildInputField('Password', _passwordController,
                  isPassword: true),
              SizedBox(height: 8.0),
              if (errorMessage.isNotEmpty)
                Text(
                  errorMessage,
                  style: TextStyle(color: Colors.red),
                ),
              SizedBox(height: 24.0),
              ElevatedButton(
                onPressed: () => _handleSignUp(context),
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 12, horizontal: 48),
                  child: Text(
                    'Sign Up',
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  primary: Color.fromARGB(255, 10, 51, 234),
                  textStyle: TextStyle(fontSize: 18),
                  elevation: 12,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
              ),
              SizedBox(height: 16.0),
              Text(
                'OR',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 16.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildSocialIcon(FontAwesomeIcons.facebook, Colors.blue, 40),
                  _buildSocialIcon(FontAwesomeIcons.google, Colors.blue, 40),
                  _buildSocialIcon(FontAwesomeIcons.instagram, Colors.blue, 40),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInputField(String label, TextEditingController controller,
      {bool isPassword = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        SizedBox(height: 8.0),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: TextField(
              controller: controller,
              obscureText: isPassword,
              decoration: InputDecoration(
                labelText: 'Enter your $label',
                border: InputBorder.none,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSocialIcon(IconData icon, Color color, double size) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4.0),
      child: CircleAvatar(
        backgroundColor: Colors.transparent,
        radius: size,
        child: IconButton(
          icon: FaIcon(icon, color: color, size: size),
          onPressed: () {
            // Handle social sign-up
          },
        ),
      ),
    );
  }
}
