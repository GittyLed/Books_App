import 'package:books_app/Screen/home_page.dart';
import 'package:flutter/material.dart';

import '../Model/model.dart';

class IntroPage extends StatelessWidget{
  final VoidCallback toggleTheme;
  final bool isDarkMode;

  IntroPage({required this.toggleTheme, required this.isDarkMode});
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text("Welcome"),
        centerTitle: true,
        // actions: [
        //   IconButton(
        //     icon: Icon(isDarkMode ? Icons.dark_mode : Icons.light_mode),
        //     onPressed: toggleTheme,
        //   ),
        // ],
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            Text(
              "welcome to the biggest book's app.",
              style: TextStyle(fontSize: 24),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20,),
            Expanded(
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
                itemCount: books.length,
                itemBuilder: (context, index){
                  final book = books[index];
                  return GridTile(
                    child: Image.asset(book.imageURL, fit: BoxFit.cover,),
                    footer: GridTileBar(
                      backgroundColor: Colors.black54,
                      title: Text(book.title, textAlign: TextAlign.center,),
                    ),
                  );
                },
              ),
            ),
            ElevatedButton(
              onPressed: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => HomeScreen(toggleTheme: toggleTheme, isDarkMode: isDarkMode)
                  ),
                );
              },
              child: Text("Go To Home Page"),
            ),
          ],
        ),
      ),
    );
  }
}