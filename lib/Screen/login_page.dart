
import 'package:carousel_slider/carousel_slider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../Model/model.dart';
import 'intro_page.dart';
import 'register_page.dart';

class LoginPage extends StatefulWidget{
  final VoidCallback toggleTheme;
  final bool isDarkMode;
  LoginPage({
    required this.toggleTheme,
    required this.isDarkMode
  });
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginPage> {
  final TextEditingController userNameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final FirebaseAuth auth = FirebaseAuth.instance;
  void login() async{
    try{
      UserCredential userCredential = await auth.signInWithEmailAndPassword(
        email : userNameController.text.trim(),
        password: passwordController.text.trim(),
      );
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => IntroPage(
            isDarkMode: widget.isDarkMode,
            toggleTheme: widget.toggleTheme,
          ),
        ),
      );
    }
    catch(e){
      print("login failed: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Login Failed"),),
      );
    }
  }

  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              buildBooksCarousel(),
              SizedBox(height: 20,),
              buildTextField(userNameController, 'User Name'),
              SizedBox(height: 20),
              buildTextField(passwordController, 'Password',obscureText: true,),
              ElevatedButton(
                onPressed: login,
                child: Text("Login",)
              ),
              TextButton(
                onPressed: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => RegisterPage(
                        isDarkMode: widget.isDarkMode,
                        toggleTheme: widget.toggleTheme,
                      ),
                    ),
                  );
                },
                child: Text("Don't have an account? Register"),
              ),
            ],
          ),
          ),
      ),
    );
  }

  Widget buildTextField(TextEditingController controller, String labelText, {bool obscureText = false,}){
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: labelText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      obscureText: obscureText,
    );
  }

  Widget buildBooksCarousel(){
    return CarouselSlider.builder(
      itemCount: books.length,
      itemBuilder: (context, index, child){
        final book = books[index];
        return buildBookItem(book);
      },
      options: CarouselOptions(
        autoPlay: true,
        enlargeCenterPage: true,
        aspectRatio: 2,
        autoPlayInterval: Duration(seconds: 3),
      ),
    );
  }

  Widget buildBookItem(Book book){
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 5),
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(book.imageURL),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}