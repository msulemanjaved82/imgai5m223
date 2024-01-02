import 'package:flutter/material.dart';
import 'main.dart'; // Import main.dart to access BottomNavigationBarExample

class loginPage extends StatefulWidget {
  @override
  _loginPageState createState() => _loginPageState();
}

class _loginPageState extends State<loginPage> {
  bool rememberMe = false;
  bool showPassword = false;

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
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildLoginForm(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLoginForm(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      margin: EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            padding: EdgeInsets.symmetric(vertical: 16),
            child: Text(
              'Login',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          _buildTextField(label: 'Email', textColor: Colors.white),
          SizedBox(height: 16),
          _buildPasswordField(),
          SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              // Add your login logic here
              _login(context);
            },
            child: Text('Login'),
            style: ElevatedButton.styleFrom(
              primary: Colors.blue,
              onPrimary: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0),
              ),
              elevation: 4,
              minimumSize: Size(double.infinity, 48),
            ),
          ),
          SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Checkbox(
                    value: rememberMe,
                    onChanged: (bool? value) {
                      setState(() {
                        rememberMe = value ?? false;
                      });
                    },
                  ),
                  Text(
                    'Remember me',
                    style: TextStyle(color: Colors.white),
                  ),
                ],
              ),
              MouseRegion(
                onEnter: (event) {
                  // Handle hover
                  print('Hover on Forget Password?');
                },
                child: GestureDetector(
                  onTap: () {
                    // Handle forget password click
                    print('Forget Password?');
                  },
                  child: Text(
                    'Forget Password?',
                    style: TextStyle(
                      color: Colors.blue,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTextField(
      {required String label, Color textColor = Colors.black}) {
    return Container(
      margin: EdgeInsets.only(bottom: 16),
      child: TextField(
        style: TextStyle(color: textColor),
        decoration: InputDecoration(
          labelText: label,
          labelStyle: TextStyle(color: textColor),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
        ),
      ),
    );
  }

  Widget _buildPasswordField() {
    return Container(
      margin: EdgeInsets.only(bottom: 16),
      child: TextField(
        style: TextStyle(color: Colors.white),
        obscureText: !showPassword,
        decoration: InputDecoration(
          labelText: 'Password',
          labelStyle: TextStyle(color: Colors.white),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
          suffixIcon: IconButton(
            icon: Icon(
              showPassword ? Icons.visibility : Icons.visibility_off,
              color: Colors.white,
            ),
            onPressed: () {
              setState(() {
                showPassword = !showPassword;
              });
            },
          ),
        ),
      ),
    );
  }

  void _login(BuildContext context) {
    // Replace this with your actual authentication logic
    // For now, just navigate to the BottomNavigationBarExample
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const BottomNavigationBarExample(),
      ),
    );
  }
}

void main() {
  runApp(
    MaterialApp(
      home: loginPage(),
    ),
  );
}
