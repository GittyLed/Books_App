import 'package:flutter/material.dart';

import '../Model/model.dart';
import '../main.dart';
import 'payment_page.dart';

class CartPage extends StatefulWidget {
  cartPageState createState() => cartPageState();
}

class cartPageState extends State<CartPage> {
  void removeFromCart(Book book) {
    setState(() {
      cart.remove(book);
    });
  }

  void clearCart() {
    setState(() {
      cart.clear();
    });
  }

  double calculateTotalPrice() {
    double totalPrice = 0.0;
    for (var book in cart) {
      totalPrice += double.tryParse(book.price) ?? 0.0;
    }
    return totalPrice;
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Cart"),
        actions: [
          IconButton(
            icon: Icon(
              Icons.delete,
              color: Colors.red,
            ),
            onPressed: () => clearCart(),
          ),
        ],
      ),
      body: cart.isEmpty
          ? Center(
              child: Text("your cart is empty"),
            )
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: cart.length,
                    itemBuilder: (context, index) {
                      final book = cart[index];
                      return ListTile(
                        leading: Image.asset(book.imageURL),
                        title: Text('\$' + book.price),
                        subtitle: Text(book.price),
                        trailing: IconButton(
                          icon: Icon(Icons.remove_circle),
                          onPressed: () => removeFromCart(book),
                        ),
                      );
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(8),
                  child: Column(
                    children: [
                      Text(
                        "Total: \$${calculateTotalPrice().toStringAsFixed(2)}",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold
                        ),
                      ),
                      SizedBox(height: 10),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  PaymentPage(onPaymentSuccess: clearCart),
                            ),
                          );
                        },
                        child: Text("Pay Now", style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 18,
                        ),),
                      ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }
}
