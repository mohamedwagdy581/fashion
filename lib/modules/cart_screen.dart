import 'package:flutter/material.dart';

import '../shared/components/cart_products.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1.0,
        backgroundColor: Colors.pink,
        title: const Text("Cart"),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.search,
            ),
          ),
        ],
      ),
      body: const Padding(
        padding: EdgeInsets.all(15.0),
        child: CartProducts(),
      ),
      bottomNavigationBar: Container(
        color: Colors.white,
        child: Row(
          children: [
            Expanded(child: Row(
              children: const [
                Padding(
                  padding: EdgeInsets.only(left: 20.0),
                  child: Text('Total : '),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 20.0),
                  child: Text('\$320'),
                )
              ],
            ),),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: MaterialButton(
                  onPressed: () {},
                  color: Colors.red,
                  textColor: Colors.white,
                  child: const Text('Check Out',),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
