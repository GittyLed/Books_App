import 'package:carousel_slider/carousel_slider.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../Model/model.dart';
import '../Screen/intro_page.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget{
  final VoidCallback toggleTheme;
  final bool isDarkMode;

  RegisterPage({required this.toggleTheme, required this.isDarkMode});

  RegisterPageState createState() => RegisterPageState(); 
}

class RegisterPageState extends State<RegisterPage>{
  final TextEditingController userNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  void register() async {
    try{
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: emailController.text.trim(),
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
      print("registration failed: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Registration Failed"),),
      );
    }
  }

  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text("Register"),
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
              buildTextField(userNameController, "User Name"),
              SizedBox(height: 10,),
              buildTextField(emailController, "Email"),
              SizedBox(height: 10,),
              buildTextField(passwordController, "Password", obscureText: true,),
              SizedBox(height: 10,),
              ElevatedButton(
                onPressed: register,
                child: Text("Register"),
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