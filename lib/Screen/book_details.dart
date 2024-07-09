import 'package:books_app/Screen/cart_page.dart';
import 'package:flutter/material.dart';

import '../Model/model.dart';
import '../main.dart';

class BookDetailsScreen extends StatelessWidget {
  final Book book;
  BookDetailsScreen({required this.book});
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 25,right: 25, top: 50, bottom: 25),
            child: Row(
              children: [
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Container(
                    width: 45,
                    height: 40,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: const Icon(Icons.keyboard_arrow_left, size: 25,
                    color: Colors.black,),
                  ),
                ),
                Spacer(),
                IconButton(
                  icon: Icon(Icons.shopping_cart,),
                  onPressed: () => {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CartPage(),
                      ),
                    ),
                  },
                ),
              ],
            ),
          ),
          Center(
            child: SizedBox(
              height: 300,
              child: Hero(
                tag: book.imageURL,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.asset(book.imageURL, fit: BoxFit.cover,),
                  
                ),
              ),
            ),
          ),
          const SizedBox(height: 30,),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(50),
                  topRight: Radius.circular(50),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(35),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(book.title,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 33,
                        color: Colors.black,
                      ),
                    ),
                    Text(
                      book.author,
                      style: const TextStyle(
                        color: Colors.black45,
                        fontSize: 18,
                      ),
                    ),
                    Text(
                      "\$" + book.price,
                      style: const TextStyle(
                        color: Colors.black45,
                        fontSize: 18,
                      ),
                    ),
                    const SizedBox(height: 25,),
                    const Text(
                      "Book Description",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        fontSize: 25,
                      ),
                    ),
                    Text(
                      book.description,
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        height: 1.5,
                      ),
                    ),
                    SizedBox(height: 20),
                    Center(
                      child: ElevatedButton(
                        onPressed: (){
                          cart.add(book);
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text("${book.title} added to cart",)
                            ),
                          );
                        },
                        child: Text("Add to Cart"),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}